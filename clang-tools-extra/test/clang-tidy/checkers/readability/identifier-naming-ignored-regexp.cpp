// RUN: %check_clang_tidy %s readability-identifier-naming %t -- \
// RUN:   -config="{CheckOptions: { \
// RUN:     readability-identifier-naming.ParameterCase: CamelCase, \
// RUN:     readability-identifier-naming.ParameterIgnoredRegexp: '^[a-z]{1,2}$', \
// RUN:     readability-identifier-naming.ClassCase: CamelCase, \
// RUN:     readability-identifier-naming.ClassIgnoredRegexp: '^fo$|^fooo$', \
// RUN:     readability-identifier-naming.StructCase: CamelCase, \
// RUN:     readability-identifier-naming.StructIgnoredRegexp: 'sooo|so|soo|$invalidregex[' \
// RUN:  }}"

int testFunc(int a, char **b);
int testFunc(int ab, char **ba);
int testFunc(int abc, char **cba);
// CHECK-MESSAGES: :[[@LINE-1]]:18: warning: invalid case style for parameter 'abc'
// CHECK-MESSAGES: :[[@LINE-2]]:30: warning: invalid case style for parameter 'cba'
// CHECK-FIXES: {{^}}int testFunc(int Abc, char **Cba);{{$}}
int testFunc(int dE, char **eD);
// CHECK-MESSAGES: :[[@LINE-1]]:18: warning: invalid case style for parameter 'dE'
// CHECK-MESSAGES: :[[@LINE-2]]:29: warning: invalid case style for parameter 'eD'
// CHECK-FIXES: {{^}}int testFunc(int DE, char **ED);{{$}}
int testFunc(int Abc, char **Cba);

class fo {
};

class fofo {
  // CHECK-MESSAGES: :[[@LINE-1]]:7: warning: invalid case style for class 'fofo'
  // CHECK-FIXES: {{^}}class Fofo {{{$}}
};

class foo {
  // CHECK-MESSAGES: :[[@LINE-1]]:7: warning: invalid case style for class 'foo'
  // CHECK-FIXES: {{^}}class Foo {{{$}}
};

class fooo {
};

class afooo {
  // CHECK-MESSAGES: :[[@LINE-1]]:7: warning: invalid case style for class 'afooo'
  // CHECK-FIXES: {{^}}class Afooo {{{$}}
};

struct soo {
  // CHECK-MESSAGES: :[[@LINE-1]]:8: warning: invalid case style for struct 'soo'
  // CHECK-FIXES: {{^}}struct Soo {{{$}}
};
