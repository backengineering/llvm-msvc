; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 3
; RUN: opt -passes=slp-vectorizer -slp-vectorize-hor -slp-vectorize-hor-store -S < %s -mtriple=x86_64-unknown-linux | FileCheck %s

@arr_i32 = global [32 x i32] zeroinitializer, align 16
define void @test(ptr noalias %pl, ptr noalias %res, ptr noalias %p2) {
; CHECK-LABEL: define void @test(
; CHECK-SAME: ptr noalias [[PL:%.*]], ptr noalias [[RES:%.*]], ptr noalias [[P2:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load <4 x i32>, ptr @arr_i32, align 16
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[TMP0]])
; CHECK-NEXT:    store i32 [[TMP1]], ptr [[P2]], align 16
; CHECK-NEXT:    store i32 [[TMP1]], ptr [[RES]], align 16
; CHECK-NEXT:    ret void
;
entry:
  %0 = load i32, ptr @arr_i32, align 16
  %1 = load i32, ptr getelementptr inbounds ([32 x i32], ptr @arr_i32, i64 0, i64 1), align 4
  %add = add nsw i32 %1, %0
  %2 = load i32, ptr getelementptr inbounds ([32 x i32], ptr @arr_i32, i64 0, i64 2), align 8
  %add.1 = add nsw i32 %2, %add
  %3 = load i32, ptr getelementptr inbounds ([32 x i32], ptr @arr_i32, i64 0, i64 3), align 4
  %add.2 = add nsw i32 %3, %add.1
  store i32 %add.2, ptr %p2, align 16
  store i32 %add.2, ptr %res, align 16
  ret void
}

