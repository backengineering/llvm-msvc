//===-- CommandObjectSource.h -----------------------------------*- C++-*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLDB_SOURCE_COMMANDS_COMMANDOBJECTSOURCE_H
#define LLDB_SOURCE_COMMANDS_COMMANDOBJECTSOURCE_H

#include "lldb/Interpreter/CommandObjectMultiword.h"

namespace lldb_private {

class CommandObjectMultiwordSource : public CommandObjectMultiword {
public:
  CommandObjectMultiwordSource(CommandInterpreter &interpreter);

  ~CommandObjectMultiwordSource() override;
};

} // namespace lldb_private

#endif // LLDB_SOURCE_COMMANDS_COMMANDOBJECTSOURCE_H
