// RUN: %clangxx -frtti -fsanitize=vptr -fno-sanitize-recover=vptr -I%p/Helpers -g %s -fPIC -shared -o %dynamiclib -DBUILD_SO %ld_flags_rpath_so
// RUN: %clangxx -frtti -fsanitize=vptr -fno-sanitize-recover=vptr -I%p/Helpers -g %s -O3 -o %t %ld_flags_rpath_exe
// RUN: %run %t
//
// REQUIRES: cxxabi
// FIXME: Should pass on Android, but started failing around 2023-11-05 for unknown reasons.
// UNSUPPORTED: target={{.*(windows|android).*}}

struct X {
  virtual ~X() {}
};
X *libCall();

#ifdef BUILD_SO

X *libCall() {
  return new X;
}

#else

int main() {
  X *px = libCall();
  delete px;
}

#endif
