; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve2p1,+bf16 < %s | FileCheck %s

define <vscale x 16 x i8> @test_zipq2_i8(<vscale x 16 x i8> %zn, <vscale x 16 x i8> %zm) {
; CHECK-LABEL: test_zipq2_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    zipq2 z0.b, z0.b, z1.b
; CHECK-NEXT:    ret
  %res = call <vscale x 16 x i8> @llvm.aarch64.sve.zipq2.nxv16i8(<vscale x 16 x i8> %zn, <vscale x 16 x i8> %zm)
  ret <vscale x 16 x i8> %res
}

define <vscale x 8 x i16> @test_zipq2_i16(<vscale x 8 x i16> %zn, <vscale x 8 x i16> %zm) {
; CHECK-LABEL: test_zipq2_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    zipq2 z0.h, z0.h, z1.h
; CHECK-NEXT:    ret
  %res = call <vscale x 8 x i16> @llvm.aarch64.sve.zipq2.nxv8i16(<vscale x 8 x i16> %zn, <vscale x 8 x i16> %zm)
  ret <vscale x 8 x i16> %res
}

define <vscale x 4 x i32> @test_zipq2_i32(<vscale x 4 x i32> %zn, <vscale x 4 x i32> %zm) {
; CHECK-LABEL: test_zipq2_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    zipq2 z0.s, z0.s, z1.s
; CHECK-NEXT:    ret
  %res = call <vscale x 4 x i32> @llvm.aarch64.sve.zipq2.nxv4i32(<vscale x 4 x i32> %zn, <vscale x 4 x i32> %zm)
  ret <vscale x 4 x i32>  %res
}

define <vscale x 2 x i64> @test_zipq2_i64(<vscale x 2 x i64> %zn, <vscale x 2 x i64> %zm) {
; CHECK-LABEL: test_zipq2_i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    zipq2 z0.d, z0.d, z1.d
; CHECK-NEXT:    ret
  %res = call <vscale x 2 x i64> @llvm.aarch64.sve.zipq2.nxv2i64(<vscale x 2 x i64> %zn, <vscale x 2 x i64> %zm)
  ret <vscale x 2 x i64> %res
}

define <vscale x 8 x half> @test_zipq2_f16(<vscale x 8 x half> %zn, <vscale x 8 x half> %zm) {
; CHECK-LABEL: test_zipq2_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    zipq2 z0.h, z0.h, z1.h
; CHECK-NEXT:    ret
  %res = call <vscale x 8 x half> @llvm.aarch64.sve.zipq2.nxv8f16(<vscale x 8 x half> %zn, <vscale x 8 x half> %zm)
  ret <vscale x 8 x half> %res
}

define <vscale x 4 x float> @test_zipq2_f32(<vscale x 4 x float> %zn, <vscale x 4 x float> %zm) {
; CHECK-LABEL: test_zipq2_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    zipq2 z0.s, z0.s, z1.s
; CHECK-NEXT:    ret
  %res = call <vscale x 4 x float> @llvm.aarch64.sve.zipq2.nxv4f32(<vscale x 4 x float> %zn, <vscale x 4 x float> %zm)
  ret <vscale x 4 x float>  %res
}

define <vscale x 2 x double> @test_zipq2_f64(<vscale x 2 x double> %zn, <vscale x 2 x double> %zm) {
; CHECK-LABEL: test_zipq2_f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    zipq2 z0.d, z0.d, z1.d
; CHECK-NEXT:    ret
  %res = call <vscale x 2 x double> @llvm.aarch64.sve.zipq2.nxv2f64(<vscale x 2 x double> %zn, <vscale x 2 x double> %zm)
  ret <vscale x 2 x double> %res
}

define <vscale x 8 x bfloat> @test_zipq2_bf16(<vscale x 8 x bfloat> %zn, <vscale x 8 x bfloat> %zm) {
; CHECK-LABEL: test_zipq2_bf16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    zipq2 z0.h, z0.h, z1.h
; CHECK-NEXT:    ret
  %res = call <vscale x 8 x bfloat> @llvm.aarch64.sve.zipq2.nxv8bf16(<vscale x 8 x bfloat> %zn, <vscale x 8 x bfloat> %zm)
  ret <vscale x 8 x bfloat> %res
}


declare <vscale x 16 x i8> @llvm.aarch64.sve.zipq2.nxv16i8(<vscale x 16 x i8>, <vscale x 16 x i8>)
declare <vscale x 8 x i16> @llvm.aarch64.sve.zipq2.nxv8i16(<vscale x 8 x i16>, <vscale x 8 x i16>)
declare <vscale x 4 x i32> @llvm.aarch64.sve.zipq2.nxv4i32(<vscale x 4 x i32>, <vscale x 4 x i32>)
declare <vscale x 2 x i64> @llvm.aarch64.sve.zipq2.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i64>)

declare <vscale x 8 x half> @llvm.aarch64.sve.zipq2.nxv8f16(<vscale x 8 x half>, <vscale x 8 x half>)
declare <vscale x 4 x float> @llvm.aarch64.sve.zipq2.nxv4f32(<vscale x 4 x float>, <vscale x 4 x float>)
declare <vscale x 2 x double> @llvm.aarch64.sve.zipq2.nxv2f64(<vscale x 2 x double>, <vscale x 2 x double>)
declare <vscale x 8 x bfloat> @llvm.aarch64.sve.zipq2.nxv8bf16(<vscale x 8 x bfloat>, <vscale x 8 x bfloat>)
