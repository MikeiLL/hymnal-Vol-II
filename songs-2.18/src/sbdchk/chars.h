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

#ifndef CHARS_H
#define CHARS_H

#if HAVE_CONFIG_H
#  include "config.h"
#else
#  include "vsconfig.h"
#endif

#if HAVE_WCHAR_T

#if HAVE_STDLIB_H
#  include <stdlib.h>
#endif
#if HAVE_WCHAR_H
#  include <wchar.h>
#endif
#if HAVE_WCTYPE_H
#  include <wctype.h>
#endif

typedef wchar_t WCHAR;
typedef wint_t WINT;

#define wc_lit(c) (L ## c)
#define wc_isalpha(c) iswalpha((c))
#define wc_isspace(c) iswspace((c))
#define wc_EOF WEOF

#define ws_lit(s) ws_lit2(s)
#define ws_lit2(s) (L ## s)
#define ws_strcpy(p1,p2) wcscpy((p1),(p2))
#define ws_strchr(p,c) wcschr((p),(c))
#define ws_fprintf1(fh,fs,x) fwprintf((fh),(fs),(x))
#define ws_fprintf2(fh,fs,x,y) fwprintf((fh),(fs),(x),(y))
#define ws_fputc(c,fh) fputwc((c),(fh))
#define ws_fputs(s,fh) fputws((s),(fh))
#define ws_fscanf1(fh,fs,x) fwscanf((fh),(fs),(x))
#define ws_fscanf2(fh,fs,x,y) fwscanf((fh),(fs),(x),(y))
#define ws_fscanf3(fh,fs,x,y,z) fwscanf((fh),(fs),(x),(y),(z))
#define ws_fgetc(fh) fgetwc((fh))

#define fmt_sbdline "%u %u %ls"
#define fmt_texline "%*ls %*ls %ls"

#else

#include <ctype.h>
#if HAVE_STRING_H
#  include <string.h>
#elif HAVE_STRINGS_H
#  include <strings.h>
#endif

typedef char WCHAR;
typedef int WINT;

#define wc_lit(c) (c)
#define wc_isalpha(c) isalpha((c))
#define wc_isspace(c) isspace((c))
#define wc_EOF EOF

#define ws_lit(s) (s)
#define ws_strcpy(p1,p2) strcpy((p1),(p2))
#define ws_strchr(p,c) strchr((p),(c))
#define ws_fprintf1(fh,fs,x) fprintf((fh),(fs),(x))
#define ws_fprintf2(fh,fs,x,y) fprintf((fh),(fs),(x),(y))
#define ws_fputc(c,fh) fputc((c),(fh))
#define ws_fputs(s,fh) fputs((s),(fh))
#define ws_fscanf1(fh,fs,x) fscanf((fh),(fs),(x))
#define ws_fscanf2(fh,fs,x,y) fscanf((fh),(fs),(x),(y))
#define ws_fscanf3(fh,fs,x,y,z) fscanf((fh),(fs),(x),(y),(z))
#define ws_fgetc(fh) fgetc((fh))

#define fmt_sbdline "%u %u %s"
#define fmt_texline "%*s %*s %s"

#endif

#define wc_null wc_lit('\0')
#define wc_hyphen wc_lit('-')
#define wc_apostrophe wc_lit('\'')
#define wc_backslash wc_lit('\\')
#define wc_lbrace wc_lit('{')
#define wc_rbrace wc_lit('}')
#define wc_space wc_lit(' ')
#define wc_newline wc_lit('\n')
#define wc_cr wc_lit('\r')
#define wc_asterisk wc_lit('*')
#define wc_pipe wc_lit('|')
#define wc_lbrack wc_lit('[')
#define wc_rbrack wc_lit(']')
#define wc_percent wc_lit('%')
#define wc_hat wc_lit('^')

#endif

