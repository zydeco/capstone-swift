// For Capstone Engine. AUTO-GENERATED FILE, DO NOT EDIT (Arm)


/// ARM shift type
public enum armSft: UInt32 {
    case invalid = 0
    /// shift with immediate const
    case asr = 1
    /// shift with immediate const
    case lsl = 2
    /// shift with immediate const
    case lsr = 3
    /// shift with immediate const
    case ror = 4
    /// shift with immediate const
    case rrx = 5
    /// shift with register
    case asrReg = 6
    /// shift with register
    case lslReg = 7
    /// shift with register
    case lsrReg = 8
    /// shift with register
    case rorReg = 9
    /// shift with register
    case rrxReg = 10

}

/// ARM condition code
public enum armCc: UInt32 {
    case invalid = 0
    /// Equal                      Equal
    case eq = 1
    /// Not equal                  Not equal, or unordered
    case ne = 2
    /// Carry set                  >, ==, or unordered
    case hs = 3
    /// Carry clear                Less than
    case lo = 4
    /// Minus, negative            Less than
    case mi = 5
    /// Plus, positive or zero     >, ==, or unordered
    case pl = 6
    /// Overflow                   Unordered
    case vs = 7
    /// No overflow                Not unordered
    case vc = 8
    /// Unsigned higher            Greater than, or unordered
    case hi = 9
    /// Unsigned lower or same     Less than or equal
    case ls = 10
    /// Greater than or equal      Greater than or equal
    case ge = 11
    /// Less than                  Less than, or unordered
    case lt = 12
    /// Greater than               Greater than
    case gt = 13
    /// Less than or equal         <, ==, or unordered
    case le = 14
    /// Always (unconditional)     Always (unconditional)
    case al = 15

}

/// Special registers for MSR
public enum armSysreg: UInt32 {
    case invalid = 0
    case spsrC = 1
    case spsrX = 2
    case spsrS = 4
    case spsrF = 8
    case cpsrC = 16
    case cpsrX = 32
    case cpsrS = 64
    case cpsrF = 128
    case apsr = 256
    case apsrG = 257
    case apsrNzcvq = 258
    case apsrNzcvqg = 259
    case iapsr = 260
    case iapsrG = 261
    case iapsrNzcvqg = 262
    case iapsrNzcvq = 263
    case eapsr = 264
    case eapsrG = 265
    case eapsrNzcvqg = 266
    case eapsrNzcvq = 267
    case xpsr = 268
    case xpsrG = 269
    case xpsrNzcvqg = 270
    case xpsrNzcvq = 271
    case ipsr = 272
    case epsr = 273
    case iepsr = 274
    case msp = 275
    case psp = 276
    case primask = 277
    case basepri = 278
    case basepriMax = 279
    case faultmask = 280
    case control = 281
    case r8Usr = 282
    case r9Usr = 283
    case r10Usr = 284
    case r11Usr = 285
    case r12Usr = 286
    case spUsr = 287
    case lrUsr = 288
    case r8Fiq = 289
    case r9Fiq = 290
    case r10Fiq = 291
    case r11Fiq = 292
    case r12Fiq = 293
    case spFiq = 294
    case lrFiq = 295
    case lrIrq = 296
    case spIrq = 297
    case lrSvc = 298
    case spSvc = 299
    case lrAbt = 300
    case spAbt = 301
    case lrUnd = 302
    case spUnd = 303
    case lrMon = 304
    case spMon = 305
    case elrHyp = 306
    case spHyp = 307
    case spsrFiq = 308
    case spsrIrq = 309
    case spsrSvc = 310
    case spsrAbt = 311
    case spsrUnd = 312
    case spsrMon = 313
    case spsrHyp = 314

}

/// The memory barrier constants map directly to the 4-bit encoding of
/// the option field for Memory Barrier operations.
public enum armMb: UInt32 {
    case invalid = 0
    case reserved0 = 1
    case oshld = 2
    case oshst = 3
    case osh = 4
    case reserved4 = 5
    case nshld = 6
    case nshst = 7
    case nsh = 8
    case reserved8 = 9
    case ishld = 10
    case ishst = 11
    case ish = 12
    case reserved12 = 13
    case ld = 14
    case st = 15
    case sy = 16

}

/// Operand type for instruction's operands
public enum armOp: UInt32 {
    /// = CS_OP_INVALID (Uninitialized).
    case invalid = 0
    /// = CS_OP_REG (Register operand).
    case reg = 1
    /// = CS_OP_IMM (Immediate operand).
    case imm = 2
    /// = CS_OP_MEM (Memory operand).
    case mem = 3
    /// = CS_OP_FP (Floating-Point operand).
    case fp = 4
    /// C-Immediate (coprocessor registers)
    case cimm = 64
    /// P-Immediate (coprocessor registers)
    case pimm = 65
    /// operand for SETEND instruction
    case setend = 66
    /// MSR/MRS special register operand
    case sysreg = 67

}

/// Operand type for SETEND instruction
public enum armSetend: UInt32 {
    /// Uninitialized.
    case invalid = 0
    /// BE operand.
    case be = 1
    /// LE operand
    case le = 2

}

public enum armCpsmode: UInt32 {
    case invalid = 0
    case ie = 2
    case id = 3

}

/// Operand type for SETEND instruction
public enum armCpsflag: UInt32 {
    case invalid = 0
    case f = 1
    case i = 2
    case a = 4
    /// no flag
    case none = 16

}

/// Data type for elements of vector instructions.
public enum armVectordata: UInt32 {
    case invalid = 0
    case i8 = 1
    case i16 = 2
    case i32 = 3
    case i64 = 4
    case s8 = 5
    case s16 = 6
    case s32 = 7
    case s64 = 8
    case u8 = 9
    case u16 = 10
    case u32 = 11
    case u64 = 12
    case p8 = 13
    case f32 = 14
    case f64 = 15
    case f16f64 = 16
    case f64f16 = 17
    case f32f16 = 18
    case f16f32 = 19
    case f64f32 = 20
    case f32f64 = 21
    case s32f32 = 22
    case u32f32 = 23
    case f32s32 = 24
    case f32u32 = 25
    case f64s16 = 26
    case f32s16 = 27
    case f64s32 = 28
    case s16f64 = 29
    case s16f32 = 30
    case s32f64 = 31
    case u16f64 = 32
    case u16f32 = 33
    case u32f64 = 34
    case f64u16 = 35
    case f32u16 = 36
    case f64u32 = 37

}

/// ARM registers
public enum armReg: UInt16 {
    case invalid = 0
    case apsr = 1
    case apsrNzcv = 2
    case cpsr = 3
    case fpexc = 4
    case fpinst = 5
    case fpscr = 6
    case fpscrNzcv = 7
    case fpsid = 8
    case itstate = 9
    case lr = 10
    case pc = 11
    case sp = 12
    case spsr = 13
    case d0 = 14
    case d1 = 15
    case d2 = 16
    case d3 = 17
    case d4 = 18
    case d5 = 19
    case d6 = 20
    case d7 = 21
    case d8 = 22
    case d9 = 23
    case d10 = 24
    case d11 = 25
    case d12 = 26
    case d13 = 27
    case d14 = 28
    case d15 = 29
    case d16 = 30
    case d17 = 31
    case d18 = 32
    case d19 = 33
    case d20 = 34
    case d21 = 35
    case d22 = 36
    case d23 = 37
    case d24 = 38
    case d25 = 39
    case d26 = 40
    case d27 = 41
    case d28 = 42
    case d29 = 43
    case d30 = 44
    case d31 = 45
    case fpinst2 = 46
    case mvfr0 = 47
    case mvfr1 = 48
    case mvfr2 = 49
    case q0 = 50
    case q1 = 51
    case q2 = 52
    case q3 = 53
    case q4 = 54
    case q5 = 55
    case q6 = 56
    case q7 = 57
    case q8 = 58
    case q9 = 59
    case q10 = 60
    case q11 = 61
    case q12 = 62
    case q13 = 63
    case q14 = 64
    case q15 = 65
    case r0 = 66
    case r1 = 67
    case r2 = 68
    case r3 = 69
    case r4 = 70
    case r5 = 71
    case r6 = 72
    case r7 = 73
    case r8 = 74
    case r9 = 75
    case r10 = 76
    case r11 = 77
    case r12 = 78
    case s0 = 79
    case s1 = 80
    case s2 = 81
    case s3 = 82
    case s4 = 83
    case s5 = 84
    case s6 = 85
    case s7 = 86
    case s8 = 87
    case s9 = 88
    case s10 = 89
    case s11 = 90
    case s12 = 91
    case s13 = 92
    case s14 = 93
    case s15 = 94
    case s16 = 95
    case s17 = 96
    case s18 = 97
    case s19 = 98
    case s20 = 99
    case s21 = 100
    case s22 = 101
    case s23 = 102
    case s24 = 103
    case s25 = 104
    case s26 = 105
    case s27 = 106
    case s28 = 107
    case s29 = 108
    case s30 = 109
    case s31 = 110
    case ending = 111
    static let r13 = 12
    static let r14 = 10
    static let r15 = 11
    static let sb = 75
    static let sl = 76
    static let fp = 77
    static let ip = 78

}

/// ARM instruction
public enum armIns: UInt32 {
    case invalid = 0
    case adc = 1
    case add = 2
    case adr = 3
    case aesd = 4
    case aese = 5
    case aesimc = 6
    case aesmc = 7
    case and = 8
    case bfc = 9
    case bfi = 10
    case bic = 11
    case bkpt = 12
    case bl = 13
    case blx = 14
    case bx = 15
    case bxj = 16
    case b = 17
    case cdp = 18
    case cdp2 = 19
    case clrex = 20
    case clz = 21
    case cmn = 22
    case cmp = 23
    case cps = 24
    case crc32b = 25
    case crc32cb = 26
    case crc32ch = 27
    case crc32cw = 28
    case crc32h = 29
    case crc32w = 30
    case dbg = 31
    case dmb = 32
    case dsb = 33
    case eor = 34
    case eret = 35
    case vmov = 36
    case fldmdbx = 37
    case fldmiax = 38
    case vmrs = 39
    case fstmdbx = 40
    case fstmiax = 41
    case hint = 42
    case hlt = 43
    case hvc = 44
    case isb = 45
    case lda = 46
    case ldab = 47
    case ldaex = 48
    case ldaexb = 49
    case ldaexd = 50
    case ldaexh = 51
    case ldah = 52
    case ldc2l = 53
    case ldc2 = 54
    case ldcl = 55
    case ldc = 56
    case ldmda = 57
    case ldmdb = 58
    case ldm = 59
    case ldmib = 60
    case ldrbt = 61
    case ldrb = 62
    case ldrd = 63
    case ldrex = 64
    case ldrexb = 65
    case ldrexd = 66
    case ldrexh = 67
    case ldrh = 68
    case ldrht = 69
    case ldrsb = 70
    case ldrsbt = 71
    case ldrsh = 72
    case ldrsht = 73
    case ldrt = 74
    case ldr = 75
    case mcr = 76
    case mcr2 = 77
    case mcrr = 78
    case mcrr2 = 79
    case mla = 80
    case mls = 81
    case mov = 82
    case movt = 83
    case movw = 84
    case mrc = 85
    case mrc2 = 86
    case mrrc = 87
    case mrrc2 = 88
    case mrs = 89
    case msr = 90
    case mul = 91
    case mvn = 92
    case orr = 93
    case pkhbt = 94
    case pkhtb = 95
    case pldw = 96
    case pld = 97
    case pli = 98
    case qadd = 99
    case qadd16 = 100
    case qadd8 = 101
    case qasx = 102
    case qdadd = 103
    case qdsub = 104
    case qsax = 105
    case qsub = 106
    case qsub16 = 107
    case qsub8 = 108
    case rbit = 109
    case rev = 110
    case rev16 = 111
    case revsh = 112
    case rfeda = 113
    case rfedb = 114
    case rfeia = 115
    case rfeib = 116
    case rsb = 117
    case rsc = 118
    case sadd16 = 119
    case sadd8 = 120
    case sasx = 121
    case sbc = 122
    case sbfx = 123
    case sdiv = 124
    case sel = 125
    case setend = 126
    case sha1c = 127
    case sha1h = 128
    case sha1m = 129
    case sha1p = 130
    case sha1su0 = 131
    case sha1su1 = 132
    case sha256h = 133
    case sha256h2 = 134
    case sha256su0 = 135
    case sha256su1 = 136
    case shadd16 = 137
    case shadd8 = 138
    case shasx = 139
    case shsax = 140
    case shsub16 = 141
    case shsub8 = 142
    case smc = 143
    case smlabb = 144
    case smlabt = 145
    case smlad = 146
    case smladx = 147
    case smlal = 148
    case smlalbb = 149
    case smlalbt = 150
    case smlald = 151
    case smlaldx = 152
    case smlaltb = 153
    case smlaltt = 154
    case smlatb = 155
    case smlatt = 156
    case smlawb = 157
    case smlawt = 158
    case smlsd = 159
    case smlsdx = 160
    case smlsld = 161
    case smlsldx = 162
    case smmla = 163
    case smmlar = 164
    case smmls = 165
    case smmlsr = 166
    case smmul = 167
    case smmulr = 168
    case smuad = 169
    case smuadx = 170
    case smulbb = 171
    case smulbt = 172
    case smull = 173
    case smultb = 174
    case smultt = 175
    case smulwb = 176
    case smulwt = 177
    case smusd = 178
    case smusdx = 179
    case srsda = 180
    case srsdb = 181
    case srsia = 182
    case srsib = 183
    case ssat = 184
    case ssat16 = 185
    case ssax = 186
    case ssub16 = 187
    case ssub8 = 188
    case stc2l = 189
    case stc2 = 190
    case stcl = 191
    case stc = 192
    case stl = 193
    case stlb = 194
    case stlex = 195
    case stlexb = 196
    case stlexd = 197
    case stlexh = 198
    case stlh = 199
    case stmda = 200
    case stmdb = 201
    case stm = 202
    case stmib = 203
    case strbt = 204
    case strb = 205
    case strd = 206
    case strex = 207
    case strexb = 208
    case strexd = 209
    case strexh = 210
    case strh = 211
    case strht = 212
    case strt = 213
    case str = 214
    case sub = 215
    case svc = 216
    case swp = 217
    case swpb = 218
    case sxtab = 219
    case sxtab16 = 220
    case sxtah = 221
    case sxtb = 222
    case sxtb16 = 223
    case sxth = 224
    case teq = 225
    case trap = 226
    case tst = 227
    case uadd16 = 228
    case uadd8 = 229
    case uasx = 230
    case ubfx = 231
    case udf = 232
    case udiv = 233
    case uhadd16 = 234
    case uhadd8 = 235
    case uhasx = 236
    case uhsax = 237
    case uhsub16 = 238
    case uhsub8 = 239
    case umaal = 240
    case umlal = 241
    case umull = 242
    case uqadd16 = 243
    case uqadd8 = 244
    case uqasx = 245
    case uqsax = 246
    case uqsub16 = 247
    case uqsub8 = 248
    case usad8 = 249
    case usada8 = 250
    case usat = 251
    case usat16 = 252
    case usax = 253
    case usub16 = 254
    case usub8 = 255
    case uxtab = 256
    case uxtab16 = 257
    case uxtah = 258
    case uxtb = 259
    case uxtb16 = 260
    case uxth = 261
    case vabal = 262
    case vaba = 263
    case vabdl = 264
    case vabd = 265
    case vabs = 266
    case vacge = 267
    case vacgt = 268
    case vadd = 269
    case vaddhn = 270
    case vaddl = 271
    case vaddw = 272
    case vand = 273
    case vbic = 274
    case vbif = 275
    case vbit = 276
    case vbsl = 277
    case vceq = 278
    case vcge = 279
    case vcgt = 280
    case vcle = 281
    case vcls = 282
    case vclt = 283
    case vclz = 284
    case vcmp = 285
    case vcmpe = 286
    case vcnt = 287
    case vcvta = 288
    case vcvtb = 289
    case vcvt = 290
    case vcvtm = 291
    case vcvtn = 292
    case vcvtp = 293
    case vcvtt = 294
    case vdiv = 295
    case vdup = 296
    case veor = 297
    case vext = 298
    case vfma = 299
    case vfms = 300
    case vfnma = 301
    case vfnms = 302
    case vhadd = 303
    case vhsub = 304
    case vld1 = 305
    case vld2 = 306
    case vld3 = 307
    case vld4 = 308
    case vldmdb = 309
    case vldmia = 310
    case vldr = 311
    case vmaxnm = 312
    case vmax = 313
    case vminnm = 314
    case vmin = 315
    case vmla = 316
    case vmlal = 317
    case vmls = 318
    case vmlsl = 319
    case vmovl = 320
    case vmovn = 321
    case vmsr = 322
    case vmul = 323
    case vmull = 324
    case vmvn = 325
    case vneg = 326
    case vnmla = 327
    case vnmls = 328
    case vnmul = 329
    case vorn = 330
    case vorr = 331
    case vpadal = 332
    case vpaddl = 333
    case vpadd = 334
    case vpmax = 335
    case vpmin = 336
    case vqabs = 337
    case vqadd = 338
    case vqdmlal = 339
    case vqdmlsl = 340
    case vqdmulh = 341
    case vqdmull = 342
    case vqmovun = 343
    case vqmovn = 344
    case vqneg = 345
    case vqrdmulh = 346
    case vqrshl = 347
    case vqrshrn = 348
    case vqrshrun = 349
    case vqshl = 350
    case vqshlu = 351
    case vqshrn = 352
    case vqshrun = 353
    case vqsub = 354
    case vraddhn = 355
    case vrecpe = 356
    case vrecps = 357
    case vrev16 = 358
    case vrev32 = 359
    case vrev64 = 360
    case vrhadd = 361
    case vrinta = 362
    case vrintm = 363
    case vrintn = 364
    case vrintp = 365
    case vrintr = 366
    case vrintx = 367
    case vrintz = 368
    case vrshl = 369
    case vrshrn = 370
    case vrshr = 371
    case vrsqrte = 372
    case vrsqrts = 373
    case vrsra = 374
    case vrsubhn = 375
    case vseleq = 376
    case vselge = 377
    case vselgt = 378
    case vselvs = 379
    case vshll = 380
    case vshl = 381
    case vshrn = 382
    case vshr = 383
    case vsli = 384
    case vsqrt = 385
    case vsra = 386
    case vsri = 387
    case vst1 = 388
    case vst2 = 389
    case vst3 = 390
    case vst4 = 391
    case vstmdb = 392
    case vstmia = 393
    case vstr = 394
    case vsub = 395
    case vsubhn = 396
    case vsubl = 397
    case vsubw = 398
    case vswp = 399
    case vtbl = 400
    case vtbx = 401
    case vcvtr = 402
    case vtrn = 403
    case vtst = 404
    case vuzp = 405
    case vzip = 406
    case addw = 407
    case asr = 408
    case dcps1 = 409
    case dcps2 = 410
    case dcps3 = 411
    case it = 412
    case lsl = 413
    case lsr = 414
    case orn = 415
    case ror = 416
    case rrx = 417
    case subw = 418
    case tbb = 419
    case tbh = 420
    case cbnz = 421
    case cbz = 422
    case pop = 423
    case push = 424
    case nop = 425
    case yield = 426
    case wfe = 427
    case wfi = 428
    case sev = 429
    case sevl = 430
    case vpush = 431
    case vpop = 432
    case ending = 433

}

/// Group of ARM instructions
public enum armGrp: UInt8 {
    /// = CS_GRP_INVALID
    case invalid = 0
    /// = CS_GRP_JUMP
    case jump = 1
    /// = CS_GRP_CALL
    case call = 2
    /// = CS_GRP_INT
    case int = 4
    /// = CS_GRP_PRIVILEGE
    case privilege = 6
    /// = CS_GRP_BRANCH_RELATIVE
    case branchRelative = 7
    case crypto = 128
    case databarrier = 129
    case divide = 130
    case fparmv8 = 131
    case multpro = 132
    case neon = 133
    case t2extractpack = 134
    case thumb2dsp = 135
    case trustzone = 136
    case v4t = 137
    case v5t = 138
    case v5te = 139
    case v6 = 140
    case v6t2 = 141
    case v7 = 142
    case v8 = 143
    case vfp2 = 144
    case vfp3 = 145
    case vfp4 = 146
    case arm = 147
    case mclass = 148
    case notmclass = 149
    case thumb = 150
    case thumb1only = 151
    case thumb2 = 152
    case prev8 = 153
    case fpvmlx = 154
    case mulops = 155
    case crc = 156
    case dpvfp = 157
    case v6m = 158
    case virtualization = 159
    case ending = 160
}

