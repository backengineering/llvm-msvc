// RUN: %clang_cc1 -x objective-c++ -Wno-return-type -fblocks -fms-extensions -rewrite-objc %s -o %t-rw-modern.cpp
// RUN: %clang_cc1 -fsyntax-only -std=gnu++98 -fblocks -Wno-address-of-temporary -D"Class=void*" -D"id=void*" -D"SEL=void*" -D"__declspec(X)=" %t-rw-modern.cpp

void *sel_registerName(const char *);

@interface Foo {
        int a;
        id b;
}
- (void)bar;
- (void)baz:(id)q;
@end

@implementation Foo
static void foo(id bar) {
        int i = ((Foo *)bar)->a;
}

- (void)bar {
        a = 42;
}
- (void)baz:(id)q {
}
@end

