#include "llvm/Bitcode/BitcodeAutoGeneratorPass.h"
#include "llvm/Analysis/ModuleSummaryAnalysis.h"
#include "llvm/Bitcode/BitcodeWriter.h"
#include "llvm/IR/PassManager.h"
#include "llvm/InitializePasses.h"
#include "llvm/Pass.h"
#include "llvm/Support/FileSystem.h"
#include "llvm/Support/Path.h"
#include "llvm/Support/ToolOutputFile.h"
#include <iostream>

using namespace llvm;

// Return the path separator based on the operating system
inline const char *
separators(sys::path::Style style = sys::path::Style::native) {
  if (is_style_windows(style))
    return "\\/";
  return "/";
}

// Generate a bitcode file from the LLVM IR module M and save it to the
// specified FolderName directory
void autoGenerateBitCode(Module &M, StringRef FolderName) {

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
  // .bc
  auto SourceFileName = M.getSourceFileName();
  if (auto Idx = SourceFileName.rfind(separators()); Idx != std::string::npos)
    SourceFileName = SourceFileName.substr(Idx + 1);
  auto BCFileName = SourceFileName.substr(0, SourceFileName.rfind(".")) + ".bc";

  // Create and open the output file
  auto CurrentProjectPath(CurrentProjectDir);
  sys::path::append(CurrentProjectPath, BCFileName);

  sys::path::native(CurrentProjectPath);
  std::string BCOutputFile(CurrentProjectPath.begin(),
                           CurrentProjectPath.end());

  std::error_code EC;
  sys::fs::OpenFlags OpenFlags = sys::fs::OF_None;
  std::unique_ptr<ToolOutputFile> Out =
      std::make_unique<ToolOutputFile>(BCOutputFile, EC, OpenFlags);
  if (EC)
    return;

  // Write the LLVM bitcode file to the output file
  raw_pwrite_stream *OS = &Out->os();
  WriteBitcodeToFile(M, *OS);
  Out->keep();
}

// Implementation of the run() function for the BitcodeAutoGeneratorPrePass
// class
PreservedAnalyses BitcodeAutoGeneratorPrePass::run(Module &M,
                                                   ModuleAnalysisManager &AM) {
  if (Enable)
    autoGenerateBitCode(M, "BitcodeAutoGeneratorPre");

  return PreservedAnalyses::all();
  // Return a PreservedAnalyses object that preserves all analysis results
}

// Implementation of the run() function for the BitcodeAutoGeneratorPostPass
// class
PreservedAnalyses BitcodeAutoGeneratorPostPass::run(Module &M,
                                                    ModuleAnalysisManager &AM) {
  if (Enable)
    autoGenerateBitCode(M, "BitcodeAutoGeneratorPost");

  return PreservedAnalyses::all();
  // Return a PreservedAnalyses object that preserves all analysis results
}
