//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// <string>

// template<class charT, class traits, class Allocator>
//   basic_string<charT,traits,Allocator>
//   operator+(charT lhs, const basic_string<charT,traits,Allocator>& rhs); // constexpr since C++20

// template<class charT, class traits, class Allocator>
//   basic_string<charT,traits,Allocator>&&
//   operator+(charT lhs, basic_string<charT,traits,Allocator>&& rhs); // constexpr since C++20

#include <string>
#include <utility>
#include <cassert>

#include "test_macros.h"
#include "min_allocator.h"
#include "asan_testing.h"

template <class S>
TEST_CONSTEXPR_CXX20 void test0(typename S::value_type lhs, const S& rhs, const S& x) {
  assert(lhs + rhs == x);
  LIBCPP_ASSERT(is_string_asan_correct(lhs + rhs));
}

#if TEST_STD_VER >= 11
template <class S>
TEST_CONSTEXPR_CXX20 void test1(typename S::value_type lhs, S&& rhs, const S& x) {
  assert(lhs + std::move(rhs) == x);
}
#endif

template <class S>
TEST_CONSTEXPR_CXX20 void test_string() {
  test0('a', S(""), S("a"));
  test0('a', S("12345"), S("a12345"));
  test0('a', S("1234567890"), S("a1234567890"));
  test0('a', S("12345678901234567890"), S("a12345678901234567890"));
#if TEST_STD_VER >= 11
  test1('a', S(""), S("a"));
  test1('a', S("12345"), S("a12345"));
  test1('a', S("1234567890"), S("a1234567890"));
  test1('a', S("12345678901234567890"), S("a12345678901234567890"));
#endif
}

TEST_CONSTEXPR_CXX20 bool test() {
  test_string<std::string>();
#if TEST_STD_VER >= 11
  test_string<std::basic_string<char, std::char_traits<char>, min_allocator<char> > >();
  test_string<std::basic_string<char, std::char_traits<char>, safe_allocator<char> > >();
#endif

  return true;
}

int main(int, char**) {
  test();
#if TEST_STD_VER > 17
  static_assert(test());
#endif

  return 0;
}
