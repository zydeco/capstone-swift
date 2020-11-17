import Ccapstone

extension SystemZInstruction: OperandContainer {
    public var operands: [Operand] {
        let operands: [cs_sysz_op] = readDetailsArray(array: detail?.sysz.operands, size: detail?.sysz.op_count)
        return operands.map({ Operand(op: $0) })
    }

    /// Condition code
    public var conditionCode: SyszCc! { optionalEnumCast(detail?.sysz.cc, ignoring: SYSZ_CC_INVALID) }

    /// Instruction operand
    public struct Operand: InstructionOperand {
        internal let op: cs_sysz_op

        public var type: SyszOp { enumCast(op.type) }

        public var value: SyszOperandValue {
            switch type {
            case .imm:
                return immediateValue
            case .reg:
                return register
            case .acreg:
                return accessRegister
            case .mem:
                return memory
            default:
                fatalError("Invalid sysz operand type \(type.rawValue)")
            }
        }

        /// Register value for register operand
        public var register: SyszReg! {
            guard type == .reg else {
                return nil
            }
            return enumCast(op.reg)
        }

        /// Access register for acreg operand
        public var accessRegister: UInt8! {
            return numericCast(op.reg.rawValue)
        }

        /// Immediate value for immediate operand
        public var immediateValue: Int64! {
            guard type == .imm else {
                return nil
            }
            return op.imm
        }

        public var memory: Memory! {
            guard type == .mem else {
                return nil
            }
            return Memory(
                base: enumCast(op.mem.base),
                index: optionalEnumCast(op.mem.index, ignoring: UInt8(SYSZ_REG_INVALID.rawValue)),
                length: op.mem.length,
                displacement: op.mem.disp)
        }

        /// Instruction's operand referring to memory
        public struct Memory {
            public let base: SyszReg
            public let index: SyszReg?
            /// BDLAddr operand
            public let length: UInt64
            /// displacement/offset value
            public let displacement: Int64
        }
    }
}

public protocol SyszOperandValue {}
extension SyszReg: SyszOperandValue {}
extension Int64: SyszOperandValue {}
extension UInt8: SyszOperandValue {}
extension SystemZInstruction.Operand.Memory: SyszOperandValue {}

extension SyszIns: InstructionType {}
