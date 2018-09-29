// Vanity lux address generator
// Copyright (c) 2018 The Luxcore developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#if !defined (__VG_WINGLUE_H__)
#define __VG_WINGLUE_H__

#include <windows.h>
#include <tchar.h>
#include <time.h>

#define INLINE
#define snprintf _snprintf

struct timezone;

extern int gettimeofday(struct timeval *tv, struct timezone *tz);
extern void timeradd(struct timeval *a, struct timeval *b,
		     struct timeval *result);
extern void timersub(struct timeval *a, struct timeval *b,
		     struct timeval *result);

extern TCHAR *optarg;
extern int optind;

extern int getopt(int argc, TCHAR *argv[], TCHAR *optstring);

extern int count_processors(void);

#define PRSIZET "I"

#ifdef __linux__

static inline char *
strtok_r(char *strToken, const char *strDelimit, char **context) {
	return strtok_s(strToken, strDelimit, context);
}

#endif

#endif /* !defined (__VG_WINGLUE_H__) */
