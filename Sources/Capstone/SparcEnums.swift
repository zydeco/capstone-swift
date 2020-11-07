// For Capstone Engine. AUTO-GENERATED FILE, DO NOT EDIT (Sparc)


/// Enums corresponding to Sparc condition codes, both icc's and fcc's.
public enum sparcCc: UInt32 {
    /// invalid CC (default)
    case invalid = 0
    /// Always
    case iccA = 264
    /// Never
    case iccN = 256
    /// Not Equal
    case iccNe = 265
    /// Equal
    case iccE = 257
    /// Greater
    case iccG = 266
    /// Less or Equal
    case iccLe = 258
    /// Greater or Equal
    case iccGe = 267
    /// Less
    case iccL = 259
    /// Greater Unsigned
    case iccGu = 268
    /// Less or Equal Unsigned
    case iccLeu = 260
    /// Carry Clear/Great or Equal Unsigned
    case iccCc = 269
    /// Carry Set/Less Unsigned
    case iccCs = 261
    /// Positive
    case iccPos = 270
    /// Negative
    case iccNeg = 262
    /// Overflow Clear
    case iccVc = 271
    /// Overflow Set
    case iccVs = 263
    /// Always
    case fccA = 280
    /// Never
    case fccN = 272
    /// Unordered
    case fccU = 279
    /// Greater
    case fccG = 278
    /// Unordered or Greater
    case fccUg = 277
    /// Less
    case fccL = 276
    /// Unordered or Less
    case fccUl = 275
    /// Less or Greater
    case fccLg = 274
    /// Not Equal
    case fccNe = 273
    /// Equal
    case fccE = 281
    /// Unordered or Equal
    case fccUe = 282
    /// Greater or Equal
    case fccGe = 283
    /// Unordered or Greater or Equal
    case fccUge = 284
    /// Less or Equal
    case fccLe = 285
    /// Unordered or Less or Equal
    case fccUle = 286
    /// Ordered
    case fccO = 287

}

/// Branch hint
public enum sparcHint: UInt32 {
    /// no hint
    case invalid = 0
    /// annul delay slot instruction
    case a = 1
    /// branch taken
    case pt = 2
    /// branch NOT taken
    case pn = 4

}

/// Operand type for instruction's operands
public enum sparcOp: UInt32 {
    /// = CS_OP_INVALID (Uninitialized).
    case invalid = 0
    /// = CS_OP_REG (Register operand).
    case reg = 1
    /// = CS_OP_IMM (Immediate operand).
    case imm = 2
    /// = CS_OP_MEM (Memory operand).
    case mem = 3

}

/// SPARC registers
public enum sparcReg: UInt16 {
    case invalid = 0
    case f0 = 1
    case f1 = 2
    case f2 = 3
    case f3 = 4
    case f4 = 5
    case f5 = 6
    case f6 = 7
    case f7 = 8
    case f8 = 9
    case f9 = 10
    case f10 = 11
    case f11 = 12
    case f12 = 13
    case f13 = 14
    case f14 = 15
    case f15 = 16
    case f16 = 17
    case f17 = 18
    case f18 = 19
    case f19 = 20
    case f20 = 21
    case f21 = 22
    case f22 = 23
    case f23 = 24
    case f24 = 25
    case f25 = 26
    case f26 = 27
    case f27 = 28
    case f28 = 29
    case f29 = 30
    case f30 = 31
    case f31 = 32
    case f32 = 33
    case f34 = 34
    case f36 = 35
    case f38 = 36
    case f40 = 37
    case f42 = 38
    case f44 = 39
    case f46 = 40
    case f48 = 41
    case f50 = 42
    case f52 = 43
    case f54 = 44
    case f56 = 45
    case f58 = 46
    case f60 = 47
    case f62 = 48
    case fcc0 = 49
    case fcc1 = 50
    case fcc2 = 51
    case fcc3 = 52
    case fp = 53
    case g0 = 54
    case g1 = 55
    case g2 = 56
    case g3 = 57
    case g4 = 58
    case g5 = 59
    case g6 = 60
    case g7 = 61
    case i0 = 62
    case i1 = 63
    case i2 = 64
    case i3 = 65
    case i4 = 66
    case i5 = 67
    case i7 = 68
    case icc = 69
    case l0 = 70
    case l1 = 71
    case l2 = 72
    case l3 = 73
    case l4 = 74
    case l5 = 75
    case l6 = 76
    case l7 = 77
    case o0 = 78
    case o1 = 79
    case o2 = 80
    case o3 = 81
    case o4 = 82
    case o5 = 83
    case o7 = 84
    case sp = 85
    case y = 86
    case xcc = 87
    case ending = 88
    static let o6 = 85
    static let i6 = 53

}

/// SPARC instruction
public enum sparcIns: UInt32 {
    case invalid = 0
    case addcc = 1
    case addx = 2
    case addxcc = 3
    case addxc = 4
    case addxccc = 5
    case add = 6
    case alignaddr = 7
    case alignaddrl = 8
    case andcc = 9
    case andncc = 10
    case andn = 11
    case and = 12
    case array16 = 13
    case array32 = 14
    case array8 = 15
    case b = 16
    case jmp = 17
    case bmask = 18
    case fb = 19
    case brgez = 20
    case brgz = 21
    case brlez = 22
    case brlz = 23
    case brnz = 24
    case brz = 25
    case bshuffle = 26
    case call = 27
    case casx = 28
    case cas = 29
    case cmask16 = 30
    case cmask32 = 31
    case cmask8 = 32
    case cmp = 33
    case edge16 = 34
    case edge16l = 35
    case edge16ln = 36
    case edge16n = 37
    case edge32 = 38
    case edge32l = 39
    case edge32ln = 40
    case edge32n = 41
    case edge8 = 42
    case edge8l = 43
    case edge8ln = 44
    case edge8n = 45
    case fabsd = 46
    case fabsq = 47
    case fabss = 48
    case faddd = 49
    case faddq = 50
    case fadds = 51
    case faligndata = 52
    case fand = 53
    case fandnot1 = 54
    case fandnot1s = 55
    case fandnot2 = 56
    case fandnot2s = 57
    case fands = 58
    case fchksm16 = 59
    case fcmpd = 60
    case fcmpeq16 = 61
    case fcmpeq32 = 62
    case fcmpgt16 = 63
    case fcmpgt32 = 64
    case fcmple16 = 65
    case fcmple32 = 66
    case fcmpne16 = 67
    case fcmpne32 = 68
    case fcmpq = 69
    case fcmps = 70
    case fdivd = 71
    case fdivq = 72
    case fdivs = 73
    case fdmulq = 74
    case fdtoi = 75
    case fdtoq = 76
    case fdtos = 77
    case fdtox = 78
    case fexpand = 79
    case fhaddd = 80
    case fhadds = 81
    case fhsubd = 82
    case fhsubs = 83
    case fitod = 84
    case fitoq = 85
    case fitos = 86
    case flcmpd = 87
    case flcmps = 88
    case flushw = 89
    case fmean16 = 90
    case fmovd = 91
    case fmovq = 92
    case fmovrdgez = 93
    case fmovrqgez = 94
    case fmovrsgez = 95
    case fmovrdgz = 96
    case fmovrqgz = 97
    case fmovrsgz = 98
    case fmovrdlez = 99
    case fmovrqlez = 100
    case fmovrslez = 101
    case fmovrdlz = 102
    case fmovrqlz = 103
    case fmovrslz = 104
    case fmovrdnz = 105
    case fmovrqnz = 106
    case fmovrsnz = 107
    case fmovrdz = 108
    case fmovrqz = 109
    case fmovrsz = 110
    case fmovs = 111
    case fmul8sux16 = 112
    case fmul8ulx16 = 113
    case fmul8x16 = 114
    case fmul8x16al = 115
    case fmul8x16au = 116
    case fmuld = 117
    case fmuld8sux16 = 118
    case fmuld8ulx16 = 119
    case fmulq = 120
    case fmuls = 121
    case fnaddd = 122
    case fnadds = 123
    case fnand = 124
    case fnands = 125
    case fnegd = 126
    case fnegq = 127
    case fnegs = 128
    case fnhaddd = 129
    case fnhadds = 130
    case fnor = 131
    case fnors = 132
    case fnot1 = 133
    case fnot1s = 134
    case fnot2 = 135
    case fnot2s = 136
    case fone = 137
    case fones = 138
    case `for` = 139
    case fornot1 = 140
    case fornot1s = 141
    case fornot2 = 142
    case fornot2s = 143
    case fors = 144
    case fpack16 = 145
    case fpack32 = 146
    case fpackfix = 147
    case fpadd16 = 148
    case fpadd16s = 149
    case fpadd32 = 150
    case fpadd32s = 151
    case fpadd64 = 152
    case fpmerge = 153
    case fpsub16 = 154
    case fpsub16s = 155
    case fpsub32 = 156
    case fpsub32s = 157
    case fqtod = 158
    case fqtoi = 159
    case fqtos = 160
    case fqtox = 161
    case fslas16 = 162
    case fslas32 = 163
    case fsll16 = 164
    case fsll32 = 165
    case fsmuld = 166
    case fsqrtd = 167
    case fsqrtq = 168
    case fsqrts = 169
    case fsra16 = 170
    case fsra32 = 171
    case fsrc1 = 172
    case fsrc1s = 173
    case fsrc2 = 174
    case fsrc2s = 175
    case fsrl16 = 176
    case fsrl32 = 177
    case fstod = 178
    case fstoi = 179
    case fstoq = 180
    case fstox = 181
    case fsubd = 182
    case fsubq = 183
    case fsubs = 184
    case fxnor = 185
    case fxnors = 186
    case fxor = 187
    case fxors = 188
    case fxtod = 189
    case fxtoq = 190
    case fxtos = 191
    case fzero = 192
    case fzeros = 193
    case jmpl = 194
    case ldd = 195
    case ld = 196
    case ldq = 197
    case ldsb = 198
    case ldsh = 199
    case ldsw = 200
    case ldub = 201
    case lduh = 202
    case ldx = 203
    case lzcnt = 204
    case membar = 205
    case movdtox = 206
    case mov = 207
    case movrgez = 208
    case movrgz = 209
    case movrlez = 210
    case movrlz = 211
    case movrnz = 212
    case movrz = 213
    case movstosw = 214
    case movstouw = 215
    case mulx = 216
    case nop = 217
    case orcc = 218
    case orncc = 219
    case orn = 220
    case or = 221
    case pdist = 222
    case pdistn = 223
    case popc = 224
    case rd = 225
    case restore = 226
    case rett = 227
    case save = 228
    case sdivcc = 229
    case sdivx = 230
    case sdiv = 231
    case sethi = 232
    case shutdown = 233
    case siam = 234
    case sllx = 235
    case sll = 236
    case smulcc = 237
    case smul = 238
    case srax = 239
    case sra = 240
    case srlx = 241
    case srl = 242
    case stbar = 243
    case stb = 244
    case std = 245
    case st = 246
    case sth = 247
    case stq = 248
    case stx = 249
    case subcc = 250
    case subx = 251
    case subxcc = 252
    case sub = 253
    case swap = 254
    case taddcctv = 255
    case taddcc = 256
    case t = 257
    case tsubcctv = 258
    case tsubcc = 259
    case udivcc = 260
    case udivx = 261
    case udiv = 262
    case umulcc = 263
    case umulxhi = 264
    case umul = 265
    case unimp = 266
    case fcmped = 267
    case fcmpeq = 268
    case fcmpes = 269
    case wr = 270
    case xmulx = 271
    case xmulxhi = 272
    case xnorcc = 273
    case xnor = 274
    case xorcc = 275
    case xor = 276
    case ret = 277
    case retl = 278
    case ending = 279

}

/// Group of SPARC instructions
public enum sparcGrp: UInt8 {
    /// = CS_GRP_INVALID
    case invalid = 0
    /// = CS_GRP_JUMP
    case jump = 1
    case hardquad = 128
    case v9 = 129
    case vis = 130
    case vis2 = 131
    case vis3 = 132
    case grp32bit = 133
    case grp64bit = 134
    case ending = 135
}

