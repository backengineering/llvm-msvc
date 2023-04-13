#include "llvm/IRPrinter/IRAutoGeneratorPass.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/Analysis/ModuleSummaryAnalysis.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/PrintPasses.h"
#include "llvm/Pass.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/FileSystem.h"
#include "llvm/Support/Path.h"
#include "llvm/Support/ToolOutputFile.h"
#include "llvm/Support/raw_ostream.h"
#include <fstream>
#include <iostream>

using namespace llvm;

// Return the path separator based on the operating system
inline const char *
separators(sys::path::Style style = sys::path::Style::native) {
  if (is_style_windows(style))
    return "\\/";
  return "/";
}

// Generate an ir file from the LLVM IR module M and save it to the
// specified FolderName directory
void autoGenerateIR(Module &M, StringRef FolderName) {
  // Get the current working directory
  SmallVector<char, 300> CurrentProjectDir;
  if (auto Error = sys::fs::current_path(CurrentProjectDir)) {
    report_fatal_error(Error.message().c_str());
    return;
  }

  // Append the target directory
  sys::path::append(CurrentProjectDir, FolderName);

  // Create the target directory if it does not exist
  if (auto Error = sys::fs::create_directory(CurrentProjectDir, true)) {
    report_fatal_error(Error.message().c_str());
    return;
  }

  // Append the target triple directory
  sys::path::append(CurrentProjectDir, M.getTargetTriple());

  // Create the target triple directory if it does not exist
  if (auto Error = sys::fs::create_directory(CurrentProjectDir, true)) {
    report_fatal_error(Error.message().c_str());
    return;
  }

  // Get the name of the source file and change its extension from .c/.cpp to
  // .ll
  auto SourceFileName = M.getSourceFileName();
  if (auto Idx = SourceFileName.rfind(separators()); Idx != std::string::npos)
    SourceFileName = SourceFileName.substr(Idx + 1);
  auto IRFileName = SourceFileName.substr(0, SourceFileName.rfind(".")) + ".ll";

  // Create and open the output file
  auto CurrentProjectPath(CurrentProjectDir);
  sys::path::append(CurrentProjectPath, IRFileName);

  // sys::path::native(CurrentProjectPath);
  std::string IROutputFile(CurrentProjectPath.begin(),
                           CurrentProjectPath.end());

  std::error_code EC;
  sys::fs::OpenFlags OpenFlags = sys::fs::OF_Text;
  std::unique_ptr<ToolOutputFile> Out =
      std::make_unique<ToolOutputFile>(IROutputFile, EC, OpenFlags);
  if (EC)
    return;

  // Write the LLVM IR file to the output file
  if (!M.empty()) {
    M.print(Out->os(), nullptr);
  }

  Out->keep();
}

// Implementation of the run() function for the IRAutoGeneratorPrePass
// class
PreservedAnalyses IRAutoGeneratorPrePass::run(Module &M,
                                              ModuleAnalysisManager &AM) {
  if (Enable)
    autoGenerateIR(M, "IRAutoGeneratorPre");

  return PreservedAnalyses::all();
  // Return a PreservedAnalyses object that preserves all analysis results
}

// Implementation of the run() function for the IRAutoGeneratorPostPass
// class
PreservedAnalyses IRAutoGeneratorPostPass::run(Module &M,
                                               ModuleAnalysisManager &AM) {

  if (Enable)
    autoGenerateIR(M, "IRAutoGeneratorPost");

  return PreservedAnalyses::all();
  // Return a PreservedAnalyses object that preserves all analysis results
}
