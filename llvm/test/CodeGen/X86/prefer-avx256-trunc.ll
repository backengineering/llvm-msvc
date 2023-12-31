; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512vl,+prefer-256-bit | FileCheck %s --check-prefix=AVX256NOBW
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512vl,-prefer-256-bit | FileCheck %s --check-prefix=AVX512NOBW
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512f,+prefer-256-bit | FileCheck %s --check-prefix=AVX512NOBW
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512f,-prefer-256-bit | FileCheck %s --check-prefix=AVX512NOBW
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512bw,+prefer-256-bit | FileCheck %s --check-prefix=AVX512BW
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512bw,-prefer-256-bit | FileCheck %s --check-prefix=AVX512BW
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512bw,+avx512vl,+prefer-256-bit | FileCheck %s --check-prefix=AVX256BWVL
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512bw,+avx512vl,-prefer-256-bit | FileCheck %s --check-prefix=AVX512BWVL

define <16 x i8> @testv16i16_trunc_v16i8(<16 x i16> %x) {
; AVX256NOBW-LABEL: testv16i16_trunc_v16i8:
; AVX256NOBW:       # %bb.0:
; AVX256NOBW-NEXT:    vpandd {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to8}, %ymm0, %ymm0
; AVX256NOBW-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX256NOBW-NEXT:    vpackuswb %xmm1, %xmm0, %xmm0
; AVX256NOBW-NEXT:    vzeroupper
; AVX256NOBW-NEXT:    retq
;
; AVX512NOBW-LABEL: testv16i16_trunc_v16i8:
; AVX512NOBW:       # %bb.0:
; AVX512NOBW-NEXT:    vpmovzxwd {{.*#+}} zmm0 = ymm0[0],zero,ymm0[1],zero,ymm0[2],zero,ymm0[3],zero,ymm0[4],zero,ymm0[5],zero,ymm0[6],zero,ymm0[7],zero,ymm0[8],zero,ymm0[9],zero,ymm0[10],zero,ymm0[11],zero,ymm0[12],zero,ymm0[13],zero,ymm0[14],zero,ymm0[15],zero
; AVX512NOBW-NEXT:    vpmovdb %zmm0, %xmm0
; AVX512NOBW-NEXT:    vzeroupper
; AVX512NOBW-NEXT:    retq
;
; AVX512BW-LABEL: testv16i16_trunc_v16i8:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    # kill: def $ymm0 killed $ymm0 def $zmm0
; AVX512BW-NEXT:    vpmovwb %zmm0, %ymm0
; AVX512BW-NEXT:    # kill: def $xmm0 killed $xmm0 killed $ymm0
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX256BWVL-LABEL: testv16i16_trunc_v16i8:
; AVX256BWVL:       # %bb.0:
; AVX256BWVL-NEXT:    vpmovwb %ymm0, %xmm0
; AVX256BWVL-NEXT:    vzeroupper
; AVX256BWVL-NEXT:    retq
;
; AVX512BWVL-LABEL: testv16i16_trunc_v16i8:
; AVX512BWVL:       # %bb.0:
; AVX512BWVL-NEXT:    vpmovwb %ymm0, %xmm0
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %trunc = trunc <16 x i16> %x to <16 x i8>
  ret <16 x i8> %trunc
}
