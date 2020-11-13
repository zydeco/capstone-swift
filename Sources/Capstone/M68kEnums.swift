// For Capstone Engine. AUTO-GENERATED FILE, DO NOT EDIT (M68k)

public enum M68kOperand: UInt32 {
    case count = 4

}

/// M68K registers and special registers
public enum M68kReg: UInt16 {
    case invalid = 0
    case d0 = 1
    case d1 = 2
    case d2 = 3
    case d3 = 4
    case d4 = 5
    case d5 = 6
    case d6 = 7
    case d7 = 8
    case a0 = 9
    case a1 = 10
    case a2 = 11
    case a3 = 12
    case a4 = 13
    case a5 = 14
    case a6 = 15
    case a7 = 16
    case fp0 = 17
    case fp1 = 18
    case fp2 = 19
    case fp3 = 20
    case fp4 = 21
    case fp5 = 22
    case fp6 = 23
    case fp7 = 24
    case pc = 25
    case sr = 26
    case ccr = 27
    case sfc = 28
    case dfc = 29
    case usp = 30
    case vbr = 31
    case cacr = 32
    case caar = 33
    case msp = 34
    case isp = 35
    case tc = 36
    case itt0 = 37
    case itt1 = 38
    case dtt0 = 39
    case dtt1 = 40
    case mmusr = 41
    case urp = 42
    case srp = 43
    case fpcr = 44
    case fpsr = 45
    case fpiar = 46
    case ending = 47

}

/// M68K Addressing Modes
public enum M68kAm: UInt32 {
    /// No address mode.
    case none = 0
    /// Register Direct - Data
    case regDirectData = 1
    /// Register Direct - Address
    case regDirectAddr = 2
    /// Register Indirect - Address
    case regiAddr = 3
    /// Register Indirect - Address with Postincrement
    case regiAddrPostInc = 4
    /// Register Indirect - Address with Predecrement
    case regiAddrPreDec = 5
    /// Register Indirect - Address with Displacement
    case regiAddrDisp = 6
    /// Address Register Indirect With Index- 8-bit displacement
    case aregiIndex8BitDisp = 7
    /// Address Register Indirect With Index- Base displacement
    case aregiIndexBaseDisp = 8
    /// Memory indirect - Postindex
    case memiPostIndex = 9
    /// Memory indirect - Preindex
    case memiPreIndex = 10
    /// Program Counter Indirect - with Displacement
    case pciDisp = 11
    /// Program Counter Indirect with Index - with 8-Bit Displacement
    case pciIndex8BitDisp = 12
    /// Program Counter Indirect with Index - with Base Displacement
    case pciIndexBaseDisp = 13
    /// Program Counter Memory Indirect - Postindexed
    case pcMemiPostIndex = 14
    /// Program Counter Memory Indirect - Preindexed
    case pcMemiPreIndex = 15
    /// Absolute Data Addressing  - Short
    case absoluteDataShort = 16
    /// Absolute Data Addressing  - Long
    case absoluteDataLong = 17
    /// Immediate value
    case immediate = 18
    /// Address as displacement from (PC+2) used by branches
    case branchDisplacement = 19

}

/// Operand type for instruction's operands
public enum M68kOp: UInt32 {
    /// = CS_OP_INVALID (Uninitialized).
    case invalid = 0
    /// = CS_OP_REG (Register operand).
    case reg = 1
    /// = CS_OP_IMM (Immediate operand).
    case imm = 2
    /// = CS_OP_MEM (Memory operand).
    case mem = 3
    /// single precision Floating-Point operand
    case fpSingle = 4
    /// double precision Floating-Point operand
    case fpDouble = 5
    /// Register bits move
    case regBits = 6
    /// Register pair in the same op (upper 4 bits for first reg, lower for second)
    case regPair = 7
    /// Branch displacement
    case brDisp = 8

    /// = CS_OP_INVALID (Uninitialized).
    public static let brDispSizeInvalid = 0
    /// signed 8-bit displacement
    public static let brDispSizeByte = 1
    /// signed 16-bit displacement
    public static let brDispSizeWord = 2
    /// signed 32-bit displacement
    public static let brDispSizeLong = 4

}

/// Operation size of the CPU instructions
public enum M68kCpu: UInt32 {
    /// unsized or unspecified
    case sizeNone = 0
    /// 1 byte in size
    case sizeByte = 1
    /// 2 bytes in size
    case sizeWord = 2
    /// 4 bytes in size
    case sizeLong = 4

}

/// Operation size of the FPU instructions (Notice that FPU instruction can also use CPU sizes if needed)
public enum M68kFpu: UInt32 {
    /// unsized like fsave/frestore
    case sizeNone = 0
    /// 4 byte in size (single float)
    case sizeSingle = 4
    /// 8 byte in size (double)
    case sizeDouble = 8
    /// 12 byte in size (extended real format)
    case sizeExtended = 12

}

/// Type of size that is being used for the current instruction
public enum M68kSize: UInt32 {
    case typeInvalid = 0
    case typeCpu = 1
    case typeFpu = 2

}

/// M68K instruction
public enum M68kIns: UInt32 {
    case invalid = 0
    case abcd = 1
    case add = 2
    case adda = 3
    case addi = 4
    case addq = 5
    case addx = 6
    case and = 7
    case andi = 8
    case asl = 9
    case asr = 10
    case bhs = 11
    case blo = 12
    case bhi = 13
    case bls = 14
    case bcc = 15
    case bcs = 16
    case bne = 17
    case beq = 18
    case bvc = 19
    case bvs = 20
    case bpl = 21
    case bmi = 22
    case bge = 23
    case blt = 24
    case bgt = 25
    case ble = 26
    case bra = 27
    case bsr = 28
    case bchg = 29
    case bclr = 30
    case bset = 31
    case btst = 32
    case bfchg = 33
    case bfclr = 34
    case bfexts = 35
    case bfextu = 36
    case bfffo = 37
    case bfins = 38
    case bfset = 39
    case bftst = 40
    case bkpt = 41
    case callm = 42
    case cas = 43
    case cas2 = 44
    case chk = 45
    case chk2 = 46
    case clr = 47
    case cmp = 48
    case cmpa = 49
    case cmpi = 50
    case cmpm = 51
    case cmp2 = 52
    case cinvl = 53
    case cinvp = 54
    case cinva = 55
    case cpushl = 56
    case cpushp = 57
    case cpusha = 58
    case dbt = 59
    case dbf = 60
    case dbhi = 61
    case dbls = 62
    case dbcc = 63
    case dbcs = 64
    case dbne = 65
    case dbeq = 66
    case dbvc = 67
    case dbvs = 68
    case dbpl = 69
    case dbmi = 70
    case dbge = 71
    case dblt = 72
    case dbgt = 73
    case dble = 74
    case dbra = 75
    case divs = 76
    case divsl = 77
    case divu = 78
    case divul = 79
    case eor = 80
    case eori = 81
    case exg = 82
    case ext = 83
    case extb = 84
    case fabs = 85
    case fsabs = 86
    case fdabs = 87
    case facos = 88
    case fadd = 89
    case fsadd = 90
    case fdadd = 91
    case fasin = 92
    case fatan = 93
    case fatanh = 94
    case fbf = 95
    case fbeq = 96
    case fbogt = 97
    case fboge = 98
    case fbolt = 99
    case fbole = 100
    case fbogl = 101
    case fbor = 102
    case fbun = 103
    case fbueq = 104
    case fbugt = 105
    case fbuge = 106
    case fbult = 107
    case fbule = 108
    case fbne = 109
    case fbt = 110
    case fbsf = 111
    case fbseq = 112
    case fbgt = 113
    case fbge = 114
    case fblt = 115
    case fble = 116
    case fbgl = 117
    case fbgle = 118
    case fbngle = 119
    case fbngl = 120
    case fbnle = 121
    case fbnlt = 122
    case fbnge = 123
    case fbngt = 124
    case fbsne = 125
    case fbst = 126
    case fcmp = 127
    case fcos = 128
    case fcosh = 129
    case fdbf = 130
    case fdbeq = 131
    case fdbogt = 132
    case fdboge = 133
    case fdbolt = 134
    case fdbole = 135
    case fdbogl = 136
    case fdbor = 137
    case fdbun = 138
    case fdbueq = 139
    case fdbugt = 140
    case fdbuge = 141
    case fdbult = 142
    case fdbule = 143
    case fdbne = 144
    case fdbt = 145
    case fdbsf = 146
    case fdbseq = 147
    case fdbgt = 148
    case fdbge = 149
    case fdblt = 150
    case fdble = 151
    case fdbgl = 152
    case fdbgle = 153
    case fdbngle = 154
    case fdbngl = 155
    case fdbnle = 156
    case fdbnlt = 157
    case fdbnge = 158
    case fdbngt = 159
    case fdbsne = 160
    case fdbst = 161
    case fdiv = 162
    case fsdiv = 163
    case fddiv = 164
    case fetox = 165
    case fetoxm1 = 166
    case fgetexp = 167
    case fgetman = 168
    case fint = 169
    case fintrz = 170
    case flog10 = 171
    case flog2 = 172
    case flogn = 173
    case flognp1 = 174
    case fmod = 175
    case fmove = 176
    case fsmove = 177
    case fdmove = 178
    case fmovecr = 179
    case fmovem = 180
    case fmul = 181
    case fsmul = 182
    case fdmul = 183
    case fneg = 184
    case fsneg = 185
    case fdneg = 186
    case fnop = 187
    case frem = 188
    case frestore = 189
    case fsave = 190
    case fscale = 191
    case fsgldiv = 192
    case fsglmul = 193
    case fsin = 194
    case fsincos = 195
    case fsinh = 196
    case fsqrt = 197
    case fssqrt = 198
    case fdsqrt = 199
    case fsf = 200
    case fsbeq = 201
    case fsogt = 202
    case fsoge = 203
    case fsolt = 204
    case fsole = 205
    case fsogl = 206
    case fsor = 207
    case fsun = 208
    case fsueq = 209
    case fsugt = 210
    case fsuge = 211
    case fsult = 212
    case fsule = 213
    case fsne = 214
    case fst = 215
    case fssf = 216
    case fsseq = 217
    case fsgt = 218
    case fsge = 219
    case fslt = 220
    case fsle = 221
    case fsgl = 222
    case fsgle = 223
    case fsngle = 224
    case fsngl = 225
    case fsnle = 226
    case fsnlt = 227
    case fsnge = 228
    case fsngt = 229
    case fssne = 230
    case fsst = 231
    case fsub = 232
    case fssub = 233
    case fdsub = 234
    case ftan = 235
    case ftanh = 236
    case ftentox = 237
    case ftrapf = 238
    case ftrapeq = 239
    case ftrapogt = 240
    case ftrapoge = 241
    case ftrapolt = 242
    case ftrapole = 243
    case ftrapogl = 244
    case ftrapor = 245
    case ftrapun = 246
    case ftrapueq = 247
    case ftrapugt = 248
    case ftrapuge = 249
    case ftrapult = 250
    case ftrapule = 251
    case ftrapne = 252
    case ftrapt = 253
    case ftrapsf = 254
    case ftrapseq = 255
    case ftrapgt = 256
    case ftrapge = 257
    case ftraplt = 258
    case ftraple = 259
    case ftrapgl = 260
    case ftrapgle = 261
    case ftrapngle = 262
    case ftrapngl = 263
    case ftrapnle = 264
    case ftrapnlt = 265
    case ftrapnge = 266
    case ftrapngt = 267
    case ftrapsne = 268
    case ftrapst = 269
    case ftst = 270
    case ftwotox = 271
    case halt = 272
    case illegal = 273
    case jmp = 274
    case jsr = 275
    case lea = 276
    case link = 277
    case lpstop = 278
    case lsl = 279
    case lsr = 280
    case move = 281
    case movea = 282
    case movec = 283
    case movem = 284
    case movep = 285
    case moveq = 286
    case moves = 287
    case move16 = 288
    case muls = 289
    case mulu = 290
    case nbcd = 291
    case neg = 292
    case negx = 293
    case nop = 294
    case not = 295
    case or = 296
    case ori = 297
    case pack = 298
    case pea = 299
    case pflush = 300
    case pflusha = 301
    case pflushan = 302
    case pflushn = 303
    case ploadr = 304
    case ploadw = 305
    case plpar = 306
    case plpaw = 307
    case pmove = 308
    case pmovefd = 309
    case ptestr = 310
    case ptestw = 311
    case pulse = 312
    case rems = 313
    case remu = 314
    case reset = 315
    case rol = 316
    case ror = 317
    case roxl = 318
    case roxr = 319
    case rtd = 320
    case rte = 321
    case rtm = 322
    case rtr = 323
    case rts = 324
    case sbcd = 325
    case st = 326
    case sf = 327
    case shi = 328
    case sls = 329
    case scc = 330
    case shs = 331
    case scs = 332
    case slo = 333
    case sne = 334
    case seq = 335
    case svc = 336
    case svs = 337
    case spl = 338
    case smi = 339
    case sge = 340
    case slt = 341
    case sgt = 342
    case sle = 343
    case stop = 344
    case sub = 345
    case suba = 346
    case subi = 347
    case subq = 348
    case subx = 349
    case swap = 350
    case tas = 351
    case trap = 352
    case trapv = 353
    case trapt = 354
    case trapf = 355
    case traphi = 356
    case trapls = 357
    case trapcc = 358
    case traphs = 359
    case trapcs = 360
    case traplo = 361
    case trapne = 362
    case trapeq = 363
    case trapvc = 364
    case trapvs = 365
    case trappl = 366
    case trapmi = 367
    case trapge = 368
    case traplt = 369
    case trapgt = 370
    case traple = 371
    case tst = 372
    case unlk = 373
    case unpk = 374
    case ending = 375

}

/// Group of M68K instructions
public enum M68kGrp: UInt8 {
    /// CS_GRUP_INVALID
    case invalid = 0
    /// = CS_GRP_JUMP
    case jump = 1
    /// = CS_GRP_RET
    case ret = 3
    /// = CS_GRP_IRET
    case iret = 5
    /// = CS_GRP_BRANCH_RELATIVE
    case branchRelative = 7
    case ending = 8
}

