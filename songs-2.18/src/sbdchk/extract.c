/* Copyright (C) 2015 Kevin W. Hamlen
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA  02110-1301, USA.
 *
 * The latest version of this program can be obtained from
 * http://songs.sourceforge.net.
 */

#if HAVE_CONFIG_H
#  include "config.h"
#else
#  include "vsconfig.h"
#endif

#include "sbdchk.h"
#include "chars.h"

#if HAVE_STDIO_H
#  include <stdio.h>
#endif

/* writeword(<file>,<source line no>,<word>)
 *  Write a word extracted from an .sbd source file to a .tex output file.
 *  The word should only be written if it contains a hyphen, since words
 *  without hyphens were not broken by any chord or measure bar that needs
 *  to be checked. The .tex output will look like this:
 *    \message{SBDCHK: 23 hyph-en-ate}
 *    \showhyphens{hyphenate}
 *  This allows the source line number (23) and hyphenation points to be
 *  checked to be reported in the .log file that results from a LaTeX pass
 *  over the resultant .tex file.
 *  Return 1 on success or 0 on failure. */
static int
writeword(fout,line,col,word)
  FILE *fout;
  unsigned int line;
  unsigned int col;
  const WCHAR *word;
{
  const WCHAR *wp;
  if (ws_strchr(word, wc_hyphen) || ws_strchr(word, wc_asterisk))
  {
    if ((ws_fputs(ws_lit("\\message{"), fout) < 0) ||
        (ws_fputs(ws_lit(IDSTRING), fout) < 0) ||
        (ws_fprintf2(fout, ws_lit(" %u %u "), line, col) < 0) ||
        (ws_fputs(word, fout) < 0) ||
        (ws_fputs(ws_lit("}\n\\showhyphens{"), fout) < 0))
      return 0;
    for (wp=word; *wp; ++wp)
      if ((*wp != wc_hyphen) && (*wp != wc_asterisk))
        if (ws_fputc(*wp,fout) == wc_EOF) return 0;
    if (ws_fputs(ws_lit("}\n"), fout) < 0) return 0;
  }
  return 1;
}

/* We count line and column numbers as we scan the .sbd file so as to display
 * them in warnings and error messages reported to the user in phase 2. */
static unsigned int line=1;
static unsigned int col=0;
static unsigned int wordstartcol=0;

/* Macro names contain alphabetic characters. */
#define ISMACROCHAR(c) (wc_isalpha(c))

/* Words contain alphabetic characters and apostrophes. */
#define ISWORDCHAR(c) (wc_isalpha(c) || (c==wc_apostrophe))

/* Read the next character from the file.  If it's a newline, increment the
 * line counter.  If it's the end of the file (or an error) take some
 * corrective action. */
#define IFEOF(f,c) \
  if (((c)=ws_fgetc(f))==wc_newline) { ++line; col=0; } \
  else if (++col, (c)==wc_EOF)

/* Test if it's appropriate to append a hyphen to the word in progress at this
 * point.  Hyphens shouldn't appear at the very beginning of a word, nor should
 * they appear immediately after other hyphens. */
#define hyphenok(p) \
  (((p)>word) && (*((p)-1) != wc_hyphen) && (*((p)-1) != wc_asterisk))

/* Write the word we've just finished scanning to the "fout" file.  Omit
 * trailing hyphens, if any. */
#define COMMITWORD \
  if ((wp>word) && !hyphenok(wp)) --wp; \
  *wp = wc_null; \
  if (firstword) \
  { \
    firstword = 0; \
    if (ws_fputs(hyphcode, fout) < 0) return -2; \
  } \
  if (!writeword(fout,(c==wc_newline) ? (line-1) : line,wordstartcol,word)) \
    return -2; \
  wp = word

/* If we've reached the end of the .log file, output the main body code and
 * terminate. */
#define FINISHTEX return (ws_fputs(bodycode, fout) < 0)

static void
scanarg(fin,c,word)
  FILE *fin;
  WINT *c;
  WCHAR **word;
{
  if (*c == wc_lbrace)
  {
    int braces=1;
    IFEOF(fin,*c) return;
    while (braces)
    {
      if (*c==wc_rbrace) --braces;
      if (*c==wc_lbrace) ++braces;
      if (word) *(*word)++ = *c;
      IFEOF(fin,*c) return;
    }
    if (word) --(*word);
    return;
  }
  else
  {
    if (word) *(*word)++ = *c;
    IFEOF(fin,*c) return;
    return;
  }
}

/* Process a comment appearing in the .sbd file. If the comment begins
 * with HYPCHK: then include whatever comes after it in the .tex file.
 * Return 0 if end-of-file reached; return 1 otherwise. */
static int
process_comment(fin,fout)
  FILE *fin;
  FILE *fout;
{
  const WCHAR *idstr = ws_lit(IDSTRING);
  const WCHAR *idp;
  WINT c;

  /* Skip whitespace. */
  do
  {
    IFEOF(fin,c) return 0;
    if (c==wc_newline) return 1;
  }
  while (wc_isspace(c));

  /* Check to see if comment begins with SBDCHK: */
  for (idp=idstr; *idp != wc_null; ++idp)
  {
    if (c != *idp) break;
    IFEOF(fin,c) return 0;
  }
  if (*idp == wc_null)
  {
    /* If so, copy the remainder into the .tex file. */
    do
    {
      ws_fputc(c,fout);
      IFEOF(fin,c) return 0;
    }
    while (c != wc_newline);
    ws_fputc(c, fout);
    return 1;
  }

  /* Skip to the end of the comment. */
  do
  {
    IFEOF(fin,c) return 0;
  }
  while (c != wc_newline);
  return 1;
}

/* extracthyphens(<infile>,<outfile>)
 *   Read .sbd file <infile> and search for any word in a song verse or lyric
 *   that is broken by a chord or measure bar. For any such word, output LaTeX
 *   code to .tex file <outfile> that will cause LaTeX to print out the valid
 *   hyphenation points for that word.
 *   Return 0 on success or non-zero on failure. */
int
extracthyphens(fin,fout)
  FILE *fin;
  FILE *fout;
{
  WINT c;
  const WCHAR *beginverse=ws_lit("\\beginverse");
  const WCHAR *beginchorus=ws_lit("\\beginchorus");
  const WCHAR *endverse=ws_lit("\\endverse");
  const WCHAR *endchorus=ws_lit("\\endchorus");
  const WCHAR *ch=ws_lit("\\ch");
  const WCHAR *mch=ws_lit("\\mch");
  const WCHAR *vp, *cp, *chp, *mchp;

  /* Just before the first hyphenation check, insert some LaTeX code that will
   * read in a text file named "hyphdict.tex" and add all hyphenated words in
   * that file to LaTeX's hyphenation dictionary (for this run only, not
   * permanently).  Once that's done, ask LaTeX to enter batchmode so that all
   * the hyphenation reports will only show up in the log file, not on the
   * screen. */
  int firstword = 1;
  const WCHAR *hyphcode = ws_lit("\
\\lefthyphenmin=1 \\righthyphenmin=1 \n\
\\newread\\hyphin\n\
\\def\\eof{\\par}\n\
\\newcommand\\hword{}\n\
\\IfFileExists{hyphdict.tex}{\n\
  \\immediate\\openin\\hyphin=hyphdict.tex\n\
  \\loop\n\
    \\hyphenation{\\hword}\n\
    \\immediate\\read\\hyphin to\\hword\n\
  \\ifx\\hword\\eof\\else\\repeat\n\
}{}\n\
\\batchmode\n\n");

  /* The .tex file won't create any real document, so the document
   * body is empty. */
  const WCHAR *bodycode = ws_lit("\n\\begin{document}\n\\end{document}\n");

  WCHAR word[MAXWORDLEN+1], *wp;

  line = 1;
  col = 0;
  IFEOF(fin,c) return 0;

  ws_fputs(ws_lit("\\documentclass{article}\n"), fout);

  for (;;)
  {
    /* Scan the input file until we see a "\beginverse" or "\beginchorus".
     * That's where all the lyrics are. */
    for (vp=beginverse, cp=beginchorus; *vp && *cp; )
    {
      if (c == wc_percent)
      {
        if (!process_comment(fin, fout)) FINISHTEX;
        vp=beginverse;
        cp=beginchorus;
      }
      if (c == *vp) ++vp; else vp=beginverse;
      if (c == *cp) ++cp; else cp=beginchorus;
      IFEOF(fin,c) FINISHTEX;
    }
    if (ISMACROCHAR(c))
    {
      while (ISMACROCHAR(c))
      {
        IFEOF(fin,c) FINISHTEX;
      }
    }
    else
    {
      /* At this point we're inside a verse or chorus. */
      wp = word;
      for (;;)
      {
        if (ISWORDCHAR(c))
        {
          /* Word characters get appended to the current word in progress. */
          if (wp >= word+MAXWORDLEN)
          {
            fprintf(stderr, "sbdchk: maximum word length exceeded\n");
            return -2;
          }
          if (wp==word) wordstartcol = col;
          *wp++ = c;
          IFEOF(fin,c) break;
        }
        else if ((c == wc_pipe) || (c == wc_hat))
        {
          /* Measure bars and replayed chords should be at valid hyphenation
           * points, so append a hyphen to the word in progress. */
          if (hyphenok(wp))
          {
            if (wp >= word+MAXWORDLEN)
            {
              fprintf(stderr, "sbdchk: maximum word length exceeded\n");
              return -2;
            }
            *wp++ = wc_hyphen;
          }
          IFEOF(fin,c) break;
        }
        else if (c == wc_backslash)
        {
          /* A macro is starting. Scan it to see what it is. */
          IFEOF(fin,c)
          {
            fprintf(stderr, "sbdchk: file ended immediately after escape"
                            " character\n");
            return -2;
          }
          if (c == wc_lbrack)
          {
            /* It's a chord macro.  Append a hyphen and skip to the
             * terminating ]. */
            if (hyphenok(wp))
            {
              if (wp >= word+MAXWORDLEN)
              {
                fprintf(stderr, "sbdchk: maximum word length exceeded\n");
                return -2;
              }
              *wp++ = wc_hyphen;
            }
            do
            {
              IFEOF(fin,c)
              {
                fprintf(stderr, "sbdchk: file ended before chord macro was"
                                " completed\n");
                return -2;
              }
            }
            while (c != wc_rbrack);
            IFEOF(fin,c) break;
          }
          else if (!ISMACROCHAR(c))
          {
            /* It's (probably) an accent macro. Skip it and continue the
             * current word. */
            IFEOF(fin,c) break;
          }
          else
          {
            /* It's some other macro. The only interesting ones for us are
             * \endverse, \endchorus, \ch, or \mch, so check for those. */
            for (vp=endverse+1, cp=endchorus+1, chp=ch+1, mchp=mch+1;
                 (vp && *vp) || (cp && *cp) || (chp && *chp) ||
                 (mchp && *mchp); )
            {
              if (vp && (c == *vp)) ++vp; else vp=NULL;
              if (cp && (c == *cp)) ++cp; else cp=NULL;
              if (chp && (c == *chp)) ++chp; else chp=NULL;
              if (mchp && (c == *mchp)) ++mchp; else mchp=NULL;
              IFEOF(fin,c) break;
            }
            if (ISMACROCHAR(c))
            {
              vp=cp=chp=mchp=NULL;
              while (ISMACROCHAR(c)) IFEOF(fin,c) break;
            }
            if ((vp && !*vp) || (cp && !*cp))
              /* It was an \endverse or \endchorus. */
              break;
            if ((chp && !*chp) || (mchp && !*mchp))
            {
              /* It was a \ch or \mch macro. In either case the arguments are
               * {chord}{prehyphen}{posthyphen}{fulltext}. Skip the chord,
               * insert the prehyphen text, then insert an ASTERISK, then the
               * posthyphen text, and finally skip the fulltext. An asterisk is
               * used instead of a hyphen to denote the fact that unlike normal
               * hyphens, this hyphen is allowed to break a ligature. */
              scanarg(fin,&c,NULL);
              scanarg(fin,&c,&wp);
              if (hyphenok(wp))
              {
                if (wp >= word+MAXWORDLEN)
                {
                  fprintf(stderr, "sbdchk: maximum word length exceeded\n");
                  return -2;
                }
                *wp++ = wc_asterisk;
              }
              scanarg(fin,&c,&wp);
              scanarg(fin,&c,NULL);
            }
            else
            {
              /* It was some other macro. Skip over any trailing whitespace and
               * continue scanning the current word. */
              while (wc_isspace(c))
                IFEOF(fin,c) break;
            }
          }
        }
        else
        {
          /* We've reached a word-ending character like a space or
           * punctuation.  Write the word to the output file if it contains
           * any hyphens. */
          if (wp > word)
          {
            COMMITWORD;
          }
          if (c == wc_percent)
          {
            if (!process_comment(fin, fout))
            {
              c=wc_EOF;
              break;
            }
          }
          IFEOF(fin,c) break;
        }
        if (c==wc_EOF) break;
      }
      /* We've just finished a verse or chorus.  If any word was in progress,
       * it is now ended so write it to the output file if it has any hyphens
       * in it.  Then resume scanning for the next verse or chorus. */
      if (wp > word)
      {
        COMMITWORD;
      }
    }
  }
}
