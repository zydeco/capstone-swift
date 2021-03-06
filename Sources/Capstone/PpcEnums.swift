// For Capstone Engine. AUTO-GENERATED FILE, DO NOT EDIT (Ppc)


/// PPC branch codes for some branch instructions
public enum PpcBc: UInt32 {
    case invalid = 0
    case lt = 12
    case le = 36
    case eq = 76
    case ge = 4
    case gt = 44
    case ne = 68
    case un = 108
    case nu = 100
    /// summary overflow
    case so = 140
    /// not summary overflow
    case ns = 132

}

/// PPC branch hint for some branch instructions
public enum PpcBh: UInt32 {
    /// no hint
    case invalid = 0
    /// PLUS hint
    case plus = 1
    /// MINUS hint
    case minus = 2

}

/// Operand type for instruction's operands
public enum PpcOp: UInt32 {
    /// = CS_OP_INVALID (Uninitialized).
    case invalid = 0
    /// = CS_OP_REG (Register operand).
    case reg = 1
    /// = CS_OP_IMM (Immediate operand).
    case imm = 2
    /// = CS_OP_MEM (Memory operand).
    case mem = 3
    /// Condition Register field
    case crx = 64

}

/// PPC registers
public enum PpcReg: UInt16 {
    case invalid = 0
    case carry = 1
    case cr0 = 2
    case cr1 = 3
    case cr2 = 4
    case cr3 = 5
    case cr4 = 6
    case cr5 = 7
    case cr6 = 8
    case cr7 = 9
    case ctr = 10
    case f0 = 11
    case f1 = 12
    case f2 = 13
    case f3 = 14
    case f4 = 15
    case f5 = 16
    case f6 = 17
    case f7 = 18
    case f8 = 19
    case f9 = 20
    case f10 = 21
    case f11 = 22
    case f12 = 23
    case f13 = 24
    case f14 = 25
    case f15 = 26
    case f16 = 27
    case f17 = 28
    case f18 = 29
    case f19 = 30
    case f20 = 31
    case f21 = 32
    case f22 = 33
    case f23 = 34
    case f24 = 35
    case f25 = 36
    case f26 = 37
    case f27 = 38
    case f28 = 39
    case f29 = 40
    case f30 = 41
    case f31 = 42
    case lr = 43
    case r0 = 44
    case r1 = 45
    case r2 = 46
    case r3 = 47
    case r4 = 48
    case r5 = 49
    case r6 = 50
    case r7 = 51
    case r8 = 52
    case r9 = 53
    case r10 = 54
    case r11 = 55
    case r12 = 56
    case r13 = 57
    case r14 = 58
    case r15 = 59
    case r16 = 60
    case r17 = 61
    case r18 = 62
    case r19 = 63
    case r20 = 64
    case r21 = 65
    case r22 = 66
    case r23 = 67
    case r24 = 68
    case r25 = 69
    case r26 = 70
    case r27 = 71
    case r28 = 72
    case r29 = 73
    case r30 = 74
    case r31 = 75
    case v0 = 76
    case v1 = 77
    case v2 = 78
    case v3 = 79
    case v4 = 80
    case v5 = 81
    case v6 = 82
    case v7 = 83
    case v8 = 84
    case v9 = 85
    case v10 = 86
    case v11 = 87
    case v12 = 88
    case v13 = 89
    case v14 = 90
    case v15 = 91
    case v16 = 92
    case v17 = 93
    case v18 = 94
    case v19 = 95
    case v20 = 96
    case v21 = 97
    case v22 = 98
    case v23 = 99
    case v24 = 100
    case v25 = 101
    case v26 = 102
    case v27 = 103
    case v28 = 104
    case v29 = 105
    case v30 = 106
    case v31 = 107
    case vrsave = 108
    case vs0 = 109
    case vs1 = 110
    case vs2 = 111
    case vs3 = 112
    case vs4 = 113
    case vs5 = 114
    case vs6 = 115
    case vs7 = 116
    case vs8 = 117
    case vs9 = 118
    case vs10 = 119
    case vs11 = 120
    case vs12 = 121
    case vs13 = 122
    case vs14 = 123
    case vs15 = 124
    case vs16 = 125
    case vs17 = 126
    case vs18 = 127
    case vs19 = 128
    case vs20 = 129
    case vs21 = 130
    case vs22 = 131
    case vs23 = 132
    case vs24 = 133
    case vs25 = 134
    case vs26 = 135
    case vs27 = 136
    case vs28 = 137
    case vs29 = 138
    case vs30 = 139
    case vs31 = 140
    case vs32 = 141
    case vs33 = 142
    case vs34 = 143
    case vs35 = 144
    case vs36 = 145
    case vs37 = 146
    case vs38 = 147
    case vs39 = 148
    case vs40 = 149
    case vs41 = 150
    case vs42 = 151
    case vs43 = 152
    case vs44 = 153
    case vs45 = 154
    case vs46 = 155
    case vs47 = 156
    case vs48 = 157
    case vs49 = 158
    case vs50 = 159
    case vs51 = 160
    case vs52 = 161
    case vs53 = 162
    case vs54 = 163
    case vs55 = 164
    case vs56 = 165
    case vs57 = 166
    case vs58 = 167
    case vs59 = 168
    case vs60 = 169
    case vs61 = 170
    case vs62 = 171
    case vs63 = 172
    case q0 = 173
    case q1 = 174
    case q2 = 175
    case q3 = 176
    case q4 = 177
    case q5 = 178
    case q6 = 179
    case q7 = 180
    case q8 = 181
    case q9 = 182
    case q10 = 183
    case q11 = 184
    case q12 = 185
    case q13 = 186
    case q14 = 187
    case q15 = 188
    case q16 = 189
    case q17 = 190
    case q18 = 191
    case q19 = 192
    case q20 = 193
    case q21 = 194
    case q22 = 195
    case q23 = 196
    case q24 = 197
    case q25 = 198
    case q26 = 199
    case q27 = 200
    case q28 = 201
    case q29 = 202
    case q30 = 203
    case q31 = 204
    case rm = 205
    case ctr8 = 206
    case lr8 = 207
    case cr1eq = 208
    case x2 = 209
    case ending = 210

}

/// PPC instruction
public enum PpcIns: UInt32 {
    case invalid = 0
    case add = 1
    case addc = 2
    case adde = 3
    case addi = 4
    case addic = 5
    case addis = 6
    case addme = 7
    case addze = 8
    case and = 9
    case andc = 10
    case andis = 11
    case andi = 12
    case attn = 13
    case b = 14
    case ba = 15
    case bc = 16
    case bcctr = 17
    case bcctrl = 18
    case bcl = 19
    case bclr = 20
    case bclrl = 21
    case bctr = 22
    case bctrl = 23
    case bct = 24
    case bdnz = 25
    case bdnza = 26
    case bdnzl = 27
    case bdnzla = 28
    case bdnzlr = 29
    case bdnzlrl = 30
    case bdz = 31
    case bdza = 32
    case bdzl = 33
    case bdzla = 34
    case bdzlr = 35
    case bdzlrl = 36
    case bl = 37
    case bla = 38
    case blr = 39
    case blrl = 40
    case brinc = 41
    case cmpb = 42
    case cmpd = 43
    case cmpdi = 44
    case cmpld = 45
    case cmpldi = 46
    case cmplw = 47
    case cmplwi = 48
    case cmpw = 49
    case cmpwi = 50
    case cntlzd = 51
    case cntlzw = 52
    case creqv = 53
    case crxor = 54
    case crand = 55
    case crandc = 56
    case crnand = 57
    case crnor = 58
    case cror = 59
    case crorc = 60
    case dcba = 61
    case dcbf = 62
    case dcbi = 63
    case dcbst = 64
    case dcbt = 65
    case dcbtst = 66
    case dcbz = 67
    case dcbzl = 68
    case dccci = 69
    case divd = 70
    case divdu = 71
    case divw = 72
    case divwu = 73
    case dss = 74
    case dssall = 75
    case dst = 76
    case dstst = 77
    case dststt = 78
    case dstt = 79
    case eqv = 80
    case evabs = 81
    case evaddiw = 82
    case evaddsmiaaw = 83
    case evaddssiaaw = 84
    case evaddumiaaw = 85
    case evaddusiaaw = 86
    case evaddw = 87
    case evand = 88
    case evandc = 89
    case evcmpeq = 90
    case evcmpgts = 91
    case evcmpgtu = 92
    case evcmplts = 93
    case evcmpltu = 94
    case evcntlsw = 95
    case evcntlzw = 96
    case evdivws = 97
    case evdivwu = 98
    case eveqv = 99
    case evextsb = 100
    case evextsh = 101
    case evldd = 102
    case evlddx = 103
    case evldh = 104
    case evldhx = 105
    case evldw = 106
    case evldwx = 107
    case evlhhesplat = 108
    case evlhhesplatx = 109
    case evlhhossplat = 110
    case evlhhossplatx = 111
    case evlhhousplat = 112
    case evlhhousplatx = 113
    case evlwhe = 114
    case evlwhex = 115
    case evlwhos = 116
    case evlwhosx = 117
    case evlwhou = 118
    case evlwhoux = 119
    case evlwhsplat = 120
    case evlwhsplatx = 121
    case evlwwsplat = 122
    case evlwwsplatx = 123
    case evmergehi = 124
    case evmergehilo = 125
    case evmergelo = 126
    case evmergelohi = 127
    case evmhegsmfaa = 128
    case evmhegsmfan = 129
    case evmhegsmiaa = 130
    case evmhegsmian = 131
    case evmhegumiaa = 132
    case evmhegumian = 133
    case evmhesmf = 134
    case evmhesmfa = 135
    case evmhesmfaaw = 136
    case evmhesmfanw = 137
    case evmhesmi = 138
    case evmhesmia = 139
    case evmhesmiaaw = 140
    case evmhesmianw = 141
    case evmhessf = 142
    case evmhessfa = 143
    case evmhessfaaw = 144
    case evmhessfanw = 145
    case evmhessiaaw = 146
    case evmhessianw = 147
    case evmheumi = 148
    case evmheumia = 149
    case evmheumiaaw = 150
    case evmheumianw = 151
    case evmheusiaaw = 152
    case evmheusianw = 153
    case evmhogsmfaa = 154
    case evmhogsmfan = 155
    case evmhogsmiaa = 156
    case evmhogsmian = 157
    case evmhogumiaa = 158
    case evmhogumian = 159
    case evmhosmf = 160
    case evmhosmfa = 161
    case evmhosmfaaw = 162
    case evmhosmfanw = 163
    case evmhosmi = 164
    case evmhosmia = 165
    case evmhosmiaaw = 166
    case evmhosmianw = 167
    case evmhossf = 168
    case evmhossfa = 169
    case evmhossfaaw = 170
    case evmhossfanw = 171
    case evmhossiaaw = 172
    case evmhossianw = 173
    case evmhoumi = 174
    case evmhoumia = 175
    case evmhoumiaaw = 176
    case evmhoumianw = 177
    case evmhousiaaw = 178
    case evmhousianw = 179
    case evmra = 180
    case evmwhsmf = 181
    case evmwhsmfa = 182
    case evmwhsmi = 183
    case evmwhsmia = 184
    case evmwhssf = 185
    case evmwhssfa = 186
    case evmwhumi = 187
    case evmwhumia = 188
    case evmwlsmiaaw = 189
    case evmwlsmianw = 190
    case evmwlssiaaw = 191
    case evmwlssianw = 192
    case evmwlumi = 193
    case evmwlumia = 194
    case evmwlumiaaw = 195
    case evmwlumianw = 196
    case evmwlusiaaw = 197
    case evmwlusianw = 198
    case evmwsmf = 199
    case evmwsmfa = 200
    case evmwsmfaa = 201
    case evmwsmfan = 202
    case evmwsmi = 203
    case evmwsmia = 204
    case evmwsmiaa = 205
    case evmwsmian = 206
    case evmwssf = 207
    case evmwssfa = 208
    case evmwssfaa = 209
    case evmwssfan = 210
    case evmwumi = 211
    case evmwumia = 212
    case evmwumiaa = 213
    case evmwumian = 214
    case evnand = 215
    case evneg = 216
    case evnor = 217
    case evor = 218
    case evorc = 219
    case evrlw = 220
    case evrlwi = 221
    case evrndw = 222
    case evslw = 223
    case evslwi = 224
    case evsplatfi = 225
    case evsplati = 226
    case evsrwis = 227
    case evsrwiu = 228
    case evsrws = 229
    case evsrwu = 230
    case evstdd = 231
    case evstddx = 232
    case evstdh = 233
    case evstdhx = 234
    case evstdw = 235
    case evstdwx = 236
    case evstwhe = 237
    case evstwhex = 238
    case evstwho = 239
    case evstwhox = 240
    case evstwwe = 241
    case evstwwex = 242
    case evstwwo = 243
    case evstwwox = 244
    case evsubfsmiaaw = 245
    case evsubfssiaaw = 246
    case evsubfumiaaw = 247
    case evsubfusiaaw = 248
    case evsubfw = 249
    case evsubifw = 250
    case evxor = 251
    case extsb = 252
    case extsh = 253
    case extsw = 254
    case eieio = 255
    case fabs = 256
    case fadd = 257
    case fadds = 258
    case fcfid = 259
    case fcfids = 260
    case fcfidu = 261
    case fcfidus = 262
    case fcmpu = 263
    case fcpsgn = 264
    case fctid = 265
    case fctiduz = 266
    case fctidz = 267
    case fctiw = 268
    case fctiwuz = 269
    case fctiwz = 270
    case fdiv = 271
    case fdivs = 272
    case fmadd = 273
    case fmadds = 274
    case fmr = 275
    case fmsub = 276
    case fmsubs = 277
    case fmul = 278
    case fmuls = 279
    case fnabs = 280
    case fneg = 281
    case fnmadd = 282
    case fnmadds = 283
    case fnmsub = 284
    case fnmsubs = 285
    case fre = 286
    case fres = 287
    case frim = 288
    case frin = 289
    case frip = 290
    case friz = 291
    case frsp = 292
    case frsqrte = 293
    case frsqrtes = 294
    case fsel = 295
    case fsqrt = 296
    case fsqrts = 297
    case fsub = 298
    case fsubs = 299
    case icbi = 300
    case icbt = 301
    case iccci = 302
    case isel = 303
    case isync = 304
    case la = 305
    case lbz = 306
    case lbzcix = 307
    case lbzu = 308
    case lbzux = 309
    case lbzx = 310
    case ld = 311
    case ldarx = 312
    case ldbrx = 313
    case ldcix = 314
    case ldu = 315
    case ldux = 316
    case ldx = 317
    case lfd = 318
    case lfdu = 319
    case lfdux = 320
    case lfdx = 321
    case lfiwax = 322
    case lfiwzx = 323
    case lfs = 324
    case lfsu = 325
    case lfsux = 326
    case lfsx = 327
    case lha = 328
    case lhau = 329
    case lhaux = 330
    case lhax = 331
    case lhbrx = 332
    case lhz = 333
    case lhzcix = 334
    case lhzu = 335
    case lhzux = 336
    case lhzx = 337
    case li = 338
    case lis = 339
    case lmw = 340
    case lswi = 341
    case lvebx = 342
    case lvehx = 343
    case lvewx = 344
    case lvsl = 345
    case lvsr = 346
    case lvx = 347
    case lvxl = 348
    case lwa = 349
    case lwarx = 350
    case lwaux = 351
    case lwax = 352
    case lwbrx = 353
    case lwz = 354
    case lwzcix = 355
    case lwzu = 356
    case lwzux = 357
    case lwzx = 358
    case lxsdx = 359
    case lxvd2x = 360
    case lxvdsx = 361
    case lxvw4x = 362
    case mbar = 363
    case mcrf = 364
    case mcrfs = 365
    case mfcr = 366
    case mfctr = 367
    case mfdcr = 368
    case mffs = 369
    case mflr = 370
    case mfmsr = 371
    case mfocrf = 372
    case mfspr = 373
    case mfsr = 374
    case mfsrin = 375
    case mftb = 376
    case mfvscr = 377
    case msync = 378
    case mtcrf = 379
    case mtctr = 380
    case mtdcr = 381
    case mtfsb0 = 382
    case mtfsb1 = 383
    case mtfsf = 384
    case mtfsfi = 385
    case mtlr = 386
    case mtmsr = 387
    case mtmsrd = 388
    case mtocrf = 389
    case mtspr = 390
    case mtsr = 391
    case mtsrin = 392
    case mtvscr = 393
    case mulhd = 394
    case mulhdu = 395
    case mulhw = 396
    case mulhwu = 397
    case mulld = 398
    case mulli = 399
    case mullw = 400
    case nand = 401
    case neg = 402
    case nop = 403
    case ori = 404
    case nor = 405
    case or = 406
    case orc = 407
    case oris = 408
    case popcntd = 409
    case popcntw = 410
    case qvaligni = 411
    case qvesplati = 412
    case qvfabs = 413
    case qvfadd = 414
    case qvfadds = 415
    case qvfcfid = 416
    case qvfcfids = 417
    case qvfcfidu = 418
    case qvfcfidus = 419
    case qvfcmpeq = 420
    case qvfcmpgt = 421
    case qvfcmplt = 422
    case qvfcpsgn = 423
    case qvfctid = 424
    case qvfctidu = 425
    case qvfctiduz = 426
    case qvfctidz = 427
    case qvfctiw = 428
    case qvfctiwu = 429
    case qvfctiwuz = 430
    case qvfctiwz = 431
    case qvflogical = 432
    case qvfmadd = 433
    case qvfmadds = 434
    case qvfmr = 435
    case qvfmsub = 436
    case qvfmsubs = 437
    case qvfmul = 438
    case qvfmuls = 439
    case qvfnabs = 440
    case qvfneg = 441
    case qvfnmadd = 442
    case qvfnmadds = 443
    case qvfnmsub = 444
    case qvfnmsubs = 445
    case qvfperm = 446
    case qvfre = 447
    case qvfres = 448
    case qvfrim = 449
    case qvfrin = 450
    case qvfrip = 451
    case qvfriz = 452
    case qvfrsp = 453
    case qvfrsqrte = 454
    case qvfrsqrtes = 455
    case qvfsel = 456
    case qvfsub = 457
    case qvfsubs = 458
    case qvftstnan = 459
    case qvfxmadd = 460
    case qvfxmadds = 461
    case qvfxmul = 462
    case qvfxmuls = 463
    case qvfxxcpnmadd = 464
    case qvfxxcpnmadds = 465
    case qvfxxmadd = 466
    case qvfxxmadds = 467
    case qvfxxnpmadd = 468
    case qvfxxnpmadds = 469
    case qvgpci = 470
    case qvlfcdux = 471
    case qvlfcduxa = 472
    case qvlfcdx = 473
    case qvlfcdxa = 474
    case qvlfcsux = 475
    case qvlfcsuxa = 476
    case qvlfcsx = 477
    case qvlfcsxa = 478
    case qvlfdux = 479
    case qvlfduxa = 480
    case qvlfdx = 481
    case qvlfdxa = 482
    case qvlfiwax = 483
    case qvlfiwaxa = 484
    case qvlfiwzx = 485
    case qvlfiwzxa = 486
    case qvlfsux = 487
    case qvlfsuxa = 488
    case qvlfsx = 489
    case qvlfsxa = 490
    case qvlpcldx = 491
    case qvlpclsx = 492
    case qvlpcrdx = 493
    case qvlpcrsx = 494
    case qvstfcdux = 495
    case qvstfcduxa = 496
    case qvstfcduxi = 497
    case qvstfcduxia = 498
    case qvstfcdx = 499
    case qvstfcdxa = 500
    case qvstfcdxi = 501
    case qvstfcdxia = 502
    case qvstfcsux = 503
    case qvstfcsuxa = 504
    case qvstfcsuxi = 505
    case qvstfcsuxia = 506
    case qvstfcsx = 507
    case qvstfcsxa = 508
    case qvstfcsxi = 509
    case qvstfcsxia = 510
    case qvstfdux = 511
    case qvstfduxa = 512
    case qvstfduxi = 513
    case qvstfduxia = 514
    case qvstfdx = 515
    case qvstfdxa = 516
    case qvstfdxi = 517
    case qvstfdxia = 518
    case qvstfiwx = 519
    case qvstfiwxa = 520
    case qvstfsux = 521
    case qvstfsuxa = 522
    case qvstfsuxi = 523
    case qvstfsuxia = 524
    case qvstfsx = 525
    case qvstfsxa = 526
    case qvstfsxi = 527
    case qvstfsxia = 528
    case rfci = 529
    case rfdi = 530
    case rfi = 531
    case rfid = 532
    case rfmci = 533
    case rldcl = 534
    case rldcr = 535
    case rldic = 536
    case rldicl = 537
    case rldicr = 538
    case rldimi = 539
    case rlwimi = 540
    case rlwinm = 541
    case rlwnm = 542
    case sc = 543
    case slbia = 544
    case slbie = 545
    case slbmfee = 546
    case slbmte = 547
    case sld = 548
    case slw = 549
    case srad = 550
    case sradi = 551
    case sraw = 552
    case srawi = 553
    case srd = 554
    case srw = 555
    case stb = 556
    case stbcix = 557
    case stbu = 558
    case stbux = 559
    case stbx = 560
    case std = 561
    case stdbrx = 562
    case stdcix = 563
    case stdcx = 564
    case stdu = 565
    case stdux = 566
    case stdx = 567
    case stfd = 568
    case stfdu = 569
    case stfdux = 570
    case stfdx = 571
    case stfiwx = 572
    case stfs = 573
    case stfsu = 574
    case stfsux = 575
    case stfsx = 576
    case sth = 577
    case sthbrx = 578
    case sthcix = 579
    case sthu = 580
    case sthux = 581
    case sthx = 582
    case stmw = 583
    case stswi = 584
    case stvebx = 585
    case stvehx = 586
    case stvewx = 587
    case stvx = 588
    case stvxl = 589
    case stw = 590
    case stwbrx = 591
    case stwcix = 592
    case stwcx = 593
    case stwu = 594
    case stwux = 595
    case stwx = 596
    case stxsdx = 597
    case stxvd2x = 598
    case stxvw4x = 599
    case subf = 600
    case subfc = 601
    case subfe = 602
    case subfic = 603
    case subfme = 604
    case subfze = 605
    case sync = 606
    case td = 607
    case tdi = 608
    case tlbia = 609
    case tlbie = 610
    case tlbiel = 611
    case tlbivax = 612
    case tlbld = 613
    case tlbli = 614
    case tlbre = 615
    case tlbsx = 616
    case tlbsync = 617
    case tlbwe = 618
    case trap = 619
    case tw = 620
    case twi = 621
    case vaddcuw = 622
    case vaddfp = 623
    case vaddsbs = 624
    case vaddshs = 625
    case vaddsws = 626
    case vaddubm = 627
    case vaddubs = 628
    case vaddudm = 629
    case vadduhm = 630
    case vadduhs = 631
    case vadduwm = 632
    case vadduws = 633
    case vand = 634
    case vandc = 635
    case vavgsb = 636
    case vavgsh = 637
    case vavgsw = 638
    case vavgub = 639
    case vavguh = 640
    case vavguw = 641
    case vcfsx = 642
    case vcfux = 643
    case vclzb = 644
    case vclzd = 645
    case vclzh = 646
    case vclzw = 647
    case vcmpbfp = 648
    case vcmpeqfp = 649
    case vcmpequb = 650
    case vcmpequd = 651
    case vcmpequh = 652
    case vcmpequw = 653
    case vcmpgefp = 654
    case vcmpgtfp = 655
    case vcmpgtsb = 656
    case vcmpgtsd = 657
    case vcmpgtsh = 658
    case vcmpgtsw = 659
    case vcmpgtub = 660
    case vcmpgtud = 661
    case vcmpgtuh = 662
    case vcmpgtuw = 663
    case vctsxs = 664
    case vctuxs = 665
    case veqv = 666
    case vexptefp = 667
    case vlogefp = 668
    case vmaddfp = 669
    case vmaxfp = 670
    case vmaxsb = 671
    case vmaxsd = 672
    case vmaxsh = 673
    case vmaxsw = 674
    case vmaxub = 675
    case vmaxud = 676
    case vmaxuh = 677
    case vmaxuw = 678
    case vmhaddshs = 679
    case vmhraddshs = 680
    case vminud = 681
    case vminfp = 682
    case vminsb = 683
    case vminsd = 684
    case vminsh = 685
    case vminsw = 686
    case vminub = 687
    case vminuh = 688
    case vminuw = 689
    case vmladduhm = 690
    case vmrghb = 691
    case vmrghh = 692
    case vmrghw = 693
    case vmrglb = 694
    case vmrglh = 695
    case vmrglw = 696
    case vmsummbm = 697
    case vmsumshm = 698
    case vmsumshs = 699
    case vmsumubm = 700
    case vmsumuhm = 701
    case vmsumuhs = 702
    case vmulesb = 703
    case vmulesh = 704
    case vmulesw = 705
    case vmuleub = 706
    case vmuleuh = 707
    case vmuleuw = 708
    case vmulosb = 709
    case vmulosh = 710
    case vmulosw = 711
    case vmuloub = 712
    case vmulouh = 713
    case vmulouw = 714
    case vmuluwm = 715
    case vnand = 716
    case vnmsubfp = 717
    case vnor = 718
    case vor = 719
    case vorc = 720
    case vperm = 721
    case vpkpx = 722
    case vpkshss = 723
    case vpkshus = 724
    case vpkswss = 725
    case vpkswus = 726
    case vpkuhum = 727
    case vpkuhus = 728
    case vpkuwum = 729
    case vpkuwus = 730
    case vpopcntb = 731
    case vpopcntd = 732
    case vpopcnth = 733
    case vpopcntw = 734
    case vrefp = 735
    case vrfim = 736
    case vrfin = 737
    case vrfip = 738
    case vrfiz = 739
    case vrlb = 740
    case vrld = 741
    case vrlh = 742
    case vrlw = 743
    case vrsqrtefp = 744
    case vsel = 745
    case vsl = 746
    case vslb = 747
    case vsld = 748
    case vsldoi = 749
    case vslh = 750
    case vslo = 751
    case vslw = 752
    case vspltb = 753
    case vsplth = 754
    case vspltisb = 755
    case vspltish = 756
    case vspltisw = 757
    case vspltw = 758
    case vsr = 759
    case vsrab = 760
    case vsrad = 761
    case vsrah = 762
    case vsraw = 763
    case vsrb = 764
    case vsrd = 765
    case vsrh = 766
    case vsro = 767
    case vsrw = 768
    case vsubcuw = 769
    case vsubfp = 770
    case vsubsbs = 771
    case vsubshs = 772
    case vsubsws = 773
    case vsububm = 774
    case vsububs = 775
    case vsubudm = 776
    case vsubuhm = 777
    case vsubuhs = 778
    case vsubuwm = 779
    case vsubuws = 780
    case vsum2sws = 781
    case vsum4sbs = 782
    case vsum4shs = 783
    case vsum4ubs = 784
    case vsumsws = 785
    case vupkhpx = 786
    case vupkhsb = 787
    case vupkhsh = 788
    case vupklpx = 789
    case vupklsb = 790
    case vupklsh = 791
    case vxor = 792
    case wait = 793
    case wrtee = 794
    case wrteei = 795
    case xor = 796
    case xori = 797
    case xoris = 798
    case xsabsdp = 799
    case xsadddp = 800
    case xscmpodp = 801
    case xscmpudp = 802
    case xscpsgndp = 803
    case xscvdpsp = 804
    case xscvdpsxds = 805
    case xscvdpsxws = 806
    case xscvdpuxds = 807
    case xscvdpuxws = 808
    case xscvspdp = 809
    case xscvsxddp = 810
    case xscvuxddp = 811
    case xsdivdp = 812
    case xsmaddadp = 813
    case xsmaddmdp = 814
    case xsmaxdp = 815
    case xsmindp = 816
    case xsmsubadp = 817
    case xsmsubmdp = 818
    case xsmuldp = 819
    case xsnabsdp = 820
    case xsnegdp = 821
    case xsnmaddadp = 822
    case xsnmaddmdp = 823
    case xsnmsubadp = 824
    case xsnmsubmdp = 825
    case xsrdpi = 826
    case xsrdpic = 827
    case xsrdpim = 828
    case xsrdpip = 829
    case xsrdpiz = 830
    case xsredp = 831
    case xsrsqrtedp = 832
    case xssqrtdp = 833
    case xssubdp = 834
    case xstdivdp = 835
    case xstsqrtdp = 836
    case xvabsdp = 837
    case xvabssp = 838
    case xvadddp = 839
    case xvaddsp = 840
    case xvcmpeqdp = 841
    case xvcmpeqsp = 842
    case xvcmpgedp = 843
    case xvcmpgesp = 844
    case xvcmpgtdp = 845
    case xvcmpgtsp = 846
    case xvcpsgndp = 847
    case xvcpsgnsp = 848
    case xvcvdpsp = 849
    case xvcvdpsxds = 850
    case xvcvdpsxws = 851
    case xvcvdpuxds = 852
    case xvcvdpuxws = 853
    case xvcvspdp = 854
    case xvcvspsxds = 855
    case xvcvspsxws = 856
    case xvcvspuxds = 857
    case xvcvspuxws = 858
    case xvcvsxddp = 859
    case xvcvsxdsp = 860
    case xvcvsxwdp = 861
    case xvcvsxwsp = 862
    case xvcvuxddp = 863
    case xvcvuxdsp = 864
    case xvcvuxwdp = 865
    case xvcvuxwsp = 866
    case xvdivdp = 867
    case xvdivsp = 868
    case xvmaddadp = 869
    case xvmaddasp = 870
    case xvmaddmdp = 871
    case xvmaddmsp = 872
    case xvmaxdp = 873
    case xvmaxsp = 874
    case xvmindp = 875
    case xvminsp = 876
    case xvmsubadp = 877
    case xvmsubasp = 878
    case xvmsubmdp = 879
    case xvmsubmsp = 880
    case xvmuldp = 881
    case xvmulsp = 882
    case xvnabsdp = 883
    case xvnabssp = 884
    case xvnegdp = 885
    case xvnegsp = 886
    case xvnmaddadp = 887
    case xvnmaddasp = 888
    case xvnmaddmdp = 889
    case xvnmaddmsp = 890
    case xvnmsubadp = 891
    case xvnmsubasp = 892
    case xvnmsubmdp = 893
    case xvnmsubmsp = 894
    case xvrdpi = 895
    case xvrdpic = 896
    case xvrdpim = 897
    case xvrdpip = 898
    case xvrdpiz = 899
    case xvredp = 900
    case xvresp = 901
    case xvrspi = 902
    case xvrspic = 903
    case xvrspim = 904
    case xvrspip = 905
    case xvrspiz = 906
    case xvrsqrtedp = 907
    case xvrsqrtesp = 908
    case xvsqrtdp = 909
    case xvsqrtsp = 910
    case xvsubdp = 911
    case xvsubsp = 912
    case xvtdivdp = 913
    case xvtdivsp = 914
    case xvtsqrtdp = 915
    case xvtsqrtsp = 916
    case xxland = 917
    case xxlandc = 918
    case xxleqv = 919
    case xxlnand = 920
    case xxlnor = 921
    case xxlor = 922
    case xxlorc = 923
    case xxlxor = 924
    case xxmrghw = 925
    case xxmrglw = 926
    case xxpermdi = 927
    case xxsel = 928
    case xxsldwi = 929
    case xxspltw = 930
    case bca = 931
    case bcla = 932
    case slwi = 933
    case srwi = 934
    case sldi = 935
    case bta = 936
    case crset = 937
    case crnot = 938
    case crmove = 939
    case crclr = 940
    case mfbr0 = 941
    case mfbr1 = 942
    case mfbr2 = 943
    case mfbr3 = 944
    case mfbr4 = 945
    case mfbr5 = 946
    case mfbr6 = 947
    case mfbr7 = 948
    case mfxer = 949
    case mfrtcu = 950
    case mfrtcl = 951
    case mfdscr = 952
    case mfdsisr = 953
    case mfdar = 954
    case mfsrr2 = 955
    case mfsrr3 = 956
    case mfcfar = 957
    case mfamr = 958
    case mfpid = 959
    case mftblo = 960
    case mftbhi = 961
    case mfdbatu = 962
    case mfdbatl = 963
    case mfibatu = 964
    case mfibatl = 965
    case mfdccr = 966
    case mficcr = 967
    case mfdear = 968
    case mfesr = 969
    case mfspefscr = 970
    case mftcr = 971
    case mfasr = 972
    case mfpvr = 973
    case mftbu = 974
    case mtcr = 975
    case mtbr0 = 976
    case mtbr1 = 977
    case mtbr2 = 978
    case mtbr3 = 979
    case mtbr4 = 980
    case mtbr5 = 981
    case mtbr6 = 982
    case mtbr7 = 983
    case mtxer = 984
    case mtdscr = 985
    case mtdsisr = 986
    case mtdar = 987
    case mtsrr2 = 988
    case mtsrr3 = 989
    case mtcfar = 990
    case mtamr = 991
    case mtpid = 992
    case mttbl = 993
    case mttbu = 994
    case mttblo = 995
    case mttbhi = 996
    case mtdbatu = 997
    case mtdbatl = 998
    case mtibatu = 999
    case mtibatl = 1000
    case mtdccr = 1001
    case mticcr = 1002
    case mtdear = 1003
    case mtesr = 1004
    case mtspefscr = 1005
    case mttcr = 1006
    case not = 1007
    case mr = 1008
    case rotld = 1009
    case rotldi = 1010
    case clrldi = 1011
    case rotlwi = 1012
    case clrlwi = 1013
    case rotlw = 1014
    case sub = 1015
    case subc = 1016
    case lwsync = 1017
    case ptesync = 1018
    case tdlt = 1019
    case tdeq = 1020
    case tdgt = 1021
    case tdne = 1022
    case tdllt = 1023
    case tdlgt = 1024
    case tdu = 1025
    case tdlti = 1026
    case tdeqi = 1027
    case tdgti = 1028
    case tdnei = 1029
    case tdllti = 1030
    case tdlgti = 1031
    case tdui = 1032
    case tlbrehi = 1033
    case tlbrelo = 1034
    case tlbwehi = 1035
    case tlbwelo = 1036
    case twlt = 1037
    case tweq = 1038
    case twgt = 1039
    case twne = 1040
    case twllt = 1041
    case twlgt = 1042
    case twu = 1043
    case twlti = 1044
    case tweqi = 1045
    case twgti = 1046
    case twnei = 1047
    case twllti = 1048
    case twlgti = 1049
    case twui = 1050
    case waitrsv = 1051
    case waitimpl = 1052
    case xnop = 1053
    case xvmovdp = 1054
    case xvmovsp = 1055
    case xxspltd = 1056
    case xxmrghd = 1057
    case xxmrgld = 1058
    case xxswapd = 1059
    case bt = 1060
    case bf = 1061
    case bdnzt = 1062
    case bdnzf = 1063
    case bdzf = 1064
    case bdzt = 1065
    case bfa = 1066
    case bdnzta = 1067
    case bdnzfa = 1068
    case bdzta = 1069
    case bdzfa = 1070
    case btctr = 1071
    case bfctr = 1072
    case btctrl = 1073
    case bfctrl = 1074
    case btl = 1075
    case bfl = 1076
    case bdnztl = 1077
    case bdnzfl = 1078
    case bdztl = 1079
    case bdzfl = 1080
    case btla = 1081
    case bfla = 1082
    case bdnztla = 1083
    case bdnzfla = 1084
    case bdztla = 1085
    case bdzfla = 1086
    case btlr = 1087
    case bflr = 1088
    case bdnztlr = 1089
    case bdztlr = 1090
    case bdzflr = 1091
    case btlrl = 1092
    case bflrl = 1093
    case bdnztlrl = 1094
    case bdnzflrl = 1095
    case bdztlrl = 1096
    case bdzflrl = 1097
    case qvfand = 1098
    case qvfclr = 1099
    case qvfandc = 1100
    case qvfctfb = 1101
    case qvfxor = 1102
    case qvfor = 1103
    case qvfnor = 1104
    case qvfequ = 1105
    case qvfnot = 1106
    case qvforc = 1107
    case qvfnand = 1108
    case qvfset = 1109
    case ending = 1110

}

/// Group of PPC instructions
public enum PpcGrp: UInt8 {
    /// = CS_GRP_INVALID
    case invalid = 0
    /// = CS_GRP_JUMP
    case jump = 1
    case altivec = 128
    case mode32 = 129
    case mode64 = 130
    case booke = 131
    case notbooke = 132
    case spe = 133
    case vsx = 134
    case e500 = 135
    case ppc4xx = 136
    case ppc6xx = 137
    case icbt = 138
    case p8altivec = 139
    case p8vector = 140
    case qpx = 141
    case ending = 142
}

