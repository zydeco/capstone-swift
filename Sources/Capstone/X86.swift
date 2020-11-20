import Ccapstone

extension X86Instruction: OperandContainer {
    /// Instruction prefix, which can be up to 4 elements.
    ///
    /// Empty when detail mode is off.
    public var prefix: [X86Prefix] {
        let bytes: [UInt8] = readDetailsArray(array: detail?.x86.prefix, size: 4)
        return bytes.compactMap({ optionalEnumCast($0, ignoring: 0)})
    }

    /// Instruction opcode, which can be from 1 to 4 bytes in size.
    /// This contains VEX opcode as well..
    ///
    /// Empty when detail mode is off.
    public var opcode: [UInt8] {
        readDetailsArray(array: detail?.x86.opcode, size: 4).filter({ $0 != 0 })
    }

    /// REX prefix (x86_64).
    ///
    /// `nil` when detail mode is off, or not appropriate instruction.
    public var rex: UInt8! { nonZero(detail?.x86.rex) }

    /// Address size, which can be overridden with prefix.
    ///
    /// `nil` when detail mode is off.
    public var addressSize: UInt8! { detail?.x86.addr_size }

    /// ModR/M byte.
    ///
    /// `nil` when detail mode is off.
    public var modRM: UInt8! { detail?.x86.modrm }

    /// Displacement value.
    ///
    /// `nil` when detail mode is off.
    public var displacement: Int64! {
        guard encoding?.displacement != nil else {
            return nil
        }
        return detail?.x86.disp
    }

    /// SIB (Scaled Index Byte).
    ///
    /// `nil` when detail mode is off, or not appropriate instruction.
    public var sib: SIB! {
        guard let value = detail?.x86.sib,
            let base: X86Reg = optionalEnumCast(detail?.x86.sib_base, ignoring: X86_REG_INVALID),
            let index: X86Reg = optionalEnumCast(detail?.x86.sib_index, ignoring: X86_REG_INVALID) else {
            return nil
        }
        return SIB(
            scale: detail!.x86.sib_scale,
            index: index,
            base: base,
            value: value)
    }

    /// XOP Condition Code.
    ///
    /// `nil` when detail mode is off, or doesn't exist.
    public var xopConditionCode: X86XopCc! {
        optionalEnumCast(detail?.x86.xop_cc, ignoring: X86_XOP_CC_INVALID)
    }

    /// SSE Condition Code.
    ///
    /// `nil` when detail mode is off, or doesn't exist.
    public var sseConditionCode: X86SseCc! {
        optionalEnumCast(detail?.x86.sse_cc, ignoring: X86_SSE_CC_INVALID)
    }

    /// AVX Condition Code.
    ///
    /// `nil` when detail mode is off, or doesn't exist.
    public var avxConditionCode: X86AvxCc! {
        optionalEnumCast(detail?.x86.avx_cc, ignoring: X86_AVX_CC_INVALID)
    }

    /// AVX Suppress all Exception.
    ///
    /// `nil` when detail mode is off.
    public var avxSuppressAllException: Bool! {
        detail?.x86.avx_sae
    }

    /// AVX static rounding mode.
    ///
    /// `nil` when detail mode is off, or not AVX instruction.
    public var avxStaticRoundingMode: X86AvxRm! {
        optionalEnumCast(detail?.x86.avx_rm, ignoring: X86_AVX_RM_INVALID)
    }

    /// EFLAGS updated by this instruction..
    ///
    /// `nil` when detail mode is off, or if this is a FPU instruction.
    public var eFlags: X86Eflags! {
        guard let flags = detail?.x86.eflags, !isIn(group: .fpu) else {
            return nil
        }
        return X86Eflags(rawValue: flags)
    }

    /// FPU flags updated by this instruction.
    ///
    /// `nil` when detail mode is off, or not a FPU instruction.
    public var fpuFlags: X86FpuFlags! {
        guard let flags = detail?.x86.eflags, isIn(group: .fpu) else {
            return nil
        }
        return X86FpuFlags(rawValue: flags)
    }

    /// Encoding information.
    ///
    /// `nil` when detail mode is off.
    public var encoding: Encoding! {
        Encoding(detail?.x86.encoding)
    }

    /// Instruction operands.
    ///
    /// Empty when detail mode is off.
    public var operands: [Operand] {
        let operands: [cs_x86_op] = readDetailsArray(array: detail?.x86.operands, size: detail?.x86.op_count)
        return operands.map({ Operand(op: $0) })
    }

    /// Operand for X86 instructions.
    ///
    /// The operand's value can be accessed by the `value` property, or by a property corresponding to the operand's type:
    /// - `register` for `reg` operands.
    /// - `immediateValue` for `imm` operands.
    /// - `memory` for `mem` operands.
    public struct Operand: InstructionOperand {
        internal var op: cs_x86_op

        /// Operand type.
        public var type: X86Op { enumCast(op.type) }

        /// Operand value.
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

        /// Size of this operand (in bytes).
        public var size: UInt8 { op.size }

        /// Operand access mode.
        public var access: Access { enumCast(op.access) }

        /// AVX broadcast type.
        public var avxBroadcastType: X86AvxBcast! { optionalEnumCast(op.avx_bcast, ignoring: X86_AVX_BCAST_INVALID) }

        /// AVX zero opmask {z}.
        public var avxZeroOpmask: Bool { op.avx_zero_opmask }

        /// Register value for `reg` operand.
        ///
        /// `nil` when not an appropriate operand.
        public var register: X86Reg! {
            guard type == .reg else {
                return nil
            }
            return enumCast(op.reg)
        }

        /// Immediate value for `imm` operand.
        ///
        /// `nil` when not an appropriate operand.
        public var immediateValue: Int64! {
            guard type == .imm else {
                return nil
            }
            return op.imm
        }

        /// Values for `mem` operand.
        ///
        /// `nil` when not an appropriate operand.
        public var memory: Memory! {
            guard type == .mem else {
                return nil
            }
            return Memory(op.mem)
        }

        /// Operand referring to memory
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
        public let index: X86Reg
        public let base: X86Reg
        /// Encoded scale/index/base.
        public let value: UInt8
    }

    /// Encoding information.
    public struct Encoding {
        /// ModR/M offset.
        public let modRMOffset: UInt8?

        /// Displacement information.
        public let displacement: (offset: UInt8, size: UInt8)?

        /// Immediate information.
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
    private static let flagName = [
        X86_EFLAGS_UNDEFINED_OF: "UNDEF_OF",
        X86_EFLAGS_UNDEFINED_SF: "UNDEF_SF",
        X86_EFLAGS_UNDEFINED_ZF: "UNDEF_ZF",
        X86_EFLAGS_MODIFY_AF: "MOD_AF",
        X86_EFLAGS_UNDEFINED_PF: "UNDEF_PF",
        X86_EFLAGS_MODIFY_CF: "MOD_CF",
        X86_EFLAGS_MODIFY_SF: "MOD_SF",
        X86_EFLAGS_MODIFY_ZF: "MOD_ZF",
        X86_EFLAGS_UNDEFINED_AF: "UNDEF_AF",
        X86_EFLAGS_MODIFY_PF: "MOD_PF",
        X86_EFLAGS_UNDEFINED_CF: "UNDEF_CF",
        X86_EFLAGS_MODIFY_OF: "MOD_OF",
        X86_EFLAGS_RESET_OF: "RESET_OF",
        X86_EFLAGS_RESET_CF: "RESET_CF",
        X86_EFLAGS_RESET_DF: "RESET_DF",
        X86_EFLAGS_RESET_IF: "RESET_IF",
        X86_EFLAGS_TEST_OF: "TEST_OF",
        X86_EFLAGS_TEST_SF: "TEST_SF",
        X86_EFLAGS_TEST_ZF: "TEST_ZF",
        X86_EFLAGS_TEST_PF: "TEST_PF",
        X86_EFLAGS_TEST_CF: "TEST_CF",
        X86_EFLAGS_RESET_SF: "RESET_SF",
        X86_EFLAGS_RESET_AF: "RESET_AF",
        X86_EFLAGS_RESET_TF: "RESET_TF",
        X86_EFLAGS_RESET_NT: "RESET_NT",
        X86_EFLAGS_PRIOR_OF: "PRIOR_OF",
        X86_EFLAGS_PRIOR_SF: "PRIOR_SF",
        X86_EFLAGS_PRIOR_ZF: "PRIOR_ZF",
        X86_EFLAGS_PRIOR_AF: "PRIOR_AF",
        X86_EFLAGS_PRIOR_PF: "PRIOR_PF",
        X86_EFLAGS_PRIOR_CF: "PRIOR_CF",
        X86_EFLAGS_PRIOR_TF: "PRIOR_TF",
        X86_EFLAGS_PRIOR_IF: "PRIOR_IF",
        X86_EFLAGS_PRIOR_DF: "PRIOR_DF",
        X86_EFLAGS_TEST_NT: "TEST_NT",
        X86_EFLAGS_TEST_DF: "TEST_DF",
        X86_EFLAGS_RESET_PF: "RESET_PF",
        X86_EFLAGS_PRIOR_NT: "PRIOR_NT",
        X86_EFLAGS_MODIFY_TF: "MOD_TF",
        X86_EFLAGS_MODIFY_IF: "MOD_IF",
        X86_EFLAGS_MODIFY_DF: "MOD_DF",
        X86_EFLAGS_MODIFY_NT: "MOD_NT",
        X86_EFLAGS_MODIFY_RF: "MOD_RF",
        X86_EFLAGS_SET_CF: "SET_CF",
        X86_EFLAGS_SET_DF: "SET_DF",
        X86_EFLAGS_SET_IF: "SET_IF"
    ]

    static func getFlagName(_ flag: UInt64) -> String {
        guard flag.nonzeroBitCount == 1 else {
            fatalError("Not a flag: \(flag)")
        }
        guard let name = flagName[flag] else {
            return "0x\(String(flag, radix: 16))"
        }
        return name
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
    private static let flagName = [
        X86_FPU_FLAGS_MODIFY_C0: "MOD_C0",
        X86_FPU_FLAGS_MODIFY_C1: "MOD_C1",
        X86_FPU_FLAGS_MODIFY_C2: "MOD_C2",
        X86_FPU_FLAGS_MODIFY_C3: "MOD_C3",
        X86_FPU_FLAGS_RESET_C0: "RESET_C0",
        X86_FPU_FLAGS_RESET_C1: "RESET_C1",
        X86_FPU_FLAGS_RESET_C2: "RESET_C2",
        X86_FPU_FLAGS_RESET_C3: "RESET_C3",
        X86_FPU_FLAGS_SET_C0: "SET_C0",
        X86_FPU_FLAGS_SET_C1: "SET_C1",
        X86_FPU_FLAGS_SET_C2: "SET_C2",
        X86_FPU_FLAGS_SET_C3: "SET_C3",
        X86_FPU_FLAGS_UNDEFINED_C0: "UNDEF_C0",
        X86_FPU_FLAGS_UNDEFINED_C1: "UNDEF_C1",
        X86_FPU_FLAGS_UNDEFINED_C2: "UNDEF_C2",
        X86_FPU_FLAGS_UNDEFINED_C3: "UNDEF_C3",
        X86_FPU_FLAGS_TEST_C0: "TEST_C0",
        X86_FPU_FLAGS_TEST_C1: "TEST_C1",
        X86_FPU_FLAGS_TEST_C2: "TEST_C2",
        X86_FPU_FLAGS_TEST_C3: "TEST_C3"
    ]

    static func getFlagName(_ flag: UInt64) -> String {
        guard flag.nonzeroBitCount == 1 else {
            fatalError("Not a flag: \(flag)")
        }
        guard let name = flagName[flag] else {
            return "0x\(String(flag, radix: 16))"
        }
        return name
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

extension X86Ins: InstructionType {}
