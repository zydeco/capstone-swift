// For Capstone Engine. AUTO-GENERATED FILE, DO NOT EDIT (Bpf)


/// Operand type for instruction's operands
public enum BpfOp: UInt32 {
    case invalid = 0
    case reg = 1
    case imm = 2
    case off = 3
    case mem = 4
    /// M[k] in cBPF
    case mmem = 5
    /// corresponds to cBPF's BPF_MSH mode
    case msh = 6
    /// cBPF's extension (not eBPF)
    case ext = 7

}

/// BPF registers
public enum BpfReg: UInt16 {
    case invalid = 0
    case a = 1
    case x = 2
    case r0 = 3
    case r1 = 4
    case r2 = 5
    case r3 = 6
    case r4 = 7
    case r5 = 8
    case r6 = 9
    case r7 = 10
    case r8 = 11
    case r9 = 12
    case r10 = 13
    case ending = 14

}

public enum BpfExt: UInt32 {
    case invalid = 0
    case len = 1

}

/// BPF instruction
public enum BpfIns: UInt32 {
    case invalid = 0
    case add = 1
    case sub = 2
    case mul = 3
    case div = 4
    case or = 5
    case and = 6
    case lsh = 7
    case rsh = 8
    case neg = 9
    case mod = 10
    case xor = 11
    /// eBPF only
    case mov = 12
    /// eBPF only
    case arsh = 13
    case add64 = 14
    case sub64 = 15
    case mul64 = 16
    case div64 = 17
    case or64 = 18
    case and64 = 19
    case lsh64 = 20
    case rsh64 = 21
    case neg64 = 22
    case mod64 = 23
    case xor64 = 24
    case mov64 = 25
    case arsh64 = 26
    case le16 = 27
    case le32 = 28
    case le64 = 29
    case be16 = 30
    case be32 = 31
    case be64 = 32
    /// eBPF only
    case ldw = 33
    case ldh = 34
    case ldb = 35
    /// eBPF only: load 64-bit imm
    case lddw = 36
    /// eBPF only
    case ldxw = 37
    /// eBPF only
    case ldxh = 38
    /// eBPF only
    case ldxb = 39
    /// eBPF only
    case ldxdw = 40
    /// eBPF only
    case stw = 41
    /// eBPF only
    case sth = 42
    /// eBPF only
    case stb = 43
    /// eBPF only
    case stdw = 44
    /// eBPF only
    case stxw = 45
    /// eBPF only
    case stxh = 46
    /// eBPF only
    case stxb = 47
    /// eBPF only
    case stxdw = 48
    /// eBPF only
    case xaddw = 49
    /// eBPF only
    case xadddw = 50
    case jmp = 51
    case jeq = 52
    case jgt = 53
    case jge = 54
    case jset = 55
    /// eBPF only
    case jne = 56
    /// eBPF only
    case jsgt = 57
    /// eBPF only
    case jsge = 58
    /// eBPF only
    case call = 59
    /// eBPF only
    case exit = 60
    /// eBPF only
    case jlt = 61
    /// eBPF only
    case jle = 62
    /// eBPF only
    case jslt = 63
    /// eBPF only
    case jsle = 64
    case ret = 65
    case tax = 66
    case txa = 67
    case ending = 68
    /// cBPF only
    public static let ld = 33
    /// cBPF only
    public static let ldx = 37
    /// cBPF only
    public static let st = 41
    /// cBPF only
    public static let stx = 45

}

/// Group of BPF instructions
public enum BpfGrp: UInt8 {
    /// = CS_GRP_INVALID
    case invalid = 0
    case load = 1
    case store = 2
    case alu = 3
    case jump = 4
    /// eBPF only
    case call = 5
    case `return` = 6
    /// cBPF only
    case misc = 7
    case ending = 8
}

