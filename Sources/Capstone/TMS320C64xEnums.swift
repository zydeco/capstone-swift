// For Capstone Engine. AUTO-GENERATED FILE, DO NOT EDIT (TMS320C64x)


public enum Tms320c64xOp: UInt32 {
    /// = CS_OP_INVALID (Uninitialized).
    case invalid = 0
    /// = CS_OP_REG (Register operand).
    case reg = 1
    /// = CS_OP_IMM (Immediate operand).
    case imm = 2
    /// = CS_OP_MEM (Memory operand).
    case mem = 3
    /// Register pair for double word ops
    case regpair = 64

}

public enum Tms320c64xMemDisp: UInt32 {
    case invalid = 0
    case constant = 1
    case register = 2

}

public enum Tms320c64xMemDir: UInt32 {
    case invalid = 0
    case fw = 1
    case bw = 2

}

public enum Tms320c64xMemMod: UInt32 {
    case invalid = 0
    case no = 1
    case pre = 2
    case post = 3

}

public enum Tms320c64xReg: UInt16 {
    case invalid = 0
    case amr = 1
    case csr = 2
    case dier = 3
    case dnum = 4
    case ecr = 5
    case gfpgfr = 6
    case gplya = 7
    case gplyb = 8
    case icr = 9
    case ier = 10
    case ierr = 11
    case ilc = 12
    case irp = 13
    case isr = 14
    case istp = 15
    case itsr = 16
    case nrp = 17
    case ntsr = 18
    case rep = 19
    case rilc = 20
    case ssr = 21
    case tsch = 22
    case tscl = 23
    case tsr = 24
    case a0 = 25
    case a1 = 26
    case a2 = 27
    case a3 = 28
    case a4 = 29
    case a5 = 30
    case a6 = 31
    case a7 = 32
    case a8 = 33
    case a9 = 34
    case a10 = 35
    case a11 = 36
    case a12 = 37
    case a13 = 38
    case a14 = 39
    case a15 = 40
    case a16 = 41
    case a17 = 42
    case a18 = 43
    case a19 = 44
    case a20 = 45
    case a21 = 46
    case a22 = 47
    case a23 = 48
    case a24 = 49
    case a25 = 50
    case a26 = 51
    case a27 = 52
    case a28 = 53
    case a29 = 54
    case a30 = 55
    case a31 = 56
    case b0 = 57
    case b1 = 58
    case b2 = 59
    case b3 = 60
    case b4 = 61
    case b5 = 62
    case b6 = 63
    case b7 = 64
    case b8 = 65
    case b9 = 66
    case b10 = 67
    case b11 = 68
    case b12 = 69
    case b13 = 70
    case b14 = 71
    case b15 = 72
    case b16 = 73
    case b17 = 74
    case b18 = 75
    case b19 = 76
    case b20 = 77
    case b21 = 78
    case b22 = 79
    case b23 = 80
    case b24 = 81
    case b25 = 82
    case b26 = 83
    case b27 = 84
    case b28 = 85
    case b29 = 86
    case b30 = 87
    case b31 = 88
    case pce1 = 89
    case ending = 90
    static let efr = 5
    static let ifr = 14

}

public enum Tms320c64xIns: UInt32 {
    case invalid = 0
    case abs = 1
    case abs2 = 2
    case add = 3
    case add2 = 4
    case add4 = 5
    case addab = 6
    case addad = 7
    case addah = 8
    case addaw = 9
    case addk = 10
    case addkpc = 11
    case addu = 12
    case and = 13
    case andn = 14
    case avg2 = 15
    case avgu4 = 16
    case b = 17
    case bdec = 18
    case bitc4 = 19
    case bnop = 20
    case bpos = 21
    case clr = 22
    case cmpeq = 23
    case cmpeq2 = 24
    case cmpeq4 = 25
    case cmpgt = 26
    case cmpgt2 = 27
    case cmpgtu4 = 28
    case cmplt = 29
    case cmpltu = 30
    case deal = 31
    case dotp2 = 32
    case dotpn2 = 33
    case dotpnrsu2 = 34
    case dotprsu2 = 35
    case dotpsu4 = 36
    case dotpu4 = 37
    case ext = 38
    case extu = 39
    case gmpgtu = 40
    case gmpy4 = 41
    case ldb = 42
    case ldbu = 43
    case lddw = 44
    case ldh = 45
    case ldhu = 46
    case ldndw = 47
    case ldnw = 48
    case ldw = 49
    case lmbd = 50
    case max2 = 51
    case maxu4 = 52
    case min2 = 53
    case minu4 = 54
    case mpy = 55
    case mpy2 = 56
    case mpyh = 57
    case mpyhi = 58
    case mpyhir = 59
    case mpyhl = 60
    case mpyhlu = 61
    case mpyhslu = 62
    case mpyhsu = 63
    case mpyhu = 64
    case mpyhuls = 65
    case mpyhus = 66
    case mpylh = 67
    case mpylhu = 68
    case mpyli = 69
    case mpylir = 70
    case mpylshu = 71
    case mpyluhs = 72
    case mpysu = 73
    case mpysu4 = 74
    case mpyu = 75
    case mpyu4 = 76
    case mpyus = 77
    case mvc = 78
    case mvd = 79
    case mvk = 80
    case mvkl = 81
    case mvklh = 82
    case nop = 83
    case norm = 84
    case or = 85
    case pack2 = 86
    case packh2 = 87
    case packh4 = 88
    case packhl2 = 89
    case packl4 = 90
    case packlh2 = 91
    case rotl = 92
    case sadd = 93
    case sadd2 = 94
    case saddu4 = 95
    case saddus2 = 96
    case sat = 97
    case set = 98
    case shfl = 99
    case shl = 100
    case shlmb = 101
    case shr = 102
    case shr2 = 103
    case shrmb = 104
    case shru = 105
    case shru2 = 106
    case smpy = 107
    case smpy2 = 108
    case smpyh = 109
    case smpyhl = 110
    case smpylh = 111
    case spack2 = 112
    case spacku4 = 113
    case sshl = 114
    case sshvl = 115
    case sshvr = 116
    case ssub = 117
    case stb = 118
    case stdw = 119
    case sth = 120
    case stndw = 121
    case stnw = 122
    case stw = 123
    case sub = 124
    case sub2 = 125
    case sub4 = 126
    case subab = 127
    case subabs4 = 128
    case subah = 129
    case subaw = 130
    case subc = 131
    case subu = 132
    case swap4 = 133
    case unpkhu4 = 134
    case unpklu4 = 135
    case xor = 136
    case xpnd2 = 137
    case xpnd4 = 138
    case idle = 139
    case mv = 140
    case neg = 141
    case not = 142
    case swap2 = 143
    case zero = 144
    case ending = 145

}

public enum Tms320c64xGrp: UInt8 {
    /// = CS_GRP_INVALID
    case invalid = 0
    /// = CS_GRP_JUMP
    case jump = 1
    case funitD = 128
    case funitL = 129
    case funitM = 130
    case funitS = 131
    case funitNo = 132
    case ending = 133

}

public enum Tms320c64xFunit: UInt32 {
    case invalid = 0
    case d = 1
    case l = 2
    case m = 3
    case s = 4
    case no = 5
}

