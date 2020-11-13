import Ccapstone

extension X86Instruction: OperandContainer {
    /// Instruction prefix, which can be up to 4 elements.
    public var prefix: [X86Prefix] {
        let bytes: [UInt8] = readDetailsArray(array: detail?.x86.prefix, size: 4)
        return bytes.compactMap({ optionalEnumCast($0, ignoring: 0)})
    }
    
    /// Instruction opcode, which can be from 1 to 4 bytes in size.
    /// This contains VEX opcode as well.
    public var opcode: [UInt8] {
        readDetailsArray(array: detail?.x86.opcode, size: 4).filter({ $0 != 0 })
    }
    
    /// REX prefix (x86_64)
    public var rex: UInt8! { nonZero(detail?.x86.rex) }
    
    /// Address size, which can be overridden with prefix
    public var addressSize: UInt8! { detail?.x86.addr_size }
    
    /// ModR/M byte
    public var modRM: UInt8! { detail?.x86.modrm }
    
    /// Displacement value
    public var displacement: Int64! {
        guard encoding?.displacement != nil else {
            return nil
        }
        return detail?.x86.disp
    }
    
    /// SIB (Scaled Index Byte)
    public var sib: SIB! {
        guard let value = detail?.x86.sib,
            let base: X86Reg = optionalEnumCast(detail?.x86.sib_base, ignoring: X86_REG_INVALID),
            let index: X86Reg = optionalEnumCast(detail?.x86.sib_index, ignoring: X86_REG_INVALID) else {
            return nil
        }
        return SIB(
            scale: detail!.x86.sib_scale,
            base: base,
            index: index,
            value: value)
    }
    
    // XOP Condition Code
    public var xopConditionCode: X86XopCc! {
        optionalEnumCast(detail?.x86.xop_cc, ignoring: X86_XOP_CC_INVALID)
    }
    
    // SSE Condition Code
    public var sseConditionCode: X86SseCc! {
        optionalEnumCast(detail?.x86.sse_cc, ignoring: X86_SSE_CC_INVALID)
    }
    
    // AVX Condition Code
    public var avxConditionCode: X86AvxCc! {
        optionalEnumCast(detail?.x86.avx_cc, ignoring: X86_AVX_CC_INVALID)
    }
    
    /// AVX Suppress all Exception
    public var avxSuppressAllException: Bool! {
        detail?.x86.avx_sae
    }
    
    /// AVX static rounding mode
    public var avxStaticRoundingMode: X86AvxRm! {
        optionalEnumCast(detail?.x86.avx_rm, ignoring: X86_AVX_RM_INVALID)
    }
    
    /// EFLAGS updated by this instruction.
    public var eFlags: X86Eflags! {
        guard let flags = detail?.x86.eflags, !isIn(group: .fpu) else {
            return nil
        }
        return X86Eflags(rawValue: flags)
    }
    
    /// FPU flags updated by this instruction.
    public var fpuFlags: X86FpuFlags! {
        guard let flags = detail?.x86.eflags, isIn(group: .fpu) else {
            return nil
        }
        return X86FpuFlags(rawValue: flags)
    }
    
    /// Encoding information
    public var encoding: Encoding! {
        Encoding(detail?.x86.encoding)
    }
    
    public var operands: [Operand] {
        let operands: [cs_x86_op] = readDetailsArray(array: detail?.x86.operands, size: detail?.x86.op_count)
        return operands.map({ Operand(op: $0) })
    }
    
    public struct Operand: InstructionOperand {
        internal var op: cs_x86_op
        
        public var type: X86Op { enumCast(op.type) }
        public var value: X86OperandValue {
            switch type {
            case .reg:
                return register
            case .imm:
                return immediateValue
            case .mem:
                return memory
            default:
                fatalError("Invalid x86 operand type \(type.rawValue)")
            }
        }
        
        /// size of this operand (in bytes).
        public var size: UInt8 { op.size }
        
        /// Operand access mode
        public var access: Access { enumCast(op.access) }
        
        /// AVX broadcast type
        public var avxBroadcastType: X86AvxBcast! { optionalEnumCast(op.avx_bcast, ignoring: X86_AVX_BCAST_INVALID) }
        
        /// AVX zero opmask {z}
        public var avxZeroOpmask: Bool { op.avx_zero_opmask }
        
        /// Register value for register operand
        public var register: X86Reg! {
            guard type == .reg else {
                return nil
            }
            return enumCast(op.reg)
        }
        
        /// Immediate value for immediate operand
        public var immediateValue: Int64! {
            guard type == .imm else {
                return nil
            }
            return op.imm
        }
        
        /// Values for memory operand
        public var memory: Memory! {
            guard type == .mem else {
                return nil
            }
            return Memory(op.mem)
        }
        
        /// Instruction's operand referring to memory
        public struct Memory {
            public let segment: X86Reg?
            public let base: X86Reg?
            public let index: X86Reg?
            public let scale: Int32
            public let displacement: Int64
            
            init(_ mem: x86_op_mem) {
                segment = optionalEnumCast(mem.segment, ignoring: X86_REG_INVALID)
                base = optionalEnumCast(mem.base, ignoring: X86_REG_INVALID)
                index = optionalEnumCast(mem.index, ignoring: X86_REG_INVALID)
                scale = mem.scale
                displacement = mem.disp
            }
        }
    }
    
    /// SIB Layout
    public struct SIB {
        public let scale: Int8
        public let base: X86Reg
        public let index: X86Reg
        public let value: UInt8
    }
    
    /// Encoding information
    public struct Encoding {
        /// ModR/M offset
        public let modRMOffset: UInt8?
        
        /// Displacement information
        public let displacement: (offset: UInt8, size: UInt8)?
        
        /// Immediate information
        public let immediate: (offset: UInt8, size: UInt8)?
        
        init?(_ value: cs_x86_encoding?) {
            guard let value = value else {
                return nil
            }
            modRMOffset = nonZero(value.modrm_offset)
            if value.disp_offset != 0 {
                displacement = (offset: value.disp_offset, size: value.disp_size)
            } else {
                displacement = nil
            }
            if value.imm_offset != 0 {
                immediate = (offset: value.imm_offset, size: value.imm_size)
            } else {
                immediate = nil
            }
        }
    }
}

public protocol X86OperandValue {}
extension X86Reg: X86OperandValue {}
extension Int64: X86OperandValue {}
extension X86Instruction.Operand.Memory: X86OperandValue {}

extension X86Eflags: CustomStringConvertible {
    static func getFlagName(_ flag: UInt64) -> String {
        guard flag.nonzeroBitCount == 1 else {
            fatalError("Not a flag: \(flag)")
        }
        switch flag {
        case X86_EFLAGS_UNDEFINED_OF:
            return "UNDEF_OF"
        case X86_EFLAGS_UNDEFINED_SF:
            return "UNDEF_SF"
        case X86_EFLAGS_UNDEFINED_ZF:
            return "UNDEF_ZF"
        case X86_EFLAGS_MODIFY_AF:
            return "MOD_AF"
        case X86_EFLAGS_UNDEFINED_PF:
            return "UNDEF_PF"
        case X86_EFLAGS_MODIFY_CF:
            return "MOD_CF"
        case X86_EFLAGS_MODIFY_SF:
            return "MOD_SF"
        case X86_EFLAGS_MODIFY_ZF:
            return "MOD_ZF"
        case X86_EFLAGS_UNDEFINED_AF:
            return "UNDEF_AF"
        case X86_EFLAGS_MODIFY_PF:
            return "MOD_PF"
        case X86_EFLAGS_UNDEFINED_CF:
            return "UNDEF_CF"
        case X86_EFLAGS_MODIFY_OF:
            return "MOD_OF"
        case X86_EFLAGS_RESET_OF:
            return "RESET_OF"
        case X86_EFLAGS_RESET_CF:
            return "RESET_CF"
        case X86_EFLAGS_RESET_DF:
            return "RESET_DF"
        case X86_EFLAGS_RESET_IF:
            return "RESET_IF"
        case X86_EFLAGS_TEST_OF:
            return "TEST_OF"
        case X86_EFLAGS_TEST_SF:
            return "TEST_SF"
        case X86_EFLAGS_TEST_ZF:
            return "TEST_ZF"
        case X86_EFLAGS_TEST_PF:
            return "TEST_PF"
        case X86_EFLAGS_TEST_CF:
            return "TEST_CF"
        case X86_EFLAGS_RESET_SF:
            return "RESET_SF"
        case X86_EFLAGS_RESET_AF:
            return "RESET_AF"
        case X86_EFLAGS_RESET_TF:
            return "RESET_TF"
        case X86_EFLAGS_RESET_NT:
            return "RESET_NT"
        case X86_EFLAGS_PRIOR_OF:
            return "PRIOR_OF"
        case X86_EFLAGS_PRIOR_SF:
            return "PRIOR_SF"
        case X86_EFLAGS_PRIOR_ZF:
            return "PRIOR_ZF"
        case X86_EFLAGS_PRIOR_AF:
            return "PRIOR_AF"
        case X86_EFLAGS_PRIOR_PF:
            return "PRIOR_PF"
        case X86_EFLAGS_PRIOR_CF:
            return "PRIOR_CF"
        case X86_EFLAGS_PRIOR_TF:
            return "PRIOR_TF"
        case X86_EFLAGS_PRIOR_IF:
            return "PRIOR_IF"
        case X86_EFLAGS_PRIOR_DF:
            return "PRIOR_DF"
        case X86_EFLAGS_TEST_NT:
            return "TEST_NT"
        case X86_EFLAGS_TEST_DF:
            return "TEST_DF"
        case X86_EFLAGS_RESET_PF:
            return "RESET_PF"
        case X86_EFLAGS_PRIOR_NT:
            return "PRIOR_NT"
        case X86_EFLAGS_MODIFY_TF:
            return "MOD_TF"
        case X86_EFLAGS_MODIFY_IF:
            return "MOD_IF"
        case X86_EFLAGS_MODIFY_DF:
            return "MOD_DF"
        case X86_EFLAGS_MODIFY_NT:
            return "MOD_NT"
        case X86_EFLAGS_MODIFY_RF:
            return "MOD_RF"
        case X86_EFLAGS_SET_CF:
            return "SET_CF"
        case X86_EFLAGS_SET_DF:
            return "SET_DF"
        case X86_EFLAGS_SET_IF:
            return "SET_IF"
        default:
            return "0x\(String(flag, radix: 16))"
        }
    }
    
    public var flagNames: [String] {
        (0..<64).map({ 1 << $0 })
            .filter({ self.contains(X86Eflags(rawValue: $0)) })
            .map({ X86Eflags.getFlagName($0) })
    }
    
    public var description: String {
        flagNames.joined(separator: " ")
    }
}

extension X86FpuFlags: CustomStringConvertible {
    static func getFlagName(_ flag: UInt64) -> String {
        guard flag.nonzeroBitCount == 1 else {
            fatalError("Not a flag: \(flag)")
        }
        switch flag {
        case X86_FPU_FLAGS_MODIFY_C0:
            return "MOD_C0"
        case X86_FPU_FLAGS_MODIFY_C1:
            return "MOD_C1"
        case X86_FPU_FLAGS_MODIFY_C2:
            return "MOD_C2"
        case X86_FPU_FLAGS_MODIFY_C3:
            return "MOD_C3"
        case X86_FPU_FLAGS_RESET_C0:
            return "RESET_C0"
        case X86_FPU_FLAGS_RESET_C1:
            return "RESET_C1"
        case X86_FPU_FLAGS_RESET_C2:
            return "RESET_C2"
        case X86_FPU_FLAGS_RESET_C3:
            return "RESET_C3"
        case X86_FPU_FLAGS_SET_C0:
            return "SET_C0"
        case X86_FPU_FLAGS_SET_C1:
            return "SET_C1"
        case X86_FPU_FLAGS_SET_C2:
            return "SET_C2"
        case X86_FPU_FLAGS_SET_C3:
            return "SET_C3"
        case X86_FPU_FLAGS_UNDEFINED_C0:
            return "UNDEF_C0"
        case X86_FPU_FLAGS_UNDEFINED_C1:
            return "UNDEF_C1"
        case X86_FPU_FLAGS_UNDEFINED_C2:
            return "UNDEF_C2"
        case X86_FPU_FLAGS_UNDEFINED_C3:
            return "UNDEF_C3"
        case X86_FPU_FLAGS_TEST_C0:
            return "TEST_C0"
        case X86_FPU_FLAGS_TEST_C1:
            return "TEST_C1"
        case X86_FPU_FLAGS_TEST_C2:
            return "TEST_C2"
        case X86_FPU_FLAGS_TEST_C3:
            return "TEST_C3"
        default:
            return "0x\(String(flag, radix: 16))"
        }
    }
    
    public var flagNames: [String] {
        (0..<64).map({ 1 << $0 })
            .filter({ self.contains(X86FpuFlags(rawValue: $0)) })
            .map({ X86FpuFlags.getFlagName($0) })
    }
    
    public var description: String {
        flagNames.joined(separator: " ")
    }
}
