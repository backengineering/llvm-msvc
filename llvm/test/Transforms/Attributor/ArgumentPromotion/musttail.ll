; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-attributes
; RUN: opt -attributor -enable-new-pm=0 -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=5 -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_CGSCC_NPM,NOT_CGSCC_OPM,NOT_TUNIT_NPM,IS__TUNIT____,IS________OPM,IS__TUNIT_OPM
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal  -attributor-max-iterations-verify -attributor-annotate-decl-cs -attributor-max-iterations=5 -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_CGSCC_OPM,NOT_CGSCC_NPM,NOT_TUNIT_OPM,IS__TUNIT____,IS________NPM,IS__TUNIT_NPM
; RUN: opt -attributor-cgscc -enable-new-pm=0 -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_TUNIT_NPM,NOT_TUNIT_OPM,NOT_CGSCC_NPM,IS__CGSCC____,IS________OPM,IS__CGSCC_OPM
; RUN: opt -aa-pipeline=basic-aa -passes=attributor-cgscc -attributor-manifest-internal  -attributor-annotate-decl-cs -S < %s | FileCheck %s --check-prefixes=CHECK,NOT_TUNIT_NPM,NOT_TUNIT_OPM,NOT_CGSCC_OPM,IS__CGSCC____,IS________NPM,IS__CGSCC_NPM
; PR36543

; Don't promote arguments of musttail callee

%T = type { i32, i32, i32, i32 }

define internal i32 @test(%T* %p) {
; IS__TUNIT____: Function Attrs: argmemonly nofree nosync nounwind readonly willreturn
; IS__TUNIT____-LABEL: define {{[^@]+}}@test
; IS__TUNIT____-SAME: (%T* nocapture nofree readonly [[P:%.*]]) [[ATTR0:#.*]] {
; IS__TUNIT____-NEXT:    [[A_GEP:%.*]] = getelementptr [[T:%.*]], %T* [[P]], i64 0, i32 3
; IS__TUNIT____-NEXT:    [[B_GEP:%.*]] = getelementptr [[T]], %T* [[P]], i64 0, i32 2
; IS__TUNIT____-NEXT:    [[A:%.*]] = load i32, i32* [[A_GEP]], align 4
; IS__TUNIT____-NEXT:    [[B:%.*]] = load i32, i32* [[B_GEP]], align 4
; IS__TUNIT____-NEXT:    [[V:%.*]] = add i32 [[A]], [[B]]
; IS__TUNIT____-NEXT:    ret i32 [[V]]
;
; IS__CGSCC____: Function Attrs: argmemonly nofree norecurse nosync nounwind readonly willreturn
; IS__CGSCC____-LABEL: define {{[^@]+}}@test
; IS__CGSCC____-SAME: (%T* nocapture nofree readonly [[P:%.*]]) [[ATTR0:#.*]] {
; IS__CGSCC____-NEXT:    [[A_GEP:%.*]] = getelementptr [[T:%.*]], %T* [[P]], i64 0, i32 3
; IS__CGSCC____-NEXT:    [[B_GEP:%.*]] = getelementptr [[T]], %T* [[P]], i64 0, i32 2
; IS__CGSCC____-NEXT:    [[A:%.*]] = load i32, i32* [[A_GEP]], align 4
; IS__CGSCC____-NEXT:    [[B:%.*]] = load i32, i32* [[B_GEP]], align 4
; IS__CGSCC____-NEXT:    [[V:%.*]] = add i32 [[A]], [[B]]
; IS__CGSCC____-NEXT:    ret i32 [[V]]
;
  %a.gep = getelementptr %T, %T* %p, i64 0, i32 3
  %b.gep = getelementptr %T, %T* %p, i64 0, i32 2
  %a = load i32, i32* %a.gep
  %b = load i32, i32* %b.gep
  %v = add i32 %a, %b
  ret i32 %v
}

define i32 @caller(%T* %p) {
; IS__TUNIT____: Function Attrs: argmemonly nofree nosync nounwind readonly willreturn
; IS__TUNIT____-LABEL: define {{[^@]+}}@caller
; IS__TUNIT____-SAME: (%T* nocapture nofree readonly [[P:%.*]]) [[ATTR0]] {
; IS__TUNIT____-NEXT:    [[V:%.*]] = musttail call i32 @test(%T* nocapture nofree readonly [[P]]) [[ATTR4:#.*]]
; IS__TUNIT____-NEXT:    ret i32 [[V]]
;
; IS__CGSCC____: Function Attrs: argmemonly nofree norecurse nosync nounwind readonly willreturn
; IS__CGSCC____-LABEL: define {{[^@]+}}@caller
; IS__CGSCC____-SAME: (%T* nocapture nofree readonly [[P:%.*]]) [[ATTR0]] {
; IS__CGSCC____-NEXT:    [[V:%.*]] = musttail call i32 @test(%T* nocapture nofree readonly [[P]]) [[ATTR4:#.*]]
; IS__CGSCC____-NEXT:    ret i32 [[V]]
;
  %v = musttail call i32 @test(%T* %p)
  ret i32 %v
}

; Don't promote arguments of musttail caller

define i32 @foo(%T* %p, i32 %v) {
; IS__TUNIT____: Function Attrs: nofree nosync nounwind readnone willreturn
; IS__TUNIT____-LABEL: define {{[^@]+}}@foo
; IS__TUNIT____-SAME: (%T* nocapture nofree readnone [[P:%.*]], i32 [[V:%.*]]) [[ATTR1:#.*]] {
; IS__TUNIT____-NEXT:    ret i32 0
;
; IS__CGSCC____: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; IS__CGSCC____-LABEL: define {{[^@]+}}@foo
; IS__CGSCC____-SAME: (%T* nocapture nofree readnone [[P:%.*]], i32 [[V:%.*]]) [[ATTR1:#.*]] {
; IS__CGSCC____-NEXT:    ret i32 0
;
  ret i32 0
}

define internal i32 @test2(%T* %p, i32 %p2) {
; IS__CGSCC____: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; IS__CGSCC____-LABEL: define {{[^@]+}}@test2
; IS__CGSCC____-SAME: (%T* noalias nocapture nofree readnone [[P:%.*]], i32 [[P2:%.*]]) [[ATTR1]] {
; IS__CGSCC____-NEXT:    ret i32 undef
;
  %a.gep = getelementptr %T, %T* %p, i64 0, i32 3
  %b.gep = getelementptr %T, %T* %p, i64 0, i32 2
  %a = load i32, i32* %a.gep
  %b = load i32, i32* %b.gep
  %v = add i32 %a, %b
  %ca = musttail call i32 @foo(%T* undef, i32 %v)
  ret i32 %ca
}

define i32 @caller2(%T* %g) {
; IS__TUNIT____: Function Attrs: nofree nosync nounwind readnone willreturn
; IS__TUNIT____-LABEL: define {{[^@]+}}@caller2
; IS__TUNIT____-SAME: (%T* nocapture nofree readnone [[G:%.*]]) [[ATTR1]] {
; IS__TUNIT____-NEXT:    ret i32 0
;
; IS__CGSCC____: Function Attrs: nofree norecurse nosync nounwind readnone willreturn
; IS__CGSCC____-LABEL: define {{[^@]+}}@caller2
; IS__CGSCC____-SAME: (%T* nocapture nofree readnone [[G:%.*]]) [[ATTR1]] {
; IS__CGSCC____-NEXT:    ret i32 0
;
  %v = call i32 @test2(%T* %g, i32 0)
  ret i32 %v
}

; In the version above we can remove the call to foo completely.
; In the version below we keep the call and verify the return value
; is kept as well.

define i32 @bar(%T* %p, i32 %v) {
; IS__TUNIT____: Function Attrs: argmemonly nofree nosync nounwind willreturn writeonly
; IS__TUNIT____-LABEL: define {{[^@]+}}@bar
; IS__TUNIT____-SAME: (%T* nocapture nofree nonnull writeonly dereferenceable(4) [[P:%.*]], i32 [[V:%.*]]) [[ATTR2:#.*]] {
; IS__TUNIT____-NEXT:    [[I32PTR:%.*]] = getelementptr [[T:%.*]], %T* [[P]], i64 0, i32 0
; IS__TUNIT____-NEXT:    store i32 [[V]], i32* [[I32PTR]], align 4
; IS__TUNIT____-NEXT:    ret i32 0
;
; IS__CGSCC____: Function Attrs: argmemonly nofree norecurse nosync nounwind willreturn writeonly
; IS__CGSCC____-LABEL: define {{[^@]+}}@bar
; IS__CGSCC____-SAME: (%T* nocapture nofree nonnull writeonly dereferenceable(4) [[P:%.*]], i32 [[V:%.*]]) [[ATTR2:#.*]] {
; IS__CGSCC____-NEXT:    [[I32PTR:%.*]] = getelementptr [[T:%.*]], %T* [[P]], i64 0, i32 0
; IS__CGSCC____-NEXT:    store i32 [[V]], i32* [[I32PTR]], align 4
; IS__CGSCC____-NEXT:    ret i32 0
;
  %i32ptr = getelementptr %T, %T* %p, i64 0, i32 0
  store i32 %v, i32* %i32ptr
  ret i32 0
}

define internal i32 @test2b(%T* %p, i32 %p2) {
; IS__TUNIT____: Function Attrs: argmemonly nofree nosync nounwind willreturn
; IS__TUNIT____-LABEL: define {{[^@]+}}@test2b
; IS__TUNIT____-SAME: (%T* nocapture nofree readonly [[P:%.*]], i32 [[P2:%.*]]) [[ATTR3:#.*]] {
; IS__TUNIT____-NEXT:    [[A_GEP:%.*]] = getelementptr [[T:%.*]], %T* [[P]], i64 0, i32 3
; IS__TUNIT____-NEXT:    [[B_GEP:%.*]] = getelementptr [[T]], %T* [[P]], i64 0, i32 2
; IS__TUNIT____-NEXT:    [[A:%.*]] = load i32, i32* [[A_GEP]], align 4
; IS__TUNIT____-NEXT:    [[B:%.*]] = load i32, i32* [[B_GEP]], align 4
; IS__TUNIT____-NEXT:    [[V:%.*]] = add i32 [[A]], [[B]]
; IS__TUNIT____-NEXT:    [[CA:%.*]] = musttail call i32 @bar(%T* undef, i32 [[V]]) [[ATTR5:#.*]]
; IS__TUNIT____-NEXT:    ret i32 [[CA]]
;
; IS__CGSCC____: Function Attrs: argmemonly nofree norecurse nosync nounwind willreturn
; IS__CGSCC____-LABEL: define {{[^@]+}}@test2b
; IS__CGSCC____-SAME: (%T* nocapture nofree readonly [[P:%.*]], i32 [[P2:%.*]]) [[ATTR3:#.*]] {
; IS__CGSCC____-NEXT:    [[A_GEP:%.*]] = getelementptr [[T:%.*]], %T* [[P]], i64 0, i32 3
; IS__CGSCC____-NEXT:    [[B_GEP:%.*]] = getelementptr [[T]], %T* [[P]], i64 0, i32 2
; IS__CGSCC____-NEXT:    [[A:%.*]] = load i32, i32* [[A_GEP]], align 4
; IS__CGSCC____-NEXT:    [[B:%.*]] = load i32, i32* [[B_GEP]], align 4
; IS__CGSCC____-NEXT:    [[V:%.*]] = add i32 [[A]], [[B]]
; IS__CGSCC____-NEXT:    [[CA:%.*]] = musttail call i32 @bar(%T* undef, i32 [[V]]) [[ATTR5:#.*]]
; IS__CGSCC____-NEXT:    ret i32 [[CA]]
;
  %a.gep = getelementptr %T, %T* %p, i64 0, i32 3
  %b.gep = getelementptr %T, %T* %p, i64 0, i32 2
  %a = load i32, i32* %a.gep
  %b = load i32, i32* %b.gep
  %v = add i32 %a, %b
  %ca = musttail call i32 @bar(%T* undef, i32 %v)
  ret i32 %ca
}

define i32 @caller2b(%T* %g) {
; IS__TUNIT____: Function Attrs: argmemonly nofree nosync nounwind willreturn
; IS__TUNIT____-LABEL: define {{[^@]+}}@caller2b
; IS__TUNIT____-SAME: (%T* nocapture nofree readonly [[G:%.*]]) [[ATTR3]] {
; IS__TUNIT____-NEXT:    [[V:%.*]] = call i32 @test2b(%T* nocapture nofree readonly [[G]], i32 undef) [[ATTR6:#.*]]
; IS__TUNIT____-NEXT:    ret i32 0
;
; IS__CGSCC____: Function Attrs: argmemonly nofree norecurse nosync nounwind willreturn
; IS__CGSCC____-LABEL: define {{[^@]+}}@caller2b
; IS__CGSCC____-SAME: (%T* nocapture nofree readonly [[G:%.*]]) [[ATTR3]] {
; IS__CGSCC____-NEXT:    [[V:%.*]] = call i32 @test2b(%T* nocapture nofree readonly [[G]], i32 noundef undef) [[ATTR6:#.*]]
; IS__CGSCC____-NEXT:    ret i32 0
;
  %v = call i32 @test2b(%T* %g, i32 0)
  ret i32 %v
}
