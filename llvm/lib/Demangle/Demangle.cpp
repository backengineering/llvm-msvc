//===-- Demangle.cpp - Common demangling functions ------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
///
/// \file This file contains definitions of common demangling functions.
///
//===----------------------------------------------------------------------===//

#include "llvm/Demangle/Demangle.h"
#include "llvm/Demangle/StringViewExtras.h"
#include <cstdlib>
#include <string_view>

using llvm::itanium_demangle::starts_with;

/// demangle a string to get the function name.
std::string llvm::demangleGetFunctionName(std::string_view MangledName) {
  std::string DemangledStr = llvm::demangle(MangledName);
  size_t StartIndex = DemangledStr.find("(");
  if (StartIndex != std::string::npos) {
    size_t EndIndex = DemangledStr.rfind(" ", StartIndex);
    if (EndIndex != std::string::npos) {
      DemangledStr =
          DemangledStr.substr(EndIndex + 1, StartIndex - EndIndex - 1);
    }
  }
  return DemangledStr;
}

std::string llvm::demangle(std::string_view MangledName) {
  std::string Result;

  if (nonMicrosoftDemangle(MangledName, Result))
    return Result;

  if (starts_with(MangledName, '_') &&
      nonMicrosoftDemangle(MangledName.substr(1), Result))
    return Result;

  if (char *Demangled = microsoftDemangle(MangledName, nullptr, nullptr)) {
    Result = Demangled;
    std::free(Demangled);
  } else {
    Result = MangledName;
  }
  return Result;
}

static bool isItaniumEncoding(std::string_view S) {
  // Itanium encoding requires 1 or 3 leading underscores, followed by 'Z'.
  return starts_with(S, "_Z") || starts_with(S, "___Z");
}

static bool isRustEncoding(std::string_view S) { return starts_with(S, "_R"); }

static bool isDLangEncoding(std::string_view S) { return starts_with(S, "_D"); }

bool llvm::nonMicrosoftDemangle(std::string_view MangledName,
                                std::string &Result) {
  char *Demangled = nullptr;
  if (isItaniumEncoding(MangledName))
    Demangled = itaniumDemangle(MangledName);
  else if (isRustEncoding(MangledName))
    Demangled = rustDemangle(MangledName);
  else if (isDLangEncoding(MangledName))
    Demangled = dlangDemangle(MangledName);

  if (!Demangled)
    return false;

  Result = Demangled;
  std::free(Demangled);
  return true;
}
