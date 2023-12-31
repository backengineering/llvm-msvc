# RUN: llvm-mc -triple x86_64 -x86-asm-syntax=intel -output-asm-variant=1 --show-encoding %s | FileCheck %s

# CHECK: ldtilecfg	[r28 + 4*r29 + 291]
# CHECK: encoding: [0x62,0x9a,0x78,0x08,0x49,0x84,0xac,0x23,0x01,0x00,0x00]
         ldtilecfg	[r28 + 4*r29 + 291]

# CHECK: sttilecfg	[r28 + 4*r29 + 291]
# CHECK: encoding: [0x62,0x9a,0x79,0x08,0x49,0x84,0xac,0x23,0x01,0x00,0x00]
         sttilecfg	[r28 + 4*r29 + 291]

# CHECK: tileloadd	tmm6, [r28 + 4*r29 + 291]
# CHECK: encoding: [0x62,0x9a,0x7b,0x08,0x4b,0xb4,0xac,0x23,0x01,0x00,0x00]
         tileloadd	tmm6, [r28 + 4*r29 + 291]

# CHECK: tileloaddt1	tmm6, [r28 + 4*r29 + 291]
# CHECK: encoding: [0x62,0x9a,0x79,0x08,0x4b,0xb4,0xac,0x23,0x01,0x00,0x00]
         tileloaddt1	tmm6, [r28 + 4*r29 + 291]

# CHECK: tilestored	[r28 + 4*r29 + 291], tmm6
# CHECK: encoding: [0x62,0x9a,0x7a,0x08,0x4b,0xb4,0xac,0x23,0x01,0x00,0x00]
         tilestored	[r28 + 4*r29 + 291], tmm6
