//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// UNSUPPORTED: c++03, c++11, c++14
// TODO: Change to XFAIL once https://github.com/llvm/llvm-project/issues/40340 is fixed
// UNSUPPORTED: availability-pmr-missing

// <memory_resource>

// template <class T> class polymorphic_allocator

// polymorphic_allocator
// polymorphic_allocator<T>::select_on_container_copy_construction() const

#include <memory_resource>
#include <cassert>

#include "test_macros.h"

int main(int, char**) {
  typedef std::pmr::polymorphic_allocator<void> A;
  {
    A const a;
    ASSERT_SAME_TYPE(decltype(a.select_on_container_copy_construction()), A);
  }
  {
    std::pmr::memory_resource* mptr = (std::pmr::memory_resource*)42;
    A const a(mptr);
    assert(a.resource() == mptr);
    A const other = a.select_on_container_copy_construction();
    assert(other.resource() == std::pmr::get_default_resource());
    assert(a.resource() == mptr);
  }
  {
    std::pmr::memory_resource* mptr = (std::pmr::memory_resource*)42;
    std::pmr::set_default_resource(mptr);
    A const a(nullptr);
    assert(a.resource() == nullptr);
    A const other = a.select_on_container_copy_construction();
    assert(other.resource() == std::pmr::get_default_resource());
    assert(other.resource() == mptr);
    assert(a.resource() == nullptr);
  }

  return 0;
}
