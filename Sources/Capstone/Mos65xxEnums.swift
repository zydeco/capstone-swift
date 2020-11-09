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
    case ending = 6

}

/// MOS65XX Addressing Modes
public enum Mos65xxAm: UInt32 {
    /// No address mode.
    case none = 0
    /// implied addressing (no addressing mode)
    case imp = 1
    /// accumulator addressing
    case acc = 2
    /// absolute addressing
    case abs = 3
    /// zeropage addressing
    case zp = 4
    /// 8 Bit immediate value
    case imm = 5
    /// indexed absolute addressing by the X index register
    case absx = 6
    /// indexed absolute addressing by the Y index register
    case absy = 7
    /// indexed indirect addressing by the X index register
    case indx = 8
    /// indirect indexed addressing by the Y index register
    case indy = 9
    /// indexed zeropage addressing by the X index register
    case zpx = 10
    /// indexed zeropage addressing by the Y index register
    case zpy = 11
    /// relative addressing used by branches
    case rel = 12
    /// absolute indirect addressing
    case ind = 13

}

/// MOS65XX instruction
public enum Mos65xxIns: UInt32 {
    case invalid = 0
    case adc = 1
    case and = 2
    case asl = 3
    case bcc = 4
    case bcs = 5
    case beq = 6
    case bit = 7
    case bmi = 8
    case bne = 9
    case bpl = 10
    case brk = 11
    case bvc = 12
    case bvs = 13
    case clc = 14
    case cld = 15
    case cli = 16
    case clv = 17
    case cmp = 18
    case cpx = 19
    case cpy = 20
    case dec = 21
    case dex = 22
    case dey = 23
    case eor = 24
    case inc = 25
    case inx = 26
    case iny = 27
    case jmp = 28
    case jsr = 29
    case lda = 30
    case ldx = 31
    case ldy = 32
    case lsr = 33
    case nop = 34
    case ora = 35
    case pha = 36
    case pla = 37
    case php = 38
    case plp = 39
    case rol = 40
    case ror = 41
    case rti = 42
    case rts = 43
    case sbc = 44
    case sec = 45
    case sed = 46
    case sei = 47
    case sta = 48
    case stx = 49
    case sty = 50
    case tax = 51
    case tay = 52
    case tsx = 53
    case txa = 54
    case txs = 55
    case tya = 56
    case ending = 57

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

