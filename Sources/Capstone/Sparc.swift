import Ccapstone

extension SparcInstruction: OperandContainer {
    public var operands: [Operand] {
        let operands: [cs_sparc_op] = readDetailsArray(array: detail?.sparc.operands, size: detail?.sparc.op_count)
        return operands.map({ Operand(op: $0) })
    }

    /// Condition code
    public var conditionCode: SparcCc! { optionalEnumCast(detail?.sparc.cc, ignoring: SPARC_CC_INVALID) }

    /// Hints
    public var hint: SparcHint! { optionalEnumCast(detail?.sparc.hint) }

    public struct Operand: InstructionOperand {
        internal let op: cs_sparc_op

        public var type: SparcOp { enumCast(op.type) }

        public var value: SparcOperandValue {
            switch type {
            case .reg:
                return register
            case .imm:
                return immediateValue
            case .mem:
                return memory
            default:
                fatalError("Invalid sparc operand type \(type.rawValue)")
            }
        }

        /// Register value for reg operand
        public var register: SparcReg! {
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

        /// Base/index/disp value for mem operand
        public var memory: Memory! {
            guard type == .mem else {
                return nil
            }
            return Memory(op.mem)
        }

        /// Instruction's operand referring to memory
        public struct Memory {
            public let base: SparcReg
            public let index: SparcReg?
            /// displacement/offset value
            public let displacement: Int32

            init(_ mem: sparc_op_mem) {
                base = enumCast(mem.base)
                index = optionalEnumCast(mem.index, ignoring: 0)
                displacement = mem.disp
            }
        }
    }
}

public protocol SparcOperandValue {}
extension SparcReg: SparcOperandValue {}
extension Int64: SparcOperandValue {}
extension SparcInstruction.Operand.Memory: SparcOperandValue {}

extension SparcIns: InstructionType {}
