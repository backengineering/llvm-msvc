// RUN: %libomptarget-compile-run-and-check-generic
// RUN: %libomptarget-compileopt-run-and-check-generic

#include <omp.h>
#include <stdio.h>
#include <stdlib.h>

int main() {
  long unsigned **DP = 0;
  int N = 32;
  int Threads = 64;
  int Teams = 10;

#pragma omp target map(from : DP)
  DP = (long unsigned **)malloc(sizeof(long unsigned *) * Threads * Teams);

#pragma omp target teams distribute parallel for num_teams(Teams)              \
    thread_limit(Threads)
  for (int i = 0; i < Threads * Teams; ++i)
    DP[i] = (long unsigned *)malloc(sizeof(long unsigned) * N);

#pragma omp target teams distribute parallel for num_teams(Teams)              \
    thread_limit(Threads)
  for (int i = 0; i < Threads * Teams; ++i) {
    for (int j = 0; j < N; ++j) {
      DP[i][j] = i + j;
    }
  }

  long unsigned s = 0;
#pragma omp target teams distribute parallel for num_teams(Teams)              \
    thread_limit(Threads) reduction(+ : s)
  for (int i = 0; i < Threads * Teams; ++i) {
    for (int j = 0; j < N; ++j) {
      s += DP[i][j];
    }
  }

  // CHECK: Sum: 6860800
  printf("Sum: %li\n", s);
  return 0;
}
