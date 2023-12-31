; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -S -passes=sroa < %s | FileCheck %s

%B = type { i1, i3 }

define void @test(i7 %x) {
; CHECK-LABEL: define void @test(
; CHECK-SAME: i7 [[X:%.*]]) {
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[RES:%.*]] = alloca [2 x i8], align 1
; CHECK-NEXT:    [[TMP_SROA_0:%.*]] = alloca i1, align 8
; CHECK-NEXT:    [[TMP_SROA_1:%.*]] = alloca i3, align 1
; CHECK-NEXT:    store i7 [[X]], ptr [[TMP_SROA_1]], align 1
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr align 1 [[RES]], ptr align 8 [[TMP_SROA_0]], i64 1, i1 false)
; CHECK-NEXT:    [[TMP_SROA_1_0_RES_SROA_IDX:%.*]] = getelementptr inbounds i8, ptr [[RES]], i64 1
; CHECK-NEXT:    call void @llvm.memcpy.p0.p0.i64(ptr align 1 [[TMP_SROA_1_0_RES_SROA_IDX]], ptr align 1 [[TMP_SROA_1]], i64 1, i1 false)
; CHECK-NEXT:    [[TMP0:%.*]] = call i8 @use(ptr [[RES]])
; CHECK-NEXT:    ret void
;
bb:
  %res = alloca [2 x i8]
  %tmp = alloca { i1, i3 }
  %tmp.1 = getelementptr i8, ptr %tmp, i64 1
  store i7 %x, ptr %tmp.1
  call void @llvm.memcpy.p0.p0.i64(ptr %res, ptr %tmp, i64 2, i1 false)
  call i8 @use(ptr %res)
  ret void
}

declare void @use(ptr)

declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg)
