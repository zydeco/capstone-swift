import Ccapstone

extension MipsInstruction: OperandContainer {
    public var operands: [Operand] {
        let operands: [cs_mips_op] = readDetailsArray(array: detail?.mips.operands, size: detail?.mips.op_count)
        return operands.map({ Operand(op: $0) })
    }

    public struct Operand: InstructionOperand {
        internal let op: cs_mips_op

        public var type: MipsOp { enumCast(op.type) }

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

        /// Register value for reg operand
        public var register: MipsReg! {
            guard type == .reg else {
                return nil
            }
            return enumCast(op.reg)
        }

        /// Immediate value for imm operand
        public var immediateValue: Int64! {
            guard type == .imm else {
                return nil
            }
            return op.imm
        }

        /// Base/displacement value for mem operand
        public var memory: Memory! {
            guard type == .mem else {
                return nil
            }
            return Memory(op.mem)
        }

        /// Instruction's operand referring to memory
        public struct Memory {
            /// base register
            public let base: MipsReg
            /// displacement/offset value
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
