// RUN: %clang_cc1 -fsyntax-only -x objective-c++ -fobjc-arc -verify -Wno-objc-root-class %s

typedef struct __attribute__ ((objc_bridge(NSError))) __CFErrorRef * CFErrorRef; // expected-note 5 {{declared here}}

typedef struct __attribute__ ((objc_bridge(MyError))) __CFMyErrorRef * CFMyErrorRef; // expected-note 1 {{declared here}}

typedef struct __attribute__((objc_bridge(12))) __CFMyColor  *CFMyColorRef; // expected-error {{parameter of 'objc_bridge' attribute must be a single name of an Objective-C class}}

typedef struct __attribute__ ((objc_bridge)) __CFArray *CFArrayRef; // expected-error {{'objc_bridge' attribute takes one argument}}

typedef struct __attribute__((objc_bridge(NSLocale, NSError))) __CFLocale *CFLocaleRef;// expected-error {{use of undeclared identifier 'NSError'}}

typedef struct __attribute__((objc_bridge(NSDictionary))) __CFDictionary * CFDictionaryRef;

typedef union __attribute__((objc_bridge(NSUColor))) __CFUPrimeColor XXX;
typedef XXX *CFUColor2Ref;

@interface I
{
}
@end

@protocol NSTesting @end
@class NSString;

typedef struct __attribute__((objc_bridge(NSTesting))) __CFError *CFTestingRef; // expected-note {{declared here}}

id Test1(CFTestingRef cf) {
  return (NSString *)cf; // expected-error {{CF object of type 'CFTestingRef' (aka '__CFError *') is bridged to 'NSTesting', which is not an Objective-C class}} \
                         // expected-error {{cast of C pointer type 'CFTestingRef' (aka '__CFError *') to Objective-C pointer type 'NSString *' requires a bridged cast}} \
                         // expected-note {{use __bridge to convert directly (no change in ownership)}} \
                         // expected-note {{use __bridge_transfer to transfer ownership of a +1 'CFTestingRef' (aka '__CFError *') into ARC}}
}

typedef CFErrorRef CFErrorRef1;

typedef CFErrorRef1 CFErrorRef2; // expected-note 2 {{declared here}}

@protocol P1 @end
@protocol P2 @end
@protocol P3 @end
@protocol P4 @end
@protocol P5 @end

@interface NSError<P1, P2, P3> @end // expected-note 5 {{declared here}}

@interface MyError : NSError // expected-note 1 {{declared here}}
@end

@interface NSUColor @end

@class NSString;

void Test2(CFErrorRef2 cf, NSError *ns, NSString *str, Class c, CFUColor2Ref cf2) {
  (void)(NSString *)cf; // expected-warning {{'CFErrorRef2' (aka '__CFErrorRef *') bridges to NSError, not 'NSString'}} \
                        // expected-error {{cast of C pointer type 'CFErrorRef2' (aka '__CFErrorRef *') to Objective-C pointer type 'NSString *' requires a bridged cast}} \
                        // expected-note {{__bridge to convert directly (no change in ownership)}} \
                        // expected-note {{use __bridge_transfer to transfer ownership of a +1 'CFErrorRef2' (aka '__CFErrorRef *') into ARC}}
  (void)(NSError *)cf; // expected-error {{cast of C pointer type 'CFErrorRef2' (aka '__CFErrorRef *') to Objective-C pointer type 'NSError *' requires a bridged cast}} \
                       // expected-note {{use __bridge to convert directly (no change in ownership)}} \
                       // expected-note {{use __bridge_transfer to transfer ownership of a +1 'CFErrorRef2' (aka '__CFErrorRef *') into ARC}}
  (void)(MyError*)cf; // expected-error {{cast of C pointer type 'CFErrorRef2' (aka '__CFErrorRef *') to Objective-C pointer type 'MyError *' requires a bridged cast}} \
                        // expected-note {{__bridge to convert directly (no change in ownership)}} \
                        // expected-note {{use __bridge_transfer to transfer ownership of a +1 'CFErrorRef2' (aka '__CFErrorRef *') into ARC}} \
			// expected-warning {{'CFErrorRef2' (aka '__CFErrorRef *') bridges to NSError, not 'MyError'}}
  (void)(NSUColor *)cf2; // expected-error {{cast of C pointer type 'CFUColor2Ref' (aka '__CFUPrimeColor *') to Objective-C pointer type 'NSUColor *' requires a bridged cast}} \
                         // expected-note {{use __bridge to convert directly (no change in ownership)}} \
                         // expected-note {{use __bridge_transfer to transfer ownership of a +1 'CFUColor2Ref' (aka '__CFUPrimeColor *') into ARC}}
  (void)(CFErrorRef)ns; // expected-error {{cast of Objective-C pointer type 'NSError *' to C pointer type 'CFErrorRef' (aka '__CFErrorRef *') requires a bridged cast}} \
                        // expected-note {{use __bridge to convert directly (no change in ownership)}} \
 			// expected-note {{use __bridge_retained to make an ARC object available as a +1 'CFErrorRef' (aka '__CFErrorRef *')}}
  (void)(CFErrorRef)str;  // expected-warning {{'NSString' cannot bridge to 'CFErrorRef' (aka '__CFErrorRef *')}} \\
                          // expected-error {{cast of Objective-C pointer type 'NSString *' to C pointer type 'CFErrorRef' (aka '__CFErrorRef *') requires a bridged cast}} \
                        // expected-note {{use __bridge to convert directly (no change in ownership)}} \
 			// expected-note {{use __bridge_retained to make an ARC object available as a +1 'CFErrorRef' (aka '__CFErrorRef *')}}
  (void)(Class)cf; // expected-warning {{'CFErrorRef2' (aka '__CFErrorRef *') bridges to NSError, not 'Class'}} \\
                   // expected-error {{cast of C pointer type 'CFErrorRef2' (aka '__CFErrorRef *') to Objective-C pointer type 'Class' requires a bridged cast}} \
 			// expected-note {{use __bridge to convert directly (no change in ownership)}} \
			// expected-note {{use __bridge_transfer to transfer ownership of a +1 'CFErrorRef2' (aka '__CFErrorRef *') into ARC}}
  (void)(CFErrorRef)c; // expected-warning {{'__unsafe_unretained Class' cannot bridge to 'CFErrorRef' (aka '__CFErrorRef *')}} \
                       // expected-error {{cast of Objective-C pointer type 'Class' to C pointer type 'CFErrorRef' (aka '__CFErrorRef *') requires a bridged cast}} \
			// expected-note {{use __bridge to convert directly (no change in ownership)}} \
			// expected-note {{use __bridge_retained to make an ARC object available as a +1 'CFErrorRef' (aka '__CFErrorRef *')}}
}


void Test3(CFErrorRef cf, NSError *ns) {
  (void)(id)cf; // expected-error {{cast of C pointer type 'CFErrorRef' (aka '__CFErrorRef *') to Objective-C pointer type 'id' requires a bridged cast}} \
		// expected-note {{use __bridge to convert directly (no change in ownership)}} \
		// expected-note {{use __bridge_transfer to transfer ownership of a +1 'CFErrorRef' (aka '__CFErrorRef *') into ARC}}
 (void)(id<P1, P2>)cf; // expected-error {{cast of C pointer type 'CFErrorRef' (aka '__CFErrorRef *') to Objective-C pointer type 'id<P1,P2>' requires a bridged cast}} \
		// expected-note {{use __bridge to convert directly (no change in ownership)}} \
		// expected-note {{use __bridge_transfer to transfer ownership of a +1 'CFErrorRef' (aka '__CFErrorRef *') into ARC}}
 (void)(id<P1, P2, P4>)cf; // expected-warning {{'CFErrorRef' (aka '__CFErrorRef *') bridges to NSError, not 'id<P1,P2,P4>'}} \
                           // expected-error {{cast of C pointer type 'CFErrorRef' (aka '__CFErrorRef *') to Objective-C pointer type 'id<P1,P2,P4>' requires a bridged cast}} \
		// expected-note {{use __bridge to convert directly (no change in ownership)}} \
		// expected-note {{use __bridge_transfer to transfer ownership of a +1 'CFErrorRef' (aka '__CFErrorRef *') into ARC}}
}

void Test4(CFMyErrorRef cf) {
   (void)(id)cf; // expected-error {{cast of C pointer type 'CFMyErrorRef' (aka '__CFMyErrorRef *') to Objective-C pointer type 'id' requires a bridged cast}} \
			// expected-note {{use __bridge to convert directly (no change in ownership)}} \
			// expected-note {{use __bridge_transfer to transfer ownership of a +1 'CFMyErrorRef' (aka '__CFMyErrorRef *') into ARC}}
 (void)(id<P1, P2>)cf; // expected-error {{cast of C pointer type 'CFMyErrorRef' (aka '__CFMyErrorRef *') to Objective-C pointer type 'id<P1,P2>' requires a bridged cast}} \
			// expected-note {{use __bridge to convert directly (no change in ownership)}} \
			// expected-note {{use __bridge_transfer to transfer ownership of a +1 'CFMyErrorRef' (aka '__CFMyErrorRef *') into ARC}}
 (void)(id<P1, P2, P3>)cf; // expected-error {{cast of C pointer type 'CFMyErrorRef' (aka '__CFMyErrorRef *') to Objective-C pointer type 'id<P1,P2,P3>' requires a bridged cast}} \
			// expected-note {{use __bridge to convert directly (no change in ownership)}} \
			// expected-note {{use __bridge_transfer to transfer ownership of a +1 'CFMyErrorRef' (aka '__CFMyErrorRef *') into ARC}}
 (void)(id<P2, P3>)cf; // expected-error {{cast of C pointer type 'CFMyErrorRef' (aka '__CFMyErrorRef *') to Objective-C pointer type 'id<P2,P3>' requires a bridged cast}} \
			// expected-note {{use __bridge to convert directly (no change in ownership)}} \
			// expected-note {{use __bridge_transfer to transfer ownership of a +1 'CFMyErrorRef' (aka '__CFMyErrorRef *') into ARC}}
 (void)(id<P1, P2, P4>)cf; // expected-warning {{'CFMyErrorRef' (aka '__CFMyErrorRef *') bridges to MyError, not 'id<P1,P2,P4>'}} \
                           // expected-error {{cast of C pointer type 'CFMyErrorRef' (aka '__CFMyErrorRef *') to Objective-C pointer type 'id<P1,P2,P4>' requires a bridged cast}} \
				// expected-note {{use __bridge to convert directly (no change in ownership)}} \
				// expected-note {{use __bridge_transfer to transfer ownership of a +1 'CFMyErrorRef' (aka '__CFMyErrorRef *') into ARC}}
}

void Test5(id<P1, P2, P3> P123, id ID, id<P1, P2, P3, P4> P1234, id<P1, P2> P12, id<P2, P3> P23) {
 (void)(CFErrorRef)ID; // expected-error {{cast of Objective-C pointer type 'id' to C pointer type 'CFErrorRef' (aka '__CFErrorRef *') requires a bridged cast}} \
			// expected-note {{use __bridge to convert directly (no change in ownership)}} \
			// expected-note {{use __bridge_retained to make an ARC object available as a +1 'CFErrorRef' (aka '__CFErrorRef *')}}
 (void)(CFErrorRef)P123; // expected-error {{cast of Objective-C pointer type 'id<P1,P2,P3>' to C pointer type 'CFErrorRef' (aka '__CFErrorRef *') requires a bridged cast}} \
			// expected-note {{use __bridge to convert directly (no change in ownership)}} \
			// expected-note {{use __bridge_retained to make an ARC object available as a +1 'CFErrorRef' (aka '__CFErrorRef *')}}
 (void)(CFErrorRef)P1234; // expected-error {{cast of Objective-C pointer type 'id<P1,P2,P3,P4>' to C pointer type 'CFErrorRef' (aka '__CFErrorRef *') requires a bridged cast}} \
			// expected-note {{use __bridge to convert directly (no change in ownership)}} \
			// expected-note {{use __bridge_retained to make an ARC object available as a +1 'CFErrorRef' (aka '__CFErrorRef *')}}
 (void)(CFErrorRef)P12; // expected-error {{cast of Objective-C pointer type 'id<P1,P2>' to C pointer type 'CFErrorRef' (aka '__CFErrorRef *') requires a bridged cast}} \
			// expected-note {{use __bridge to convert directly (no change in ownership)}} \
			// expected-note {{use __bridge_retained to make an ARC object available as a +1 'CFErrorRef' (aka '__CFErrorRef *')}}
 (void)(CFErrorRef)P23; // expected-error {{cast of Objective-C pointer type 'id<P2,P3>' to C pointer type 'CFErrorRef' (aka '__CFErrorRef *') requires a bridged cast}} \
			// expected-note {{use __bridge to convert directly (no change in ownership)}} \
			// expected-note {{use __bridge_retained to make an ARC object available as a +1 'CFErrorRef' (aka '__CFErrorRef *')}}
}

void Test6(id<P1, P2, P3> P123, id ID, id<P1, P2, P3, P4> P1234, id<P1, P2> P12, id<P2, P3> P23) {

 (void)(CFMyErrorRef)ID; // expected-error {{cast of Objective-C pointer type 'id' to C pointer type 'CFMyErrorRef' (aka '__CFMyErrorRef *') requires a bridged cast}} \
				// expected-note {{use __bridge to convert directly (no change in ownership)}} \
				// expected-note {{use __bridge_retained to make an ARC object available as a +1 'CFMyErrorRef' (aka '__CFMyErrorRef *')}}
 (void)(CFMyErrorRef)P123; // expected-error {{cast of Objective-C pointer type 'id<P1,P2,P3>' to C pointer type 'CFMyErrorRef' (aka '__CFMyErrorRef *') requires a bridged cast}} \
				// expected-note {{use __bridge to convert directly (no change in ownership)}} \
				// expected-note {{use __bridge_retained to make an ARC object available as a +1 'CFMyErrorRef' (aka '__CFMyErrorRef *')}}
 (void)(CFMyErrorRef)P1234; // expected-error {{cast of Objective-C pointer type 'id<P1,P2,P3,P4>' to C pointer type 'CFMyErrorRef' (aka '__CFMyErrorRef *') requires a bridged cast}} \
				// expected-note {{use __bridge to convert directly (no change in ownership)}} \
				// expected-note {{use __bridge_retained to make an ARC object available as a +1 'CFMyErrorRef' (aka '__CFMyErrorRef *')}}
 (void)(CFMyErrorRef)P12; // expected-error {{cast of Objective-C pointer type 'id<P1,P2>' to C pointer type 'CFMyErrorRef' (aka '__CFMyErrorRef *') requires a bridged cast}} \
				// expected-note {{use __bridge to convert directly (no change in ownership)}} \
				// expected-note {{use __bridge_retained to make an ARC object available as a +1 'CFMyErrorRef' (aka '__CFMyErrorRef *')}}
 (void)(CFMyErrorRef)P23; // expected-error {{cast of Objective-C pointer type 'id<P2,P3>' to C pointer type 'CFMyErrorRef' (aka '__CFMyErrorRef *') requires a bridged cast}} \
				// expected-note {{use __bridge to convert directly (no change in ownership)}} \
				// expected-note {{use __bridge_retained to make an ARC object available as a +1 'CFMyErrorRef' (aka '__CFMyErrorRef *')}}
}

typedef struct __attribute__ ((objc_bridge(MyPersonalError))) __CFMyPersonalErrorRef * CFMyPersonalErrorRef;  // expected-note 1 {{declared here}}

@interface MyPersonalError : NSError <P4> // expected-note 1 {{declared here}}
@end

void Test7(id<P1, P2, P3> P123, id ID, id<P1, P2, P3, P4> P1234, id<P1, P2> P12, id<P2, P3> P23) {
 (void)(CFMyPersonalErrorRef)ID; // expected-error {{cast of Objective-C pointer type 'id' to C pointer type 'CFMyPersonalErrorRef' (aka '__CFMyPersonalErrorRef *') requires a bridged cast}} \
				 // expected-note {{use __bridge to convert directly (no change in ownership)}} \
				 // expected-note {{use __bridge_retained to make an ARC object available as a +1 'CFMyPersonalErrorRef' (aka '__CFMyPersonalErrorRef *')}}
 (void)(CFMyPersonalErrorRef)P123; // expected-error {{cast of Objective-C pointer type 'id<P1,P2,P3>' to C pointer type 'CFMyPersonalErrorRef' (aka '__CFMyPersonalErrorRef *') requires a bridged cast}} \
				 // expected-note {{use __bridge to convert directly (no change in ownership)}} \
				 // expected-note {{use __bridge_retained to make an ARC object available as a +1 'CFMyPersonalErrorRef' (aka '__CFMyPersonalErrorRef *')}}
 (void)(CFMyPersonalErrorRef)P1234; // expected-error {{cast of Objective-C pointer type 'id<P1,P2,P3,P4>' to C pointer type 'CFMyPersonalErrorRef' (aka '__CFMyPersonalErrorRef *') requires a bridged cast}} \
				 // expected-note {{use __bridge to convert directly (no change in ownership)}} \
				 // expected-note {{use __bridge_retained to make an ARC object available as a +1 'CFMyPersonalErrorRef' (aka '__CFMyPersonalErrorRef *')}}
 (void)(CFMyPersonalErrorRef)P12; // expected-error {{cast of Objective-C pointer type 'id<P1,P2>' to C pointer type 'CFMyPersonalErrorRef' (aka '__CFMyPersonalErrorRef *') requires a bridged cast}} \
				 // expected-note {{use __bridge to convert directly (no change in ownership)}} \
				 // expected-note {{use __bridge_retained to make an ARC object available as a +1 'CFMyPersonalErrorRef' (aka '__CFMyPersonalErrorRef *')}}
 (void)(CFMyPersonalErrorRef)P23; // expected-error {{cast of Objective-C pointer type 'id<P2,P3>' to C pointer type 'CFMyPersonalErrorRef' (aka '__CFMyPersonalErrorRef *') requires a bridged cast}} \
				 // expected-note {{use __bridge to convert directly (no change in ownership)}} \
				 // expected-note {{use __bridge_retained to make an ARC object available as a +1 'CFMyPersonalErrorRef' (aka '__CFMyPersonalErrorRef *')}}
}

void Test8(CFMyPersonalErrorRef cf) {
  (void)(id)cf; // expected-error {{cast of C pointer type 'CFMyPersonalErrorRef' (aka '__CFMyPersonalErrorRef *') to Objective-C pointer type 'id' requires a bridged cast}} \
		// expected-note {{use __bridge to convert directly (no change in ownership)}} \
		// expected-note {{use __bridge_transfer to transfer ownership of a +1 'CFMyPersonalErrorRef' (aka '__CFMyPersonalErrorRef *') into ARC}}
  (void)(id<P1>)cf; // expected-error {{cast of C pointer type 'CFMyPersonalErrorRef' (aka '__CFMyPersonalErrorRef *') to Objective-C pointer type 'id<P1>' requires a bridged cast}} \
		// expected-note {{use __bridge to convert directly (no change in ownership)}} \
		// expected-note {{use __bridge_transfer to transfer ownership of a +1 'CFMyPersonalErrorRef' (aka '__CFMyPersonalErrorRef *') into ARC}}
  (void)(id<P1, P2>)cf; // expected-error {{cast of C pointer type 'CFMyPersonalErrorRef' (aka '__CFMyPersonalErrorRef *') to Objective-C pointer type 'id<P1,P2>' requires a bridged cast}} \
		// expected-note {{use __bridge to convert directly (no change in ownership)}} \
		// expected-note {{use __bridge_transfer to transfer ownership of a +1 'CFMyPersonalErrorRef' (aka '__CFMyPersonalErrorRef *') into ARC}}
  (void)(id<P1, P2, P3>)cf; // expected-error {{cast of C pointer type 'CFMyPersonalErrorRef' (aka '__CFMyPersonalErrorRef *') to Objective-C pointer type 'id<P1,P2,P3>' requires a bridged cast}} \
		// expected-note {{use __bridge to convert directly (no change in ownership)}} \
		// expected-note {{use __bridge_transfer to transfer ownership of a +1 'CFMyPersonalErrorRef' (aka '__CFMyPersonalErrorRef *') into ARC}}
  (void)(id<P1, P2, P3, P4>)cf; // expected-error {{cast of C pointer type 'CFMyPersonalErrorRef' (aka '__CFMyPersonalErrorRef *') to Objective-C pointer type 'id<P1,P2,P3,P4>' requires a bridged cast}} \
		// expected-note {{use __bridge to convert directly (no change in ownership)}} \
		// expected-note {{use __bridge_transfer to transfer ownership of a +1 'CFMyPersonalErrorRef' (aka '__CFMyPersonalErrorRef *') into ARC}}
  (void)(id<P1, P2, P3, P4, P5>)cf; // expected-warning {{'CFMyPersonalErrorRef' (aka '__CFMyPersonalErrorRef *') bridges to MyPersonalError, not 'id<P1,P2,P3,P4,P5>'}} \
                                    // expected-error {{cast of C pointer type 'CFMyPersonalErrorRef' (aka '__CFMyPersonalErrorRef *') to Objective-C pointer type 'id<P1,P2,P3,P4,P5>' requires a bridged cast}} \
		// expected-note {{use __bridge to convert directly (no change in ownership)}} \
		// expected-note {{use __bridge_transfer to transfer ownership of a +1 'CFMyPersonalErrorRef' (aka '__CFMyPersonalErrorRef *') into ARC}}
}

void Test9(CFErrorRef2 cf, NSError *ns, NSString *str, Class c, CFUColor2Ref cf2) {
  (void)(__bridge NSString *)cf; // expected-warning {{'CFErrorRef2' (aka '__CFErrorRef *') bridges to NSError, not 'NSString'}}
  (void)(__bridge NSError *)cf; // okay
  (void)(__bridge MyError*)cf; // expected-warning {{'CFErrorRef2' (aka '__CFErrorRef *') bridges to NSError, not 'MyError'}} 
  (void)(__bridge NSUColor *)cf2; // okay
  (void)(__bridge CFErrorRef)ns; // okay
  (void)(__bridge CFErrorRef)str;  // expected-warning {{'NSString' cannot bridge to 'CFErrorRef' (aka '__CFErrorRef *')}}
  (void)(__bridge Class)cf; // expected-warning {{'CFErrorRef2' (aka '__CFErrorRef *') bridges to NSError, not 'Class'}}
  (void)(__bridge CFErrorRef)c; // expected-warning {{'__unsafe_unretained Class' cannot bridge to 'CFErrorRef' (aka '__CFErrorRef *')}}
}
