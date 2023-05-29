# `llvm-msvc`
[![llvm-msvc-build](https://github.com/NewWorldComingSoon/llvm-msvc/actions/workflows/llvm-msvc-build.yml/badge.svg?branch=dev)](https://github.com/NewWorldComingSoon/llvm-msvc/actions/workflows/llvm-msvc-build.yml)
[![GitHub license](https://img.shields.io/github/license/NewWorldComingSoon/llvm-msvc)](https://github.com/NewWorldComingSoon/llvm-msvc/blob/main/LICENSE)

[![Github All Releases](https://img.shields.io/github/downloads/NewWorldComingSoon/llvm-msvc/total.svg)](https://github.com/NewWorldComingSoon/llvm-msvc/releases) 
[![GitHub release](https://img.shields.io/github/release/NewWorldComingSoon/llvm-msvc.svg)](https://github.com/NewWorldComingSoon/llvm-msvc/releases) 

## Why do we make this project?
Because there are more hacky operations, a lot of code can not be submitted directly to the official. So there is this branch.

We want to use clang/llvm as comfortable as msvc.

## How to compile?

```batch
X86：clang+lld+debug
    
mkdir build-debug-64
pushd build-debug-64
cmake .. -G "Visual Studio 17 2022" -A X64 -DLLVM_ENABLE_PROJECTS="clang;lld" -DCMAKE_INSTALL_PREFIX=E:\llvm\install-debug-64 -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_BUILD_TYPE=Debug ../llvm
msbuild /m -p:Configuration=Debug INSTALL.vcxproj

or
cmake -Bbuild -A X64 -DLLVM_ENABLE_PROJECTS="clang;lld" -DCMAKE_INSTALL_PREFIX=E:\llvm\install-debug-64 -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_BUILD_TYPE=Debug llvm


X86：clang+lld+RelWithDebInfo

mkdir build-RelWithDebInfo-64
pushd build-RelWithDebInfo-64
cmake .. -G "Visual Studio 17 2022" -A X64 -DLLVM_ENABLE_PROJECTS="clang;lld" -DCMAKE_INSTALL_PREFIX=E:\llvm\install-RelWithDebInfo-64 -DLLVM_ENABLE_LIBXML2=OFF -DLLVM_ENABLE_ZLIB=OFF -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_BUILD_TYPE=RelWithDebInfo -DLLVM_USE_CRT_RELEASE=MT ../llvm
msbuild /m -p:Configuration=RelWithDebInfo INSTALL.vcxproj 

X86：clang+lld+release

mkdir build-release-64
pushd build-release-64
cmake .. -G "Visual Studio 17 2022" -A X64 -DLLVM_ENABLE_PROJECTS="clang;lld" -DCMAKE_INSTALL_PREFIX=E:\llvm\install-release-64 -DLLVM_ENABLE_LIBXML2=OFF -DLLVM_ENABLE_ZLIB=OFF -DLLVM_TARGETS_TO_BUILD=X86 -DCMAKE_BUILD_TYPE=release -DLLVM_USE_CRT_RELEASE=MT ../llvm
msbuild /m -p:Configuration=release INSTALL.vcxproj 
```

## Quickstart
- https://github.com/NewWorldComingSoon/llvm-msvc-build

## How to contribute?
- https://github.com/HyunCafe/contribute-practice
- https://docs.github.com/en/get-started/quickstart/contributing-to-projects

## Learning
If you don't know how to learn LLVM, you can check out this [repository](https://github.com/gmh5225/awesome-llvm-security) of mine.

## Issues
If you have any questions, please tell me or send [issues](https://github.com/NewWorldComingSoon/llvm-msvc-issues/issues)

