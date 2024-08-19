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

#ifndef SONGIDX_H
#define SONGIDX_H

#if HAVE_CONFIG_H
#  include "config.h"
#else
#  include "vsconfig.h"
#endif

#include "chars.h"

#if defined(HAVE_WCHAR_T) && defined(HAVE_STDINT_H)
#  if defined(HAVE_DLFCN_H) && defined(HAVE_DLOPEN)
#    define ICU 1
#    include <dlfcn.h>
#    define DLSYM dlsym
typedef void * T_LIB;
#  elif HAVE_WINDOWS_H
#    define ICU 1
#    include <windows.h>
#    include <tchar.h>
#    define DLSYM GetProcAddress
typedef HMODULE T_LIB;
#  endif
#endif
#if ICU
#  include <stdint.h>
#  if defined(_MSC_VER)
#    define CCONV __cdecl
#  else
#    define CCONV
#  endif
typedef void * T_COLLATOR;
typedef T_COLLATOR (CCONV *T_COLLOPEN)(const char *, char, void *, int32_t *);
typedef char (CCONV *T_STRCOLL)(T_COLLATOR, const WCHAR *, int32_t,
                                const WCHAR *, int32_t);
#endif

/* A SONGENTRY struct consists of three fields:
 *   title: a string representing the title of the song
 *   num: a string representing the song's number in the book (might be
 *        something like "H10")
 *   linkname: a string denoting the internal hyperlink label for this song
 *   idx: a unique integer key that should be used to sort songs with
 *        identical titles */
typedef struct
{
  WCHAR *title;
  WCHAR *num;
  WCHAR *linkname;
  int idx;
}
SONGENTRY;

/* The following functions are in songsort.c */
extern int init_collator(const char *lname, const char *cname);
extern void skipesc(const WCHAR **p, int stop_on_space, int skipover_groups);
extern int songcmp(const void *s1, const void *s2);
extern int coll(const WCHAR *s1, const WCHAR *s2);

#endif
