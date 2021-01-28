import Ccapstone

extension RiscvInstruction: OperandContainer {
    /// Instruction operands.
    ///
    /// Empty when detail mode is off.
    public var operands: [Operand] {
        let operands: [cs_riscv_op] = readDetailsArray(array: detail?.riscv.operands, size: detail?.riscv.op_count)
        return operands.map({ Operand(op: $0) })
    }

    /// Operand for RISCV instructions.
    ///
    /// The operand's value can be accessed by the `value` property, or by a property corresponding to the operand's type:
    /// - `register` for `reg` operands.
    /// - `immediateValue` for `imm` operands.
    /// - `memory` for `mem` operands.
    public struct Operand: InstructionOperand {
        internal var op: cs_riscv_op

        /// Operand type.
        public var type: RiscvOp { enumCast(op.type) }

        /// Operand value.
        public var value: RiscvOperandValue {
            switch type {
            case .reg:
                return register
            case .imm:
                return immediateValue
            case .mem:
                return memory
            default:
                fatalError("Invalid riscv operand type \(type.rawValue)")
            }
        }

        /// Register value for `reg` operand.
        ///
        /// `nil` when not an appropriate operand.
        public var register: RiscvReg! {
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
        public struct Memory: RiscvOperandValue {
            /// Base register.
            public let base: RiscvReg
            /// Displacement/offset value.
            public let displacement: Int64

            init(_ mem: riscv_op_mem) {
                base = enumCast(mem.base)
                displacement = mem.disp
            }
        }
    }
}

public protocol RiscvOperandValue {}
extension RiscvReg: RiscvOperandValue {}
extension Int64: RiscvOperandValue {}

extension RiscvIns: InstructionType {}
