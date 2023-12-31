// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -triple riscv64-none-linux-gnu -target-feature +f -target-feature +d -target-feature +zve64d -mvscale-min=1 -mvscale-max=1 -S -O1 -emit-llvm -o - %s | FileCheck %s --check-prefix=CHECK-64
// RUN: %clang_cc1 -triple riscv64-none-linux-gnu -target-feature +f -target-feature +d -target-feature +zve64d -mvscale-min=4 -mvscale-max=4 -S -O1 -emit-llvm -o - %s | FileCheck %s --check-prefix=CHECK-256

// REQUIRES: riscv-registered-target

#include <stdint.h>

typedef __rvv_int8m1_t vint8m1_t;
typedef __rvv_uint8m1_t vuint8m1_t;
typedef __rvv_int16m1_t vint16m1_t;
typedef __rvv_uint16m1_t vuint16m1_t;
typedef __rvv_int32m1_t vint32m1_t;
typedef __rvv_uint32m1_t vuint32m1_t;
typedef __rvv_int64m1_t vint64m1_t;
typedef __rvv_uint64m1_t vuint64m1_t;
typedef __rvv_float32m1_t vfloat32m1_t;
typedef __rvv_float64m1_t vfloat64m1_t;

typedef vint64m1_t fixed_int64m1_t __attribute__((riscv_rvv_vector_bits(__riscv_v_fixed_vlen)));

fixed_int64m1_t global_i64;

//===----------------------------------------------------------------------===//
// WRITES
//===----------------------------------------------------------------------===//

// CHECK-64-LABEL: @write_global_i64(
// CHECK-64-NEXT:  entry:
// CHECK-64-NEXT:    [[CAST_FIXED:%.*]] = tail call <1 x i64> @llvm.vector.extract.v1i64.nxv1i64(<vscale x 1 x i64> [[V:%.*]], i64 0)
// CHECK-64-NEXT:    store <1 x i64> [[CAST_FIXED]], ptr @global_i64, align 8, !tbaa [[TBAA4:![0-9]+]]
// CHECK-64-NEXT:    ret void
//
// CHECK-256-LABEL: @write_global_i64(
// CHECK-256-NEXT:  entry:
// CHECK-256-NEXT:    [[CAST_FIXED:%.*]] = tail call <4 x i64> @llvm.vector.extract.v4i64.nxv1i64(<vscale x 1 x i64> [[V:%.*]], i64 0)
// CHECK-256-NEXT:    store <4 x i64> [[CAST_FIXED]], ptr @global_i64, align 8, !tbaa [[TBAA4:![0-9]+]]
// CHECK-256-NEXT:    ret void
//
void write_global_i64(vint64m1_t v) { global_i64 = v; }

//===----------------------------------------------------------------------===//
// READS
//===----------------------------------------------------------------------===//

// CHECK-64-LABEL: @read_global_i64(
// CHECK-64-NEXT:  entry:
// CHECK-64-NEXT:    [[TMP0:%.*]] = load <1 x i64>, ptr @global_i64, align 8, !tbaa [[TBAA4]]
// CHECK-64-NEXT:    [[CAST_SCALABLE:%.*]] = tail call <vscale x 1 x i64> @llvm.vector.insert.nxv1i64.v1i64(<vscale x 1 x i64> undef, <1 x i64> [[TMP0]], i64 0)
// CHECK-64-NEXT:    ret <vscale x 1 x i64> [[CAST_SCALABLE]]
//
// CHECK-256-LABEL: @read_global_i64(
// CHECK-256-NEXT:  entry:
// CHECK-256-NEXT:    [[TMP0:%.*]] = load <4 x i64>, ptr @global_i64, align 8, !tbaa [[TBAA4]]
// CHECK-256-NEXT:    [[CAST_SCALABLE:%.*]] = tail call <vscale x 1 x i64> @llvm.vector.insert.nxv1i64.v4i64(<vscale x 1 x i64> undef, <4 x i64> [[TMP0]], i64 0)
// CHECK-256-NEXT:    ret <vscale x 1 x i64> [[CAST_SCALABLE]]
//
vint64m1_t read_global_i64() { return global_i64; }
