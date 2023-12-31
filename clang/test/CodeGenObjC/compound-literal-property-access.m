// RUN: %clang_cc1 %s -emit-llvm -triple x86_64-apple-darwin -o - | FileCheck %s

typedef __attribute__((__ext_vector_type__(2))) float vector_float2;

@interface GPAgent2D
@property (nonatomic, assign) vector_float2 position;
@end

@interface GPGoal @end

@implementation GPGoal
-(void)getForce {
    GPAgent2D* targetAgent;
    (vector_float2){targetAgent.position.x, targetAgent.position.y};
}
@end

// CHECK: [[CL:%.*]] = alloca <2 x float>, align 8
// CHECK: store <2 x float> [[VECINIT:%.*]], ptr [[CL]]
// CHECK: [[FOURTEEN:%.*]] = load <2 x float>, ptr [[CL]]
