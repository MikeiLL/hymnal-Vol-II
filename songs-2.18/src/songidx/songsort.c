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

#include "chars.h"
#include "songidx.h"
#include "fileio.h"

static T_COLLATOR collator = NULL;
static T_STRCOLL ucol_strcoll = NULL;

/* icu_import(<lib>,<func_name>)
 *   Get a pointer to function <func_name> within dynamically linked library
 *   <lib>.  The ICU library adopts the peculiar convention of appending an
 *   underscore followed by the library version number to all its exported
 *   symbols (unless manually compiled with --disable-renaming).  We must
 *   therefore try "<func_name>_<version>" if "<func_name>" doesn't exist,
 *   trying every plausible <version> number. This is ridiculously inefficient,
 *   but seems unavoidable until the ICU developers offer a nicer interface. */
static void *
icu_import(icu, fname)
  T_LIB icu;
  const char *fname;
{
  static char ver=0;
  char *buf;
  size_t n;
  void *f;

  if (!ver)
  {
    f = DLSYM(icu, fname);
    if (f) return f;
  }
  f = NULL;
  n = strlen(fname);
  buf = (char *) malloc((n+5)*sizeof(char));
  if (!buf) return NULL;
  strcpy(buf, fname);
  buf[n] = '_';
  if (ver)
  {
    buf[n+1] = '0' + ver/10;
    buf[n+2] = '0' + ver%10;
    buf[n+3] = '\0';
    f = DLSYM(icu, buf);
  }
  else
  {
    for (ver=30; ver<=99; ++ver)
    {
      buf[n+1] = '0' + ver/10;
      if (ver%10 == 0)
      {
        buf[n+2] = '\0';
        f = DLSYM(icu, buf);
        if (f) break;
      }
      if (ver<49)
      {
        buf[n+2] = '_';
        buf[n+3] = '0' + ver%10;
        buf[n+4] = '\0';
      }
      else
      {
        buf[n+2] = '0' + ver%10;
        buf[n+3] = '\0';
      }
      f = DLSYM(icu, buf);
      if (f) break;
    }
  }
  free(buf);
  return f;
}

/* init_collator(<library_name>,<collator_name>)
 *   Dynamically link to the ICU library and initialize a collator specified
 *   by short-name <collator_name>.  Returns 0 on failure and 1 on success. */
int
init_collator(lname, cname)
  const char *lname;
  const char *cname;
{
#if ICU
  T_LIB icu;
  T_COLLOPEN ucol_openFSS;
  int32_t ecode = 0;

#if defined(HAVE_DLFCN_H) && defined(HAVE_DLOPEN)
  icu = dlopen(lname, RTLD_LAZY);
  if (!icu)
  {
    const char *e = dlerror();
    if (e)
      fprintf(stderr, "songidx: error loading ICU library \"%s\": %s\n",
              lname, e);
    else
      fprintf(stderr, "songidx: error loading ICU library \"%s\"\n", lname);
    return 0;
  }
#elif HAVE_WINDOWS_H
  icu = LoadLibrary(lname);
  if (!icu)
  {
    DWORD e = GetLastError();
    LPTSTR buf = NULL;
    if (!FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER |
                       FORMAT_MESSAGE_FROM_SYSTEM |
                       FORMAT_MESSAGE_IGNORE_INSERTS,
                       NULL, e, 0, (LPTSTR) &buf, 0, NULL))
      fprintf(stderr, "songidx: error loading ICU library \"%s\" (code %u)\n",
              lname, e);
    else
      _ftprintf(stderr, _T("songidx: error loading ICU library \"%s\": %s\n"),
                lname, buf);
    return 0;
  }
#endif

  ucol_openFSS = (T_COLLOPEN) icu_import(icu, "ucol_openFromShortString");
  ucol_strcoll = (T_STRCOLL) icu_import(icu, "ucol_strcoll");
  if (!ucol_openFSS || !ucol_strcoll)
  {
    fprintf(stderr, "songidx: ICU library does not support collation\n");
    return 0;
  }

  collator = (*ucol_openFSS)((cname ? cname : ""), 0, NULL, &ecode);
  if (!collator)
  {
    fprintf(stderr, "songidx: invalid collator \"%s\" (code=%u)", cname, ecode);
    return 0;
  }
  return 1;
#else
  fprintf(stderr, "songidx: this installation does not support ICU\n");
  return 0;
#endif
}

/* coll(<string1>,<string2>)
 *   Return 0 if the strings are the same (for sorting purposes), or a negative
 *   number if <string1> should come before <string2>, or a positive number
 *   otherwise.
 */
int
coll(s1,s2)
  const WCHAR *s1;
  const WCHAR *s2;
{
  return collator ? (*ucol_strcoll)(collator,s1,-1,s2,-1) : ws_coll(s1,s2);
}

/* skipesc(<ptr>,<sm_flag>,<group_flag>)
 *   Walk <ptr> past any LaTeX macros or braces until we reach the next "real"
 *   character.  If <sm_flag> is 1, then space macros "\ " cause p to stop on
 *   the space; otherwise they are skipped as macros.  If <group_flag> is 1
 *   then content between (non-escaped) braces is skipped; otherwise braces
 *   are ignored. */
void
skipesc(p, stop_on_space, skipover_groups)
  const WCHAR **p;
  int stop_on_space;
  int skipover_groups;
{
  unsigned int group_depth = 0;

  for (;;)
  {
    if (**p == wc_backslash)
    {
      ++(*p);
      if (stop_on_space && !group_depth && wc_isspace(**p)) return;
      if (wc_isalpha(**p)) {
        while (wc_isalpha(**p)) ++(*p);
        while (wc_isspace(**p)) ++(*p);
      } else if (**p != wc_null) ++(*p);
    }
    else if (**p == wc_lbrace)
    {
      ++(*p);
      if (skipover_groups) ++group_depth;
      while (wc_isspace(**p)) ++(*p);
    }
    else if (**p == wc_rbrace)
    {
      ++(*p);
      if (group_depth) --group_depth;
    }
    else if (group_depth)
      ++(*p);
    else
      break;
  }
}

/* inword(<char>)
 *   Return 0 if <char> is a word-delimiter (for sorting purposes) and 1
 *   otherwise.  Other than TeX macros (which are handled by skipesc above),
 *   words only have alphabetics and apostrophes. */
static int
inword(c)
  WCHAR c;
{
  return (wc_isalpha(c) || (c==wc_apostrophe) || (c==wc_backquote));
}

/* songcmp(<song1>,<song2>)
 *   Return a negative number if <song1> is less than <song2>, a positive
 *   number if <song1> is greater than <song2>, and 0 if <song1> and <song2>
 *   are equal.  The ordering is first by title, then by index.  This function
 *   is suitable for use with qsort(). */
int
songcmp(s1,s2)
  const void *s1;
  const void *s2;
{
  static WCHAR buf1[MAXLINELEN+1], *bp1;
  static WCHAR buf2[MAXLINELEN+1], *bp2;
  const WCHAR *t1 = (*((const SONGENTRY **) s1))->title;
  const WCHAR *t2 = (*((const SONGENTRY **) s2))->title;
  int diff;

  for (;;)
  {
    /* Find the next word or number in each string. */
    skipesc(&t1,0,0);
    while(*t1 && !wc_isalpha(*t1) && !wc_isdigit(*t1))
    {
      ++t1;
      skipesc(&t1,0,0);
    }
    skipesc(&t2,0,0);
    while(*t2 && !wc_isalpha(*t2) && !wc_isdigit(*t2))
    {
      ++t2;
      skipesc(&t2,0,0);
    }

    /* If there is no next word/number in one or both, sort the shorter
     * string before the longer one. */
    if ((*t1==wc_null) || (*t2==wc_null))
    {
      if ((*t1==wc_null) && (*t2==wc_null)) break;
      return (t1!=wc_null) ? 1 : -1;
    }

    /* If one is a number, sort the number before the word.  If both are
     * numbers, sort in numerical order. */
    if (wc_isdigit(*t1) || wc_isdigit(*t2))
    {
      long n1, n2;
      WCHAR *p1, *p2;
      if (!wc_isdigit(*t1)) return 1;
      if (!wc_isdigit(*t2)) return -1;
      n1 = ws_strtol(t1, &p1, 10);
      n2 = ws_strtol(t2, &p2, 10);
      if ((p1>t1) && (p2>t2))
      {
        if (n1 != n2) return n1-n2;
        t1 = p1;
        t2 = p2;
        continue;
      }
      else
      {
        /* In some locales and with some encodings, it is apparently possible
         * for a digit recognized by iswdigit() to NOT be a number recognized
         * by wcstol().  (Why??)  Therefore, we must resort to a lexographical
         * comparison here in order to avoid an infinite loop! */
        if (p1>t1) return -1;
	if (p2>t2) return 1;
        for (bp1=buf1; wc_isdigit(*t1); ) *bp1++ = *t1++;
	for (bp2=buf2; wc_isdigit(*t2); ) *bp2++ = *t2++;
	*bp1 = *bp2 = wc_null;
	diff = coll(buf1,buf2);
	if (diff) return diff;
	continue;
      }
    }

    /* Otherwise, both are words.  Copy the words into scratch buffers,
     * omitting any macros or braces.  Then lexographically compare the buffer
     * contents to determine how the original strings should be sorted. */
    for (bp1=buf1; inword(*t1); skipesc(&t1,1,0)) *bp1++=wc_tolower(*t1++);
    for (bp2=buf2; inword(*t2); skipesc(&t2,1,0)) *bp2++=wc_tolower(*t2++);
    *bp1 = *bp2 = wc_null;
    diff = coll(buf1,buf2);
    if (diff) return diff;
  }

  /* If each corresponding word/number is identical, then sort alternate-
   * form entries (e.g., lyrics) after normal entries (e.g., titles). */
  if (((*((const SONGENTRY **) s1))->title[0] == wc_asterisk)
      && ((*((const SONGENTRY **) s2))->title[0] != wc_asterisk))
    return 1;
  if (((*((const SONGENTRY **) s1))->title[0] != wc_asterisk)
      && ((*((const SONGENTRY **) s2))->title[0] == wc_asterisk))
    return -1;

  /* If everything is the same, sort by the right-hand sides of the index
   * entries (e.g., the song or page numbers). */
  return (*((const SONGENTRY **) s1))->idx - (*((const SONGENTRY **) s2))->idx;
}
