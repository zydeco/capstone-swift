// For Capstone Engine. AUTO-GENERATED FILE, DO NOT EDIT (M680x)

public enum m680xOperand: UInt32 {
    case count = 9

}

/// M680X registers and special registers
public enum m680xReg: UInt16 {
    case invalid = 0
    /// M6800/1/2/3/9, HD6301/9
    case a = 1
    /// M6800/1/2/3/9, HD6301/9
    case b = 2
    /// HD6309
    case e = 3
    /// HD6309
    case f = 4
    /// HD6309
    case reg0 = 5
    /// M6801/3/9, HD6301/9
    case d = 6
    /// HD6309
    case w = 7
    /// M6800/1/2/3/9, M6301/9
    case cc = 8
    /// M6809/M6309
    case dp = 9
    /// M6309
    case md = 10
    /// M6808
    case hx = 11
    /// M6808
    case h = 12
    /// M6800/1/2/3/9, M6301/9
    case x = 13
    /// M6809/M6309
    case y = 14
    /// M6809/M6309
    case s = 15
    /// M6809/M6309
    case u = 16
    /// M6309
    case v = 17
    /// M6309
    case q = 18
    /// M6800/1/2/3/9, M6301/9
    case pc = 19
    /// CPU12
    case tmp2 = 20
    /// CPU12
    case tmp3 = 21
    /// <-- mark the end of the list of registers
    case ending = 22

}

/// Operand type for instruction's operands
public enum m680xOp: UInt32 {
    /// = CS_OP_INVALID (Uninitialized).
    case invalid = 0
    /// = Register operand.
    case register = 1
    /// = Immediate operand.
    case immediate = 2
    /// = Indexed addressing operand.
    case indexed = 3
    /// = Extended addressing operand.
    case extended = 4
    /// = Direct addressing operand.
    case direct = 5
    /// = Relative addressing operand.
    case relative = 6
    /// = constant operand (Displayed as number only).
    case constant = 7

}

public enum m680xOffset: UInt32 {
    case none = 0
    case bits5 = 5
    case bits8 = 8
    case bits9 = 9
    case bits16 = 16
}

public enum m680xIdx: UInt32 {
    case indirect = 1
    case noComma = 2
    case postIncDec = 4

}

/// Group of M680X instructions
public enum m680xGrp: UInt8 {
    case invalid = 0
    /// = CS_GRP_JUMP
    case jump = 1
    /// = CS_GRP_CALL
    case call = 2
    /// = CS_GRP_RET
    case ret = 3
    /// = CS_GRP_INT
    case int = 4
    /// = CS_GRP_IRET
    case iret = 5
    /// = CS_GRP_PRIVILEDGE; not used
    case priv = 6
    /// = CS_GRP_BRANCH_RELATIVE
    case brarel = 7
    case ending = 8
}

/// The first (register) operand is part of the
/// instruction mnemonic
public enum m680xFirst: UInt32 {
    case opInMnem = 1
}

/// The second (register) operand is part of the
/// instruction mnemonic
public enum m680xSecond: UInt32 {
    case opInMnem = 2

}

/// M680X instruction IDs
public enum m680xIns: UInt32 {
    case invld = 0
    /// M6800/1/2/3
    case aba = 1
    case abx = 2
    case aby = 3
    case adc = 4
    case adca = 5
    case adcb = 6
    case adcd = 7
    case adcr = 8
    case add = 9
    case adda = 10
    case addb = 11
    case addd = 12
    case adde = 13
    case addf = 14
    case addr = 15
    case addw = 16
    case aim = 17
    case ais = 18
    case aix = 19
    case and = 20
    case anda = 21
    case andb = 22
    case andcc = 23
    case andd = 24
    case andr = 25
    case asl = 26
    case asla = 27
    case aslb = 28
    /// or LSLD
    case asld = 29
    case asr = 30
    case asra = 31
    case asrb = 32
    case asrd = 33
    case asrx = 34
    case band = 35
    /// or BHS
    case bcc = 36
    case bclr = 37
    /// or BLO
    case bcs = 38
    case beor = 39
    case beq = 40
    case bge = 41
    case bgnd = 42
    case bgt = 43
    case bhcc = 44
    case bhcs = 45
    case bhi = 46
    case biand = 47
    case bieor = 48
    case bih = 49
    case bil = 50
    case bior = 51
    case bit = 52
    case bita = 53
    case bitb = 54
    case bitd = 55
    case bitmd = 56
    case ble = 57
    case bls = 58
    case blt = 59
    case bmc = 60
    case bmi = 61
    case bms = 62
    case bne = 63
    case bor = 64
    case bpl = 65
    case brclr = 66
    case brset = 67
    case bra = 68
    case brn = 69
    case bset = 70
    case bsr = 71
    case bvc = 72
    case bvs = 73
    case call = 74
    /// M6800/1/2/3
    case cba = 75
    case cbeq = 76
    case cbeqa = 77
    case cbeqx = 78
    /// M6800/1/2/3
    case clc = 79
    /// M6800/1/2/3
    case cli = 80
    case clr = 81
    case clra = 82
    case clrb = 83
    case clrd = 84
    case clre = 85
    case clrf = 86
    case clrh = 87
    case clrw = 88
    case clrx = 89
    /// M6800/1/2/3
    case clv = 90
    case cmp = 91
    case cmpa = 92
    case cmpb = 93
    case cmpd = 94
    case cmpe = 95
    case cmpf = 96
    case cmpr = 97
    case cmps = 98
    case cmpu = 99
    case cmpw = 100
    case cmpx = 101
    case cmpy = 102
    case com = 103
    case coma = 104
    case comb = 105
    case comd = 106
    case come = 107
    case comf = 108
    case comw = 109
    case comx = 110
    case cpd = 111
    case cphx = 112
    case cps = 113
    /// M6800/1/2/3
    case cpx = 114
    case cpy = 115
    case cwai = 116
    case daa = 117
    case dbeq = 118
    case dbne = 119
    case dbnz = 120
    case dbnza = 121
    case dbnzx = 122
    case dec = 123
    case deca = 124
    case decb = 125
    case decd = 126
    case dece = 127
    case decf = 128
    case decw = 129
    case decx = 130
    /// M6800/1/2/3
    case des = 131
    /// M6800/1/2/3
    case dex = 132
    case dey = 133
    case div = 134
    case divd = 135
    case divq = 136
    case ediv = 137
    case edivs = 138
    case eim = 139
    case emacs = 140
    case emaxd = 141
    case emaxm = 142
    case emind = 143
    case eminm = 144
    case emul = 145
    case emuls = 146
    case eor = 147
    case eora = 148
    case eorb = 149
    case eord = 150
    case eorr = 151
    case etbl = 152
    case exg = 153
    case fdiv = 154
    case ibeq = 155
    case ibne = 156
    case idiv = 157
    case idivs = 158
    case illgl = 159
    case inc = 160
    case inca = 161
    case incb = 162
    case incd = 163
    case ince = 164
    case incf = 165
    case incw = 166
    case incx = 167
    /// M6800/1/2/3
    case ins = 168
    /// M6800/1/2/3
    case inx = 169
    case iny = 170
    case jmp = 171
    case jsr = 172
    /// or LBHS
    case lbcc = 173
    /// or LBLO
    case lbcs = 174
    case lbeq = 175
    case lbge = 176
    case lbgt = 177
    case lbhi = 178
    case lble = 179
    case lbls = 180
    case lblt = 181
    case lbmi = 182
    case lbne = 183
    case lbpl = 184
    case lbra = 185
    case lbrn = 186
    case lbsr = 187
    case lbvc = 188
    case lbvs = 189
    case lda = 190
    /// M6800/1/2/3
    case ldaa = 191
    /// M6800/1/2/3
    case ldab = 192
    case ldb = 193
    case ldbt = 194
    case ldd = 195
    case lde = 196
    case ldf = 197
    case ldhx = 198
    case ldmd = 199
    case ldq = 200
    case lds = 201
    case ldu = 202
    case ldw = 203
    case ldx = 204
    case ldy = 205
    case leas = 206
    case leau = 207
    case leax = 208
    case leay = 209
    case lsl = 210
    case lsla = 211
    case lslb = 212
    case lsld = 213
    case lslx = 214
    case lsr = 215
    case lsra = 216
    case lsrb = 217
    /// or ASRD
    case lsrd = 218
    case lsrw = 219
    case lsrx = 220
    case maxa = 221
    case maxm = 222
    case mem = 223
    case mina = 224
    case minm = 225
    case mov = 226
    case movb = 227
    case movw = 228
    case mul = 229
    case muld = 230
    case neg = 231
    case nega = 232
    case negb = 233
    case negd = 234
    case negx = 235
    case nop = 236
    case nsa = 237
    case oim = 238
    case ora = 239
    /// M6800/1/2/3
    case oraa = 240
    /// M6800/1/2/3
    case orab = 241
    case orb = 242
    case orcc = 243
    case ord = 244
    case orr = 245
    /// M6800/1/2/3
    case psha = 246
    /// M6800/1/2/3
    case pshb = 247
    case pshc = 248
    case pshd = 249
    case pshh = 250
    case pshs = 251
    case pshsw = 252
    case pshu = 253
    case pshuw = 254
    /// M6800/1/2/3
    case pshx = 255
    case pshy = 256
    /// M6800/1/2/3
    case pula = 257
    /// M6800/1/2/3
    case pulb = 258
    case pulc = 259
    case puld = 260
    case pulh = 261
    case puls = 262
    case pulsw = 263
    case pulu = 264
    case puluw = 265
    /// M6800/1/2/3
    case pulx = 266
    case puly = 267
    case rev = 268
    case revw = 269
    case rol = 270
    case rola = 271
    case rolb = 272
    case rold = 273
    case rolw = 274
    case rolx = 275
    case ror = 276
    case rora = 277
    case rorb = 278
    case rord = 279
    case rorw = 280
    case rorx = 281
    case rsp = 282
    case rtc = 283
    case rti = 284
    case rts = 285
    /// M6800/1/2/3
    case sba = 286
    case sbc = 287
    case sbca = 288
    case sbcb = 289
    case sbcd = 290
    case sbcr = 291
    case sec = 292
    case sei = 293
    case sev = 294
    case sex = 295
    case sexw = 296
    case slp = 297
    case sta = 298
    /// M6800/1/2/3
    case staa = 299
    /// M6800/1/2/3
    case stab = 300
    case stb = 301
    case stbt = 302
    case std = 303
    case ste = 304
    case stf = 305
    case stop = 306
    case sthx = 307
    case stq = 308
    case sts = 309
    case stu = 310
    case stw = 311
    case stx = 312
    case sty = 313
    case sub = 314
    case suba = 315
    case subb = 316
    case subd = 317
    case sube = 318
    case subf = 319
    case subr = 320
    case subw = 321
    case swi = 322
    case swi2 = 323
    case swi3 = 324
    case sync = 325
    /// M6800/1/2/3
    case tab = 326
    /// M6800/1/2/3
    case tap = 327
    case tax = 328
    /// M6800/1/2/3
    case tba = 329
    case tbeq = 330
    case tbl = 331
    case tbne = 332
    case test = 333
    case tfm = 334
    case tfr = 335
    case tim = 336
    /// M6800/1/2/3
    case tpa = 337
    case tst = 338
    case tsta = 339
    case tstb = 340
    case tstd = 341
    case tste = 342
    case tstf = 343
    case tstw = 344
    case tstx = 345
    /// M6800/1/2/3
    case tsx = 346
    case tsy = 347
    case txa = 348
    /// M6800/1/2/3
    case txs = 349
    case tys = 350
    /// M6800/1/2/3
    case wai = 351
    case wait = 352
    case wav = 353
    case wavr = 354
    /// HD6301
    case xgdx = 355
    case xgdy = 356
    case ending = 357
}

