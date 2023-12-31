; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py UTC_ARGS: --version 4
; RUN: opt -passes='print<access-info>' -disable-output  < %s 2>&1 | FileCheck %s

define void @forward_dist_7(ptr %A, ptr noalias %B) {
; CHECK-LABEL: 'forward_dist_7'
; CHECK-NEXT:    loop:
; CHECK-NEXT:      Report: unsafe dependent memory operations in loop. Use #pragma clang loop distribute(enable) to allow loop distribution to attempt to isolate the offending operations into a separate loop
; CHECK-NEXT:  Forward loop carried data dependence that prevents store-to-load forwarding.
; CHECK-NEXT:      Dependences:
; CHECK-NEXT:        ForwardButPreventsForwarding:
; CHECK-NEXT:            store i32 0, ptr %gep.2, align 4 ->
; CHECK-NEXT:            %l = load i32, ptr %gep.1, align 4
; CHECK-EMPTY:
; CHECK-NEXT:      Run-time memory checks:
; CHECK-NEXT:      Grouped accesses:
; CHECK-EMPTY:
; CHECK-NEXT:      Non vectorizable stores to invariant address were not found in loop.
; CHECK-NEXT:      SCEV assumptions:
; CHECK-EMPTY:
; CHECK-NEXT:      Expressions re-written:
;
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %next, %loop ]
  %gep.1  = getelementptr i32, ptr %A, i64 %iv
  %gep.2  = getelementptr i32, ptr %gep.1, i64 7
  store i32 0, ptr %gep.2, align 4
  %l = load i32, ptr %gep.1
  store i32 %l, ptr %B
  %next = add nuw nsw i64 %iv, 1
  %ec = icmp eq i64 %iv, 1000
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}

define void @forward_dist_9(ptr %A, ptr noalias %B) {
; CHECK-LABEL: 'forward_dist_9'
; CHECK-NEXT:    loop:
; CHECK-NEXT:      Report: unsafe dependent memory operations in loop. Use #pragma clang loop distribute(enable) to allow loop distribution to attempt to isolate the offending operations into a separate loop
; CHECK-NEXT:  Forward loop carried data dependence that prevents store-to-load forwarding.
; CHECK-NEXT:      Dependences:
; CHECK-NEXT:        ForwardButPreventsForwarding:
; CHECK-NEXT:            store i32 0, ptr %gep.2, align 4 ->
; CHECK-NEXT:            %l = load i32, ptr %gep.1, align 4
; CHECK-EMPTY:
; CHECK-NEXT:      Run-time memory checks:
; CHECK-NEXT:      Grouped accesses:
; CHECK-EMPTY:
; CHECK-NEXT:      Non vectorizable stores to invariant address were not found in loop.
; CHECK-NEXT:      SCEV assumptions:
; CHECK-EMPTY:
; CHECK-NEXT:      Expressions re-written:
;
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %next, %loop ]
  %gep.1  = getelementptr i32, ptr %A, i64 %iv
  %gep.2  = getelementptr i32, ptr %gep.1, i64 9
  store i32 0, ptr %gep.2, align 4
  %l = load i32, ptr %gep.1
  store i32 %l, ptr %B
  %next = add nuw nsw i64 %iv, 1
  %ec = icmp eq i64 %iv, 1000
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}

define void @forward_dist_11(ptr %A, ptr noalias %B) {
; CHECK-LABEL: 'forward_dist_11'
; CHECK-NEXT:    loop:
; CHECK-NEXT:      Report: unsafe dependent memory operations in loop. Use #pragma clang loop distribute(enable) to allow loop distribution to attempt to isolate the offending operations into a separate loop
; CHECK-NEXT:  Forward loop carried data dependence that prevents store-to-load forwarding.
; CHECK-NEXT:      Dependences:
; CHECK-NEXT:        ForwardButPreventsForwarding:
; CHECK-NEXT:            store i32 0, ptr %gep.2, align 4 ->
; CHECK-NEXT:            %l = load i32, ptr %gep.1, align 4
; CHECK-EMPTY:
; CHECK-NEXT:      Run-time memory checks:
; CHECK-NEXT:      Grouped accesses:
; CHECK-EMPTY:
; CHECK-NEXT:      Non vectorizable stores to invariant address were not found in loop.
; CHECK-NEXT:      SCEV assumptions:
; CHECK-EMPTY:
; CHECK-NEXT:      Expressions re-written:
;
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %next, %loop ]
  %gep.1  = getelementptr i32, ptr %A, i64 %iv
  %gep.2  = getelementptr i32, ptr %gep.1, i64 9
  store i32 0, ptr %gep.2, align 4
  %l = load i32, ptr %gep.1
  store i32 %l, ptr %B
  %next = add nuw nsw i64 %iv, 1
  %ec = icmp eq i64 %iv, 1000
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}

define void @forward_dist_13(ptr %A, ptr noalias %B) {
; CHECK-LABEL: 'forward_dist_13'
; CHECK-NEXT:    loop:
; CHECK-NEXT:      Report: unsafe dependent memory operations in loop. Use #pragma clang loop distribute(enable) to allow loop distribution to attempt to isolate the offending operations into a separate loop
; CHECK-NEXT:  Forward loop carried data dependence that prevents store-to-load forwarding.
; CHECK-NEXT:      Dependences:
; CHECK-NEXT:        ForwardButPreventsForwarding:
; CHECK-NEXT:            store i32 0, ptr %gep.2, align 4 ->
; CHECK-NEXT:            %l = load i32, ptr %gep.1, align 4
; CHECK-EMPTY:
; CHECK-NEXT:      Run-time memory checks:
; CHECK-NEXT:      Grouped accesses:
; CHECK-EMPTY:
; CHECK-NEXT:      Non vectorizable stores to invariant address were not found in loop.
; CHECK-NEXT:      SCEV assumptions:
; CHECK-EMPTY:
; CHECK-NEXT:      Expressions re-written:
;
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %next, %loop ]
  %gep.1  = getelementptr i32, ptr %A, i64 %iv
  %gep.2  = getelementptr i32, ptr %gep.1, i64 13
  store i32 0, ptr %gep.2, align 4
  %l = load i32, ptr %gep.1
  store i32 %l, ptr %B
  %next = add nuw nsw i64 %iv, 1
  %ec = icmp eq i64 %iv, 1000
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}

define void @forward_dist_15(ptr %A, ptr noalias %B) {
; CHECK-LABEL: 'forward_dist_15'
; CHECK-NEXT:    loop:
; CHECK-NEXT:      Report: unsafe dependent memory operations in loop. Use #pragma clang loop distribute(enable) to allow loop distribution to attempt to isolate the offending operations into a separate loop
; CHECK-NEXT:  Forward loop carried data dependence that prevents store-to-load forwarding.
; CHECK-NEXT:      Dependences:
; CHECK-NEXT:        ForwardButPreventsForwarding:
; CHECK-NEXT:            store i32 0, ptr %gep.2, align 4 ->
; CHECK-NEXT:            %l = load i32, ptr %gep.1, align 4
; CHECK-EMPTY:
; CHECK-NEXT:      Run-time memory checks:
; CHECK-NEXT:      Grouped accesses:
; CHECK-EMPTY:
; CHECK-NEXT:      Non vectorizable stores to invariant address were not found in loop.
; CHECK-NEXT:      SCEV assumptions:
; CHECK-EMPTY:
; CHECK-NEXT:      Expressions re-written:
;
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %next, %loop ]
  %gep.1  = getelementptr i32, ptr %A, i64 %iv
  %gep.2  = getelementptr i32, ptr %gep.1, i64 13
  store i32 0, ptr %gep.2, align 4
  %l = load i32, ptr %gep.1
  store i32 %l, ptr %B
  %next = add nuw nsw i64 %iv, 1
  %ec = icmp eq i64 %iv, 1000
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}

define void @forward_dist_17(ptr %A, ptr noalias %B) {
; CHECK-LABEL: 'forward_dist_17'
; CHECK-NEXT:    loop:
; CHECK-NEXT:      Report: unsafe dependent memory operations in loop. Use #pragma clang loop distribute(enable) to allow loop distribution to attempt to isolate the offending operations into a separate loop
; CHECK-NEXT:  Forward loop carried data dependence that prevents store-to-load forwarding.
; CHECK-NEXT:      Dependences:
; CHECK-NEXT:        ForwardButPreventsForwarding:
; CHECK-NEXT:            store i32 0, ptr %gep.2, align 4 ->
; CHECK-NEXT:            %l = load i32, ptr %gep.1, align 4
; CHECK-EMPTY:
; CHECK-NEXT:      Run-time memory checks:
; CHECK-NEXT:      Grouped accesses:
; CHECK-EMPTY:
; CHECK-NEXT:      Non vectorizable stores to invariant address were not found in loop.
; CHECK-NEXT:      SCEV assumptions:
; CHECK-EMPTY:
; CHECK-NEXT:      Expressions re-written:
;
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %next, %loop ]
  %gep.1  = getelementptr i32, ptr %A, i64 %iv
  %gep.2  = getelementptr i32, ptr %gep.1, i64 17
  store i32 0, ptr %gep.2, align 4
  %l = load i32, ptr %gep.1
  store i32 %l, ptr %B
  %next = add nuw nsw i64 %iv, 1
  %ec = icmp eq i64 %iv, 1000
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}

define void @forward_dist_19(ptr %A, ptr noalias %B) {
; CHECK-LABEL: 'forward_dist_19'
; CHECK-NEXT:    loop:
; CHECK-NEXT:      Report: unsafe dependent memory operations in loop. Use #pragma clang loop distribute(enable) to allow loop distribution to attempt to isolate the offending operations into a separate loop
; CHECK-NEXT:  Forward loop carried data dependence that prevents store-to-load forwarding.
; CHECK-NEXT:      Dependences:
; CHECK-NEXT:        ForwardButPreventsForwarding:
; CHECK-NEXT:            store i32 0, ptr %gep.2, align 4 ->
; CHECK-NEXT:            %l = load i32, ptr %gep.1, align 4
; CHECK-EMPTY:
; CHECK-NEXT:      Run-time memory checks:
; CHECK-NEXT:      Grouped accesses:
; CHECK-EMPTY:
; CHECK-NEXT:      Non vectorizable stores to invariant address were not found in loop.
; CHECK-NEXT:      SCEV assumptions:
; CHECK-EMPTY:
; CHECK-NEXT:      Expressions re-written:
;
entry:
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %next, %loop ]
  %gep.1  = getelementptr i32, ptr %A, i64 %iv
  %gep.2  = getelementptr i32, ptr %gep.1, i64 19
  store i32 0, ptr %gep.2, align 4
  %l = load i32, ptr %gep.1
  store i32 %l, ptr %B
  %next = add nuw nsw i64 %iv, 1
  %ec = icmp eq i64 %iv, 1000
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}

@A = global [37 x [37 x double]] zeroinitializer, align 8

define void @unknown_loop_bounds(i64 %x, i64 %y) {
; CHECK-LABEL: 'unknown_loop_bounds'
; CHECK-NEXT:    inner:
; CHECK-NEXT:      Report: unsafe dependent memory operations in loop. Use #pragma clang loop distribute(enable) to allow loop distribution to attempt to isolate the offending operations into a separate loop
; CHECK-NEXT:  Backward loop carried data dependence that prevents store-to-load forwarding.
; CHECK-NEXT:      Dependences:
; CHECK-NEXT:        BackwardVectorizableButPreventsForwarding:
; CHECK-NEXT:            %l = load double, ptr %gep.0, align 8 ->
; CHECK-NEXT:            store double %l, ptr %gep.1, align 8
; CHECK-EMPTY:
; CHECK-NEXT:      Run-time memory checks:
; CHECK-NEXT:      Grouped accesses:
; CHECK-EMPTY:
; CHECK-NEXT:      Non vectorizable stores to invariant address were not found in loop.
; CHECK-NEXT:      SCEV assumptions:
; CHECK-EMPTY:
; CHECK-NEXT:      Expressions re-written:
; CHECK-NEXT:    outer.header:
; CHECK-NEXT:      Report: loop is not the innermost loop
; CHECK-NEXT:      Dependences:
; CHECK-NEXT:      Run-time memory checks:
; CHECK-NEXT:      Grouped accesses:
; CHECK-EMPTY:
; CHECK-NEXT:      Non vectorizable stores to invariant address were not found in loop.
; CHECK-NEXT:      SCEV assumptions:
; CHECK-EMPTY:
; CHECK-NEXT:      Expressions re-written:
;
entry:
  br label %outer.header

outer.header:
  %outer.iv = phi i64 [ 0, %entry ], [ %outer.iv.next, %outer.latch ]
  %outer.iv.next = add nuw nsw i64 %outer.iv, 1
  br label %inner

inner:
  %inner.iv = phi i64 [ 0, %outer.header ], [ %inner.iv.next, %inner ]
  %gep.0 = getelementptr inbounds [37 x [37 x double]], ptr @A, i64 0, i64 %outer.iv, i64 %inner.iv
  %l = load double, ptr %gep.0, align 8
  %gep.1 = getelementptr inbounds [37 x [37 x double]], ptr @A, i64 0, i64 %outer.iv.next, i64 %inner.iv
  store double %l, ptr %gep.1, align 8
  %inner.iv.next = add nuw nsw i64 %inner.iv, 1
  %inner.ec = icmp eq i64 %inner.iv.next, %y
  br i1 %inner.ec, label %outer.latch, label %inner

outer.latch:
  %outer.ec = icmp eq i64 %outer.iv.next, %x
  br i1 %outer.ec, label %exit, label %outer.header

exit:
  ret void
}
