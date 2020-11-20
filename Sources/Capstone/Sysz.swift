import Ccapstone

extension SystemZInstruction: OperandContainer {
    /// Instruction operands.
    ///
    /// Empty when detail mode is off.
    public var operands: [Operand] {
        let operands: [cs_sysz_op] = readDetailsArray(array: detail?.sysz.operands, size: detail?.sysz.op_count)
        return operands.map({ Operand(op: $0) })
    }

    /// Condition code.
    ///
    /// `nil` when detail mode is off, or instruction has no condition code.
    public var conditionCode: SyszCc! { optionalEnumCast(detail?.sysz.cc, ignoring: SYSZ_CC_INVALID) }

    /// Operand for SystemZ instructions.
    ///
    /// The operand's value can be accessed by the `value` property, or by a property corresponding to the operand's type:
    /// - `register` or `registers` for `reg` operands.
    /// - `immediateValue` for `imm` operands.
    /// - `memory` for `mem` operands.
    public struct Operand: InstructionOperand {
        internal let op: cs_sysz_op

        /// Operand type.
        public var type: SyszOp { enumCast(op.type) }

        /// Operand value
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

        /// Register value for `reg` operand.
        ///
        /// `nil` when not an appropriate operand.
        public var register: SyszReg! {
            guard type == .reg else {
                return nil
            }
            return enumCast(op.reg)
        }

        /// Access register for `acreg` operand.
        ///
        /// `nil` when not an appropriate operand.
        public var accessRegister: UInt8! {
            return numericCast(op.reg.rawValue)
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

        /// Base/index/length/displacement value for memory operand.
        ///
        /// `nil` when not an appropriate operand.
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

        /// Operand value referring to memory.
        public struct Memory {
            public let base: SyszReg
            public let index: SyszReg?
            /// BDLAddr operand.
            public let length: UInt64
            /// displacement/offset value.
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
