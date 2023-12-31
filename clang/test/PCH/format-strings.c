// RUN: %clang_cc1 -D FOOBAR="\"\"" %s -emit-pch -o %t.pch
// RUN: %clang_cc1 -D FOOBAR="\"\"" %s -include-pch %t.pch

#ifndef HEADER
#define HEADER

extern int printf(const char *restrict, ...);
#define LOG printf(FOOBAR "%f", __LINE__)

#else

void foo(void) {
  LOG;
}

#endif
