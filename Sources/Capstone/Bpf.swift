import Ccapstone

extension BpfInstruction: OperandContainer {
    /// Instruction operands.
    ///
    /// Empty when detail mode is off.
    public var operands: [Operand] {
        let operands: [cs_bpf_op] = readDetailsArray(array: detail?.bpf.operands, size: detail?.bpf.op_count)
        return operands.map({ Operand(op: $0) })
    }

    /// Operand for BPF instructions.
    ///
    /// The operand's value can be accessed by the `value` property, or by a property corresponding to the operand's type:
    /// - `register` for `reg` operands.
    /// - `immediateValue` for `imm` operands.
    /// - `offsetValue` for `off` operands.
    /// - `memory` for `mem` operands.
    /// - `scratchIndex` for `mmem` operands.
    /// - `msh` for `msh` operands.
    /// - `extension` for `ext` operands.
    public struct Operand: InstructionOperand {
        internal var op: cs_bpf_op

        /// Operand type.
        public var type: BpfOp { enumCast(op.type) }

        /// Operand value.
        public var value: BpfOperandValue {
            switch type {
            case .reg:
                return register
            case .imm:
                return immediateValue
            case .off:
                return offsetValue
            case .mem:
                return memory
            case .mmem:
                return scratchIndex
            case .msh:
                return msh
            case .ext:
                return `extension`
            default:
                fatalError("Invalid bpf operand type \(type.rawValue)")
            }
        }

        /// Operand access mode.
        public var access: Access { enumCast(op.access) }

        /// Register value for `reg` operand.
        ///
        /// `nil` when not an appropriate operand.
        public var register: BpfReg! {
            guard type == .reg else {
                return nil
            }
            return enumCast(op.reg)
        }

        /// Immediate value for `imm` operand.
        public var immediateValue: UInt64! {
            guard type == .imm else {
                return nil
            }
            return op.imm
        }

        /// Offset value for `off` operand.
        public var offsetValue: UInt32! {
            guard type == .off else {
                return nil
            }
            return op.off
        }

        /// Base/displacement value for `mem` operand.
        public var memory: Memory! {
            guard type == .mem else {
                return nil
            }
            return Memory(base: optionalEnumCast(op.mem.base, ignoring: BPF_REG_INVALID),
                          displacement: op.mem.disp)
        }

        /// Scratch memory index for `mmem` operand.
        public var scratchIndex: UInt32! {
            guard type == .mmem else {
                return nil
            }
            return op.mmem
        }

        /// Value for `msh` operand.
        public var msh: UInt32! {
            guard type == .msh else {
                return nil
            }
            return op.msh
        }

        /// Extension  for `ext` operand.
        public var `extension`: BpfExt! {
            guard type == .ext else {
                return nil
            }
            return optionalEnumCast(op.ext, ignoring: BPF_EXT_INVALID.rawValue)
        }

        /// Instruction's operand referring to memory.
        public struct Memory: BpfOperandValue {
            /// Base register (if applicable).
            public let base: BpfReg?
            /// Displacement.
            public let displacement: UInt32
        }
    }
}

public protocol BpfOperandValue {}
extension BpfReg: BpfOperandValue {}
extension UInt32: BpfOperandValue {}
extension UInt64: BpfOperandValue {}
extension BpfExt: BpfOperandValue {}

extension BpfIns: InstructionType {}
