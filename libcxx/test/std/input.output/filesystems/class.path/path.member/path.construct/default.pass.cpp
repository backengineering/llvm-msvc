//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// UNSUPPORTED: c++03, c++11, c++14
// UNSUPPORTED: availability-filesystem-missing

// <filesystem>

// class path

// path() noexcept

#include <filesystem>
#include <type_traits>
#include <cassert>

#include "test_macros.h"
namespace fs = std::filesystem;

int main(int, char**) {
  using namespace fs;
  static_assert(std::is_nothrow_default_constructible<path>::value, "");
  const path p;
  assert(p.empty());

  return 0;
}
