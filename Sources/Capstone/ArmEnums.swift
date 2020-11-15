// For Capstone Engine. AUTO-GENERATED FILE, DO NOT EDIT (Arm)


/// ARM shift type
public enum ArmSft: UInt32 {
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
public enum ArmCc: UInt32 {
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
public enum ArmSysreg: UInt32 {
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
    case msplim = 282
    case psplim = 283
    case mspNs = 284
    case pspNs = 285
    case msplimNs = 286
    case psplimNs = 287
    case primaskNs = 288
    case basepriNs = 289
    case faultmaskNs = 290
    case controlNs = 291
    case spNs = 292
    case r8Usr = 293
    case r9Usr = 294
    case r10Usr = 295
    case r11Usr = 296
    case r12Usr = 297
    case spUsr = 298
    case lrUsr = 299
    case r8Fiq = 300
    case r9Fiq = 301
    case r10Fiq = 302
    case r11Fiq = 303
    case r12Fiq = 304
    case spFiq = 305
    case lrFiq = 306
    case lrIrq = 307
    case spIrq = 308
    case lrSvc = 309
    case spSvc = 310
    case lrAbt = 311
    case spAbt = 312
    case lrUnd = 313
    case spUnd = 314
    case lrMon = 315
    case spMon = 316
    case elrHyp = 317
    case spHyp = 318
    case spsrFiq = 319
    case spsrIrq = 320
    case spsrSvc = 321
    case spsrAbt = 322
    case spsrUnd = 323
    case spsrMon = 324
    case spsrHyp = 325

    case spsrCx = 3
    case spsrCs = 5
    case spsrXs = 6
    case spsrCxs = 7
    case spsrCf = 9
    case spsrXf = 10
    case spsrCxf = 11
    case spsrSf = 12
    case spsrCsf = 13
    case spsrXsf = 14
    case spsrCxsf = 15
    case cpsrCx = 48
    case cpsrCs = 80
    case cpsrXs = 96
    case cpsrCxs = 112
    case cpsrCf = 144
    case cpsrXf = 160
    case cpsrCxf = 176
    case cpsrSf = 192
    case cpsrCsf = 208
    case cpsrXsf = 224
    case cpsrCxsf = 240
}

/// The memory barrier constants map directly to the 4-bit encoding of
/// the option field for Memory Barrier operations.
public enum ArmMb: UInt32 {
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
public enum ArmOp: UInt32 {
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
public enum ArmSetend: UInt32 {
    /// Uninitialized.
    case invalid = 0
    /// BE operand.
    case be = 1
    /// LE operand
    case le = 2

}

public enum ArmCpsmode: UInt32 {
    case invalid = 0
    case ie = 2
    case id = 3

}

/// Operand type for SETEND instruction
public enum ArmCpsflag: UInt32 {
    case invalid = 0
    case f = 1
    case i = 2
    case a = 4
    /// no flag
    case none = 16

}

/// Data type for elements of vector instructions.
public enum ArmVectordata: UInt32 {
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
    case f16 = 14
    case f32 = 15
    case f64 = 16
    case f16f64 = 17
    case f64f16 = 18
    case f32f16 = 19
    case f16f32 = 20
    case f64f32 = 21
    case f32f64 = 22
    case s32f32 = 23
    case u32f32 = 24
    case f32s32 = 25
    case f32u32 = 26
    case f64s16 = 27
    case f32s16 = 28
    case f64s32 = 29
    case s16f64 = 30
    case s16f32 = 31
    case s32f64 = 32
    case u16f64 = 33
    case u16f32 = 34
    case u32f64 = 35
    case f64u16 = 36
    case f32u16 = 37
    case f64u32 = 38
    case f16u16 = 39
    case u16f16 = 40
    case f16u32 = 41
    case u32f16 = 42

}

/// ARM registers
public enum ArmReg: UInt16 {
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
    public static let r13 = 12
    public static let r14 = 10
    public static let r15 = 11
    public static let sb = 75
    public static let sl = 76
    public static let fp = 77
    public static let ip = 78

}

/// ARM instruction
public enum ArmIns: UInt32 {
    case invalid = 0
    case adc = 1
    case add = 2
    case addw = 3
    case adr = 4
    case aesd = 5
    case aese = 6
    case aesimc = 7
    case aesmc = 8
    case and = 9
    case asr = 10
    case b = 11
    case bfc = 12
    case bfi = 13
    case bic = 14
    case bkpt = 15
    case bl = 16
    case blx = 17
    case blxns = 18
    case bx = 19
    case bxj = 20
    case bxns = 21
    case cbnz = 22
    case cbz = 23
    case cdp = 24
    case cdp2 = 25
    case clrex = 26
    case clz = 27
    case cmn = 28
    case cmp = 29
    case cps = 30
    case crc32b = 31
    case crc32cb = 32
    case crc32ch = 33
    case crc32cw = 34
    case crc32h = 35
    case crc32w = 36
    case csdb = 37
    case dbg = 38
    case dcps1 = 39
    case dcps2 = 40
    case dcps3 = 41
    case dfb = 42
    case dmb = 43
    case dsb = 44
    case eor = 45
    case eret = 46
    case esb = 47
    case faddd = 48
    case fadds = 49
    case fcmpzd = 50
    case fcmpzs = 51
    case fconstd = 52
    case fconsts = 53
    case fldmdbx = 54
    case fldmiax = 55
    case fmdhr = 56
    case fmdlr = 57
    case fmstat = 58
    case fstmdbx = 59
    case fstmiax = 60
    case fsubd = 61
    case fsubs = 62
    case hint = 63
    case hlt = 64
    case hvc = 65
    case isb = 66
    case it = 67
    case lda = 68
    case ldab = 69
    case ldaex = 70
    case ldaexb = 71
    case ldaexd = 72
    case ldaexh = 73
    case ldah = 74
    case ldc = 75
    case ldc2 = 76
    case ldc2l = 77
    case ldcl = 78
    case ldm = 79
    case ldmda = 80
    case ldmdb = 81
    case ldmib = 82
    case ldr = 83
    case ldrb = 84
    case ldrbt = 85
    case ldrd = 86
    case ldrex = 87
    case ldrexb = 88
    case ldrexd = 89
    case ldrexh = 90
    case ldrh = 91
    case ldrht = 92
    case ldrsb = 93
    case ldrsbt = 94
    case ldrsh = 95
    case ldrsht = 96
    case ldrt = 97
    case lsl = 98
    case lsr = 99
    case mcr = 100
    case mcr2 = 101
    case mcrr = 102
    case mcrr2 = 103
    case mla = 104
    case mls = 105
    case mov = 106
    case movs = 107
    case movt = 108
    case movw = 109
    case mrc = 110
    case mrc2 = 111
    case mrrc = 112
    case mrrc2 = 113
    case mrs = 114
    case msr = 115
    case mul = 116
    case mvn = 117
    case neg = 118
    case nop = 119
    case orn = 120
    case orr = 121
    case pkhbt = 122
    case pkhtb = 123
    case pld = 124
    case pldw = 125
    case pli = 126
    case pop = 127
    case push = 128
    case qadd = 129
    case qadd16 = 130
    case qadd8 = 131
    case qasx = 132
    case qdadd = 133
    case qdsub = 134
    case qsax = 135
    case qsub = 136
    case qsub16 = 137
    case qsub8 = 138
    case rbit = 139
    case rev = 140
    case rev16 = 141
    case revsh = 142
    case rfeda = 143
    case rfedb = 144
    case rfeia = 145
    case rfeib = 146
    case ror = 147
    case rrx = 148
    case rsb = 149
    case rsc = 150
    case sadd16 = 151
    case sadd8 = 152
    case sasx = 153
    case sbc = 154
    case sbfx = 155
    case sdiv = 156
    case sel = 157
    case setend = 158
    case setpan = 159
    case sev = 160
    case sevl = 161
    case sg = 162
    case sha1c = 163
    case sha1h = 164
    case sha1m = 165
    case sha1p = 166
    case sha1su0 = 167
    case sha1su1 = 168
    case sha256h = 169
    case sha256h2 = 170
    case sha256su0 = 171
    case sha256su1 = 172
    case shadd16 = 173
    case shadd8 = 174
    case shasx = 175
    case shsax = 176
    case shsub16 = 177
    case shsub8 = 178
    case smc = 179
    case smlabb = 180
    case smlabt = 181
    case smlad = 182
    case smladx = 183
    case smlal = 184
    case smlalbb = 185
    case smlalbt = 186
    case smlald = 187
    case smlaldx = 188
    case smlaltb = 189
    case smlaltt = 190
    case smlatb = 191
    case smlatt = 192
    case smlawb = 193
    case smlawt = 194
    case smlsd = 195
    case smlsdx = 196
    case smlsld = 197
    case smlsldx = 198
    case smmla = 199
    case smmlar = 200
    case smmls = 201
    case smmlsr = 202
    case smmul = 203
    case smmulr = 204
    case smuad = 205
    case smuadx = 206
    case smulbb = 207
    case smulbt = 208
    case smull = 209
    case smultb = 210
    case smultt = 211
    case smulwb = 212
    case smulwt = 213
    case smusd = 214
    case smusdx = 215
    case srsda = 216
    case srsdb = 217
    case srsia = 218
    case srsib = 219
    case ssat = 220
    case ssat16 = 221
    case ssax = 222
    case ssub16 = 223
    case ssub8 = 224
    case stc = 225
    case stc2 = 226
    case stc2l = 227
    case stcl = 228
    case stl = 229
    case stlb = 230
    case stlex = 231
    case stlexb = 232
    case stlexd = 233
    case stlexh = 234
    case stlh = 235
    case stm = 236
    case stmda = 237
    case stmdb = 238
    case stmib = 239
    case str = 240
    case strb = 241
    case strbt = 242
    case strd = 243
    case strex = 244
    case strexb = 245
    case strexd = 246
    case strexh = 247
    case strh = 248
    case strht = 249
    case strt = 250
    case sub = 251
    case subs = 252
    case subw = 253
    case svc = 254
    case swp = 255
    case swpb = 256
    case sxtab = 257
    case sxtab16 = 258
    case sxtah = 259
    case sxtb = 260
    case sxtb16 = 261
    case sxth = 262
    case tbb = 263
    case tbh = 264
    case teq = 265
    case trap = 266
    case tsb = 267
    case tst = 268
    case tt = 269
    case tta = 270
    case ttat = 271
    case ttt = 272
    case uadd16 = 273
    case uadd8 = 274
    case uasx = 275
    case ubfx = 276
    case udf = 277
    case udiv = 278
    case uhadd16 = 279
    case uhadd8 = 280
    case uhasx = 281
    case uhsax = 282
    case uhsub16 = 283
    case uhsub8 = 284
    case umaal = 285
    case umlal = 286
    case umull = 287
    case uqadd16 = 288
    case uqadd8 = 289
    case uqasx = 290
    case uqsax = 291
    case uqsub16 = 292
    case uqsub8 = 293
    case usad8 = 294
    case usada8 = 295
    case usat = 296
    case usat16 = 297
    case usax = 298
    case usub16 = 299
    case usub8 = 300
    case uxtab = 301
    case uxtab16 = 302
    case uxtah = 303
    case uxtb = 304
    case uxtb16 = 305
    case uxth = 306
    case vaba = 307
    case vabal = 308
    case vabd = 309
    case vabdl = 310
    case vabs = 311
    case vacge = 312
    case vacgt = 313
    case vacle = 314
    case vaclt = 315
    case vadd = 316
    case vaddhn = 317
    case vaddl = 318
    case vaddw = 319
    case vand = 320
    case vbic = 321
    case vbif = 322
    case vbit = 323
    case vbsl = 324
    case vcadd = 325
    case vceq = 326
    case vcge = 327
    case vcgt = 328
    case vcle = 329
    case vcls = 330
    case vclt = 331
    case vclz = 332
    case vcmla = 333
    case vcmp = 334
    case vcmpe = 335
    case vcnt = 336
    case vcvt = 337
    case vcvta = 338
    case vcvtb = 339
    case vcvtm = 340
    case vcvtn = 341
    case vcvtp = 342
    case vcvtr = 343
    case vcvtt = 344
    case vdiv = 345
    case vdup = 346
    case veor = 347
    case vext = 348
    case vfma = 349
    case vfms = 350
    case vfnma = 351
    case vfnms = 352
    case vhadd = 353
    case vhsub = 354
    case vins = 355
    case vjcvt = 356
    case vld1 = 357
    case vld2 = 358
    case vld3 = 359
    case vld4 = 360
    case vldmdb = 361
    case vldmia = 362
    case vldr = 363
    case vlldm = 364
    case vlstm = 365
    case vmax = 366
    case vmaxnm = 367
    case vmin = 368
    case vminnm = 369
    case vmla = 370
    case vmlal = 371
    case vmls = 372
    case vmlsl = 373
    case vmov = 374
    case vmovl = 375
    case vmovn = 376
    case vmovx = 377
    case vmrs = 378
    case vmsr = 379
    case vmul = 380
    case vmull = 381
    case vmvn = 382
    case vneg = 383
    case vnmla = 384
    case vnmls = 385
    case vnmul = 386
    case vorn = 387
    case vorr = 388
    case vpadal = 389
    case vpadd = 390
    case vpaddl = 391
    case vpmax = 392
    case vpmin = 393
    case vpop = 394
    case vpush = 395
    case vqabs = 396
    case vqadd = 397
    case vqdmlal = 398
    case vqdmlsl = 399
    case vqdmulh = 400
    case vqdmull = 401
    case vqmovn = 402
    case vqmovun = 403
    case vqneg = 404
    case vqrdmlah = 405
    case vqrdmlsh = 406
    case vqrdmulh = 407
    case vqrshl = 408
    case vqrshrn = 409
    case vqrshrun = 410
    case vqshl = 411
    case vqshlu = 412
    case vqshrn = 413
    case vqshrun = 414
    case vqsub = 415
    case vraddhn = 416
    case vrecpe = 417
    case vrecps = 418
    case vrev16 = 419
    case vrev32 = 420
    case vrev64 = 421
    case vrhadd = 422
    case vrinta = 423
    case vrintm = 424
    case vrintn = 425
    case vrintp = 426
    case vrintr = 427
    case vrintx = 428
    case vrintz = 429
    case vrshl = 430
    case vrshr = 431
    case vrshrn = 432
    case vrsqrte = 433
    case vrsqrts = 434
    case vrsra = 435
    case vrsubhn = 436
    case vsdot = 437
    case vseleq = 438
    case vselge = 439
    case vselgt = 440
    case vselvs = 441
    case vshl = 442
    case vshll = 443
    case vshr = 444
    case vshrn = 445
    case vsli = 446
    case vsqrt = 447
    case vsra = 448
    case vsri = 449
    case vst1 = 450
    case vst2 = 451
    case vst3 = 452
    case vst4 = 453
    case vstmdb = 454
    case vstmia = 455
    case vstr = 456
    case vsub = 457
    case vsubhn = 458
    case vsubl = 459
    case vsubw = 460
    case vswp = 461
    case vtbl = 462
    case vtbx = 463
    case vtrn = 464
    case vtst = 465
    case vudot = 466
    case vuzp = 467
    case vzip = 468
    case wfe = 469
    case wfi = 470
    case yield = 471
    case ending = 472

}

/// Group of ARM instructions
public enum ArmGrp: UInt8 {
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

