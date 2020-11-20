import Ccapstone

extension MipsInstruction: OperandContainer {
    /// Instruction operands.
    ///
    /// Empty when detail mode is off.
    public var operands: [Operand] {
        let operands: [cs_mips_op] = readDetailsArray(array: detail?.mips.operands, size: detail?.mips.op_count)
        return operands.map({ Operand(op: $0) })
    }

    /// Operand for MIPS instructions.
    ///
    /// The operand's value can be accessed by the `value` property, or by a property corresponding to the operand's type:
    /// - `register` or `registers` for `reg` operands.
    /// - `immediateValue` for `imm` operands.
    /// - `memory` for `memory` operands.
    public struct Operand: InstructionOperand {
        internal let op: cs_mips_op

        /// Operand type.
        public var type: MipsOp { enumCast(op.type) }

        /// Operand value.
        public var value: MipsOperandValue {
            switch type {
            case .imm:
                return immediateValue
            case .reg:
                return register
            case .mem:
                return memory
            default:
                fatalError("Invalid mips operand type \(type.rawValue)")
            }
        }

        /// Register value for `reg` operand.
        ///
        /// `nil` when not an appropriate operand.
        public var register: MipsReg! {
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

        /// Base/displacement value for `mem` operand.
        ///
        /// `nil` when not an appropriate operand.
        public var memory: Memory! {
            guard type == .mem else {
                return nil
            }
            return Memory(op.mem)
        }

        /// Operand value referring to memory.
        public struct Memory {
            /// Base register.
            public let base: MipsReg
            /// Displacement/offset value.
            public let displacement: Int64

            init(_ mem: mips_op_mem) {
                base = enumCast(mem.base)
                displacement = mem.disp
            }
        }
    }
}

public protocol MipsOperandValue {}
extension MipsReg: MipsOperandValue {}
extension Int64: MipsOperandValue {}
extension MipsInstruction.Operand.Memory: MipsOperandValue {}

extension MipsIns: InstructionType {}
