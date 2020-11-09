// For Capstone Engine. AUTO-GENERATED FILE, DO NOT EDIT (Xcore)


/// Operand type for instruction's operands
public enum XcoreOp: UInt32 {
    /// = CS_OP_INVALID (Uninitialized).
    case invalid = 0
    /// = CS_OP_REG (Register operand).
    case reg = 1
    /// = CS_OP_IMM (Immediate operand).
    case imm = 2
    /// = CS_OP_MEM (Memory operand).
    case mem = 3

}

/// XCore registers
public enum XcoreReg: UInt16 {
    case invalid = 0
    case cp = 1
    case dp = 2
    case lr = 3
    case sp = 4
    case r0 = 5
    case r1 = 6
    case r2 = 7
    case r3 = 8
    case r4 = 9
    case r5 = 10
    case r6 = 11
    case r7 = 12
    case r8 = 13
    case r9 = 14
    case r10 = 15
    case r11 = 16
    /// pc
    case pc = 17
    /// save pc
    case scp = 18
    case ssr = 19
    case et = 20
    case ed = 21
    case sed = 22
    case kep = 23
    case ksp = 24
    case id = 25
    case ending = 26

}

/// XCore instruction
public enum XcoreIns: UInt32 {
    case invalid = 0
    case add = 1
    case andnot = 2
    case and = 3
    case ashr = 4
    case bau = 5
    case bitrev = 6
    case bla = 7
    case blat = 8
    case bl = 9
    case bf = 10
    case bt = 11
    case bu = 12
    case bru = 13
    case byterev = 14
    case chkct = 15
    case clre = 16
    case clrpt = 17
    case clrsr = 18
    case clz = 19
    case crc8 = 20
    case crc32 = 21
    case dcall = 22
    case dentsp = 23
    case dgetreg = 24
    case divs = 25
    case divu = 26
    case drestsp = 27
    case dret = 28
    case ecallf = 29
    case ecallt = 30
    case edu = 31
    case eef = 32
    case eet = 33
    case eeu = 34
    case endin = 35
    case entsp = 36
    case eq = 37
    case extdp = 38
    case extsp = 39
    case freer = 40
    case freet = 41
    case getd = 42
    case get = 43
    case getn = 44
    case getr = 45
    case getsr = 46
    case getst = 47
    case getts = 48
    case inct = 49
    case `init` = 50
    case inpw = 51
    case inshr = 52
    case int = 53
    case `in` = 54
    case kcall = 55
    case kentsp = 56
    case krestsp = 57
    case kret = 58
    case ladd = 59
    case ld16s = 60
    case ld8u = 61
    case lda16 = 62
    case ldap = 63
    case ldaw = 64
    case ldc = 65
    case ldw = 66
    case ldivu = 67
    case lmul = 68
    case lss = 69
    case lsub = 70
    case lsu = 71
    case maccs = 72
    case maccu = 73
    case mjoin = 74
    case mkmsk = 75
    case msync = 76
    case mul = 77
    case neg = 78
    case not = 79
    case or = 80
    case outct = 81
    case outpw = 82
    case outshr = 83
    case outt = 84
    case out = 85
    case peek = 86
    case rems = 87
    case remu = 88
    case retsp = 89
    case setclk = 90
    case set = 91
    case setc = 92
    case setd = 93
    case setev = 94
    case setn = 95
    case setpsc = 96
    case setpt = 97
    case setrdy = 98
    case setsr = 99
    case settw = 100
    case setv = 101
    case sext = 102
    case shl = 103
    case shr = 104
    case ssync = 105
    case st16 = 106
    case st8 = 107
    case stw = 108
    case sub = 109
    case syncr = 110
    case testct = 111
    case testlcl = 112
    case testwct = 113
    case tsetmr = 114
    case start = 115
    case waitef = 116
    case waitet = 117
    case waiteu = 118
    case xor = 119
    case zext = 120
    case ending = 121

}

/// Group of XCore instructions
public enum XcoreGrp: UInt8 {
    /// = CS_GRP_INVALID
    case invalid = 0
    /// = CS_GRP_JUMP
    case jump = 1
    case ending = 2
}

