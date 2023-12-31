; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -relocation-model=pic -verify-machineinstrs -start-before=hardware-loops < %s \
; RUN:   -mtriple=powerpc64le-unknown-linux-gnu -mcpu=pwr8 | FileCheck %s

; NOTE: this needs to run starting at HW loops to ensure that the original loop
; does not end up producing a HW loop. If other passes are run prior, the loop
; will be transformed.

%struct.e.0.12.28.44.104.108.112.188 = type { i32 }
%struct.t.1.13.29.45.105.109.113.189 = type { i64, i64 }

@g = external local_unnamed_addr global %struct.e.0.12.28.44.104.108.112.188, align 4
@aj = external thread_local local_unnamed_addr global %struct.t.1.13.29.45.105.109.113.189, align 8

define void @_ZNK1q1rEv() local_unnamed_addr #0 align 2 {
; CHECK-LABEL: _ZNK1q1rEv:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    mflr 0
; CHECK-NEXT:    std 29, -24(1) # 8-byte Folded Spill
; CHECK-NEXT:    std 30, -16(1) # 8-byte Folded Spill
; CHECK-NEXT:    stdu 1, -64(1)
; CHECK-NEXT:    std 0, 80(1)
; CHECK-NEXT:    lwz 3, 0(3)
; CHECK-NEXT:    addi 3, 3, -1
; CHECK-NEXT:    clrldi 3, 3, 32
; CHECK-NEXT:    addi 30, 3, 1
; CHECK-NEXT:    addis 3, 2, .LC0@toc@ha
; CHECK-NEXT:    ld 29, .LC0@toc@l(3)
; CHECK-NEXT:    addis 3, 2, aj@got@tlsgd@ha
; CHECK-NEXT:    addi 3, 3, aj@got@tlsgd@l
; CHECK-NEXT:    bl __tls_get_addr(aj@tlsgd)
; CHECK-NEXT:    nop
; CHECK-NEXT:    addi 4, 3, 8
; CHECK-NEXT:    .p2align 5
; CHECK-NEXT:  .LBB0_1: # %monotonic.i
; CHECK-NEXT:    #
; CHECK-NEXT:    lwz 5, 0(29)
; CHECK-NEXT:    andi. 5, 5, 255
; CHECK-NEXT:    bne 0, .LBB0_4
; CHECK-NEXT:  # %bb.2: # %for.cond.i
; CHECK-NEXT:    #
; CHECK-NEXT:    addi 30, 30, -1
; CHECK-NEXT:    cmpldi 30, 0
; CHECK-NEXT:    bc 12, 1, .LBB0_1
; CHECK-NEXT:  # %bb.3:
; CHECK-NEXT:    mr 4, 3
; CHECK-NEXT:  .LBB0_4: # %if.end
; CHECK-NEXT:    li 3, 1
; CHECK-NEXT:    std 3, 0(4)
; CHECK-NEXT:    addi 1, 1, 64
; CHECK-NEXT:    ld 0, 16(1)
; CHECK-NEXT:    ld 30, -16(1) # 8-byte Folded Reload
; CHECK-NEXT:    ld 29, -24(1) # 8-byte Folded Reload
; CHECK-NEXT:    mtlr 0
; CHECK-NEXT:    blr
entry:
  %0 = load i32, ptr undef, align 4
  br label %monotonic.i

for.cond.i:                                       ; preds = %monotonic.i
  %exitcond.not = icmp eq i32 %inc.i, %0
  br i1 %exitcond.not, label %if.end, label %monotonic.i

monotonic.i:                                      ; preds = %for.cond.i, %entry
  %i.018.i = phi i32 [ %inc.i, %for.cond.i ], [ 0, %entry ]
  %1 = load atomic i32, ptr @g monotonic, align 4
  %conv.i = trunc i32 %1 to i8
  %tobool.not.i = icmp eq i8 %conv.i, 0
  %inc.i = add nuw nsw i32 %i.018.i, 1
  br i1 %tobool.not.i, label %for.cond.i, label %if.end

if.end:                                           ; preds = %monotonic.i, %for.cond.i
  %.sink = phi ptr [ getelementptr inbounds (%struct.t.1.13.29.45.105.109.113.189, ptr @aj, i64 0, i32 1), %monotonic.i ], [ @aj, %for.cond.i ]
  store i64 1, ptr %.sink, align 8
  ret void
}

attributes #0 = { nounwind }
