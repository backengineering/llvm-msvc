// RUN: llvm-mc -triple=amdgcn -mcpu=tonga -show-encoding %s | FileCheck -check-prefix=VI %s

v_add_f16 v1, 0, v2
// VI: v_add_f16_e32 v1, 0, v2 ; encoding: [0x80,0x04,0x02,0x3e]

v_add_f16 v1, 0.0, v2
// VI: v_add_f16_e32 v1, 0, v2 ; encoding: [0x80,0x04,0x02,0x3e]

v_add_f16 v1, v2, 0
// VI: v_add_f16_e64 v1, v2, 0 ; encoding: [0x01,0x00,0x1f,0xd1,0x02,0x01,0x01,0x00]

v_add_f16 v1, v2, 0.0
// VI: v_add_f16_e64 v1, v2, 0 ; encoding: [0x01,0x00,0x1f,0xd1,0x02,0x01,0x01,0x00]

v_add_f16 v1, -0.0, v2
// VI: v_add_f16_e32 v1, 0x8000, v2 ; encoding: [0xff,0x04,0x02,0x3e,0x00,0x80,0x00,0x00]

v_add_f16 v1, 1.0, v2
// VI: v_add_f16_e32 v1, 1.0, v2 ; encoding: [0xf2,0x04,0x02,0x3e]

v_add_f16 v1, -1.0, v2
// VI: v_add_f16_e32 v1, -1.0, v2 ; encoding: [0xf3,0x04,0x02,0x3e]

v_add_f16 v1, -0.5, v2
// VI: v_add_f16_e32 v1, -0.5, v2 ; encoding: [0xf1,0x04,0x02,0x3e]

v_add_f16 v1, 0.5, v2
// VI: v_add_f16_e32 v1, 0.5, v2 ; encoding: [0xf0,0x04,0x02,0x3e]

v_add_f16 v1, 2.0, v2
// VI: v_add_f16_e32 v1, 2.0, v2 ; encoding: [0xf4,0x04,0x02,0x3e]

v_add_f16 v1, -2.0, v2
// VI: v_add_f16_e32 v1, -2.0, v2 ; encoding: [0xf5,0x04,0x02,0x3e]

v_add_f16 v1, 4.0, v2
// VI: v_add_f16_e32 v1, 4.0, v2 ; encoding: [0xf6,0x04,0x02,0x3e]

v_add_f16 v1, -4.0, v2
// VI: v_add_f16_e32 v1, -4.0, v2 ; encoding: [0xf7,0x04,0x02,0x3e]

v_add_f16 v1, 0.15915494, v2
// VI: v_add_f16_e32 v1, 0.15915494, v2 ; encoding: [0xf8,0x04,0x02,0x3e]

v_add_f16 v1, -0.15915494, v2
// VI: v_add_f16_e32 v1, 0xb118, v2 ; encoding: [0xff,0x04,0x02,0x3e,0x18,0xb1,0x00,0x00]

v_add_f16 v1, -1, v2
// VI: v_add_f16_e32 v1, -1, v2 ; encoding: [0xc1,0x04,0x02,0x3e]


v_add_f16 v1, -2, v2
// VI: v_add_f16_e32 v1, -2, v2 ; encoding: [0xc2,0x04,0x02,0x3e]

v_add_f16 v1, -3, v2
// VI: v_add_f16_e32 v1, -3, v2 ; encoding: [0xc3,0x04,0x02,0x3e]

v_add_f16 v1, -16, v2
// VI: v_add_f16_e32 v1, -16, v2 ; encoding: [0xd0,0x04,0x02,0x3e]

v_add_f16 v1, 1, v2
// VI: v_add_f16_e32 v1, 1, v2 ; encoding: [0x81,0x04,0x02,0x3e]

v_add_f16 v1, 2, v2
// VI: v_add_f16_e32 v1, 2, v2 ; encoding: [0x82,0x04,0x02,0x3e]

v_add_f16 v1, 3, v2
// VI: v_add_f16_e32 v1, 3, v2 ; encoding: [0x83,0x04,0x02,0x3e]

v_add_f16 v1, 4, v2
// VI: v_add_f16_e32 v1, 4, v2 ; encoding: [0x84,0x04,0x02,0x3e]

v_add_f16 v1, 15, v2
// VI: v_add_f16_e32 v1, 15, v2 ; encoding: [0x8f,0x04,0x02,0x3e]

v_add_f16 v1, 16, v2
// VI: v_add_f16_e32 v1, 16, v2 ; encoding: [0x90,0x04,0x02,0x3e]

v_add_f16 v1, 63, v2
// VI: v_add_f16_e32 v1, 63, v2 ; encoding: [0xbf,0x04,0x02,0x3e]

v_add_f16 v1, 64, v2
// VI: v_add_f16_e32 v1, 64, v2 ; encoding: [0xc0,0x04,0x02,0x3e]

v_add_f16 v1, 0x0001, v2
// VI: v_add_f16_e32 v1, 1, v2 ; encoding: [0x81,0x04,0x02,0x3e]

v_add_f16 v1, 0xffff, v2
// VI: v_add_f16_e32 v1, -1, v2 ; encoding: [0xc1,0x04,0x02,0x3e]

v_add_f16 v1, -17, v2
// VI: v_add_f16_e32 v1, 0xffef, v2 ; encoding: [0xff,0x04,0x02,0x3e,0xef,0xff,0x00,0x00]

v_add_f16 v1, 65, v2
// VI: v_add_f16_e32 v1, 0x41, v2 ; encoding: [0xff,0x04,0x02,0x3e,0x41,0x00,0x00,0x00]

v_add_f16 v1, 0x3c00, v2
// VI: v_add_f16_e32 v1, 1.0, v2 ; encoding: [0xf2,0x04,0x02,0x3e]

v_add_f16 v1, 0xbc00, v2
// VI: v_add_f16_e32 v1, -1.0, v2 ; encoding: [0xf3,0x04,0x02,0x3e]

v_add_f16 v1, 0x3800, v2
// VI: v_add_f16_e32 v1, 0.5, v2 ; encoding: [0xf0,0x04,0x02,0x3e]

v_add_f16 v1, 0xb800, v2
// VI: v_add_f16_e32 v1, -0.5, v2 ; encoding: [0xf1,0x04,0x02,0x3e]

v_add_f16 v1, 0x4000, v2
// VI: v_add_f16_e32 v1, 2.0, v2 ; encoding: [0xf4,0x04,0x02,0x3e]

v_add_f16 v1, 0xc000, v2
// VI: v_add_f16_e32 v1, -2.0, v2 ; encoding: [0xf5,0x04,0x02,0x3e]

v_add_f16 v1, 0x4400, v2
// VI: v_add_f16_e32 v1, 4.0, v2 ; encoding: [0xf6,0x04,0x02,0x3e]

v_add_f16 v1, 0xc400, v2
// VI: v_add_f16_e32 v1, -4.0, v2 ; encoding: [0xf7,0x04,0x02,0x3e]

v_add_f16 v1, 0x3118, v2
// VI: v_add_f16_e32 v1, 0.15915494, v2 ; encoding: [0xf8,0x04,0x02,0x3e]

v_add_f16 v1, -32768, v2
// VI: v_add_f16_e32 v1, 0x8000, v2 ; encoding: [0xff,0x04,0x02,0x3e,0x00,0x80,0x00,0x00]

v_add_f16 v1, 32767, v2
// VI: v_add_f16_e32 v1, 0x7fff, v2 ; encoding: [0xff,0x04,0x02,0x3e,0xff,0x7f,0x00,0x00]

v_add_f16 v1, 65535, v2
// VI: v_add_f16_e32 v1, -1, v2 ; encoding: [0xc1,0x04,0x02,0x3e]


// K-constant
v_madmk_f16 v1, v2, 0x4280, v3
// VI: v_madmk_f16 v1, v2, 0x4280, v3 ; encoding: [0x02,0x07,0x02,0x48,0x80,0x42,0x00,0x00]

v_madmk_f16 v1, v2, 1.0, v3
// VI: v_madmk_f16 v1, v2, 0x3c00, v3 ; encoding: [0x02,0x07,0x02,0x48,0x00,0x3c,0x00,0x00]

v_madmk_f16 v1, v2, 1, v3
// VI: v_madmk_f16 v1, v2, 0x1, v3 ; encoding: [0x02,0x07,0x02,0x48,0x01,0x00,0x00,0x00]

v_madmk_f16 v1, v2, 64.0, v3
// VI: v_madmk_f16 v1, v2, 0x5400, v3 ; encoding: [0x02,0x07,0x02,0x48,0x00,0x54,0x00,0x00]


v_add_f16_e32 v1, 64.0, v2
// VI: v_add_f16_e32 v1, 0x5400, v2 ; encoding: [0xff,0x04,0x02,0x3e,0x00,0x54,0x00,0x00]
