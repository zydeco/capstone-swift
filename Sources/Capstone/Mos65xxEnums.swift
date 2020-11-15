// For Capstone Engine. AUTO-GENERATED FILE, DO NOT EDIT (Mos65xx)


/// MOS65XX registers and special registers
public enum Mos65xxReg: UInt16 {
    case invalid = 0
    /// accumulator
    case acc = 1
    /// X index register
    case x = 2
    /// Y index register
    case y = 3
    /// status register
    case p = 4
    /// stack pointer register
    case sp = 5
    /// direct page register
    case dp = 6
    /// data bank register
    case b = 7
    /// program bank register
    case k = 8
    case ending = 9

}

/// MOS65XX Addressing Modes
public enum Mos65xxAm: UInt32 {
    /// No address mode.
    case none = 0
    /// implied addressing (no addressing mode)
    case imp = 1
    /// accumulator addressing
    case acc = 2
    /// 8/16 Bit immediate value
    case imm = 3
    /// relative addressing used by branches
    case rel = 4
    /// interrupt addressing
    case int = 5
    /// memory block addressing
    case block = 6
    /// zeropage addressing
    case zp = 7
    /// indexed zeropage addressing by the X index register
    case zpX = 8
    /// indexed zeropage addressing by the Y index register
    case zpY = 9
    /// zero page address, branch relative address
    case zpRel = 10
    /// indirect zeropage addressing
    case zpInd = 11
    /// indexed zeropage indirect addressing by the X index register
    case zpXInd = 12
    /// indirect zeropage indexed addressing by the Y index register
    case zpIndY = 13
    /// zeropage indirect long addressing
    case zpIndLong = 14
    /// zeropage indirect long addressing indexed by Y register
    case zpIndLongY = 15
    /// absolute addressing
    case abs = 16
    /// indexed absolute addressing by the X index register
    case absX = 17
    /// indexed absolute addressing by the Y index register
    case absY = 18
    /// absolute indirect addressing
    case absInd = 19
    /// indexed absolute indirect addressing by the X index register
    case absXInd = 20
    /// absolute indirect long addressing
    case absIndLong = 21
    /// absolute long address mode
    case absLong = 22
    /// absolute long address mode, indexed by X register
    case absLongX = 23
    /// stack relative addressing
    case sr = 24
    /// indirect stack relative addressing indexed by the Y index register
    case srIndY = 25

}

/// MOS65XX instruction
public enum Mos65xxIns: UInt32 {
    case invalid = 0
    case adc = 1
    case and = 2
    case asl = 3
    case bbr = 4
    case bbs = 5
    case bcc = 6
    case bcs = 7
    case beq = 8
    case bit = 9
    case bmi = 10
    case bne = 11
    case bpl = 12
    case bra = 13
    case brk = 14
    case brl = 15
    case bvc = 16
    case bvs = 17
    case clc = 18
    case cld = 19
    case cli = 20
    case clv = 21
    case cmp = 22
    case cop = 23
    case cpx = 24
    case cpy = 25
    case dec = 26
    case dex = 27
    case dey = 28
    case eor = 29
    case inc = 30
    case inx = 31
    case iny = 32
    case jml = 33
    case jmp = 34
    case jsl = 35
    case jsr = 36
    case lda = 37
    case ldx = 38
    case ldy = 39
    case lsr = 40
    case mvn = 41
    case mvp = 42
    case nop = 43
    case ora = 44
    case pea = 45
    case pei = 46
    case per = 47
    case pha = 48
    case phb = 49
    case phd = 50
    case phk = 51
    case php = 52
    case phx = 53
    case phy = 54
    case pla = 55
    case plb = 56
    case pld = 57
    case plp = 58
    case plx = 59
    case ply = 60
    case rep = 61
    case rmb = 62
    case rol = 63
    case ror = 64
    case rti = 65
    case rtl = 66
    case rts = 67
    case sbc = 68
    case sec = 69
    case sed = 70
    case sei = 71
    case sep = 72
    case smb = 73
    case sta = 74
    case stp = 75
    case stx = 76
    case sty = 77
    case stz = 78
    case tax = 79
    case tay = 80
    case tcd = 81
    case tcs = 82
    case tdc = 83
    case trb = 84
    case tsb = 85
    case tsc = 86
    case tsx = 87
    case txa = 88
    case txs = 89
    case txy = 90
    case tya = 91
    case tyx = 92
    case wai = 93
    case wdm = 94
    case xba = 95
    case xce = 96
    case ending = 97

}

/// Group of MOS65XX instructions
public enum Mos65xxGrp: UInt8 {
    /// CS_GRP_INVALID
    case invalid = 0
    /// = CS_GRP_JUMP
    case jump = 1
    /// = CS_GRP_RET
    case call = 2
    /// = CS_GRP_RET
    case ret = 3
    /// = CS_GRP_INT
    case int = 4
    /// = CS_GRP_IRET
    case iret = 5
    /// = CS_GRP_BRANCH_RELATIVE
    case branchRelative = 6
    case ending = 7

}

/// Operand type for instruction's operands
public enum Mos65xxOp: UInt32 {
    /// = CS_OP_INVALID (Uninitialized).
    case invalid = 0
    /// = CS_OP_REG (Register operand).
    case reg = 1
    /// = CS_OP_IMM (Immediate operand).
    case imm = 2
    /// = CS_OP_MEM (Memory operand).
    case mem = 3
}

