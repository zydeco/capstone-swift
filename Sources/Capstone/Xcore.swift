import Ccapstone

extension XCoreInstruction: OperandContainer {
    /// Instruction operands.
    ///
    /// Empty when detail mode is off.
    public var operands: [Operand] {
        let operands: [cs_xcore_op] = readDetailsArray(array: detail?.xcore.operands, size: detail?.xcore.op_count)
        return operands.map({ Operand(op: $0) })
    }

    /// Operand for XCore instructions.
    ///
    /// The operand's value can be accessed by the `value` property, or by a property corresponding to the operand's type:
    /// - `register` for `reg` operands.
    /// - `immediateValue` for `imm` operands.
    /// - `memory` for `mem` operands.
    public struct Operand: InstructionOperand {
        internal let op: cs_xcore_op

        /// Operand type.
        public var type: XcoreOp { enumCast(op.type) }

        /// Operand value.
        public var value: XcoreOperandValue {
            switch type {
            case .imm:
                return immediateValue
            case .reg:
                return register
            case .mem:
                return memory
            default:
                fatalError("Invalid xcore operand type \(type.rawValue)")
            }
        }

        /// Register value for `reg` operand.
        ///
        /// `nil` when not an appropriate operand.
        public var register: XcoreReg! {
            guard type == .reg else {
                return nil
            }
            return enumCast(op.reg)
        }

        /// Immediate value for `imm` operand.
        ///
        /// `nil` when not an appropriate operand.
        public var immediateValue: Int32! {
            guard type == .imm else {
                return nil
            }
            return op.imm
        }

        /// Memory values for `mem` operand.
        ///
        /// `nil` when not an appropriate operand.
        public var memory: Memory! {
            guard type == .mem else {
                return nil
            }
            return Memory(
                base: enumCast(op.mem.base),
                index: optionalEnumCast(op.mem.index, ignoring: UInt8(XCORE_REG_INVALID.rawValue)),
                displacement: op.mem.disp,
                direction: numericCast(op.mem.direct))
        }

        /// Operand referring to memory
        public struct Memory {
            public let base: XcoreReg
            public let index: XcoreReg?
            /// displacement/offset value
            public let displacement: Int32
            /// +1: forward, -1: backward
            public let direction: Int
        }
    }
}

public protocol XcoreOperandValue {}
extension XcoreReg: XcoreOperandValue {}
extension Int32: XcoreOperandValue {}
extension XCoreInstruction.Operand.Memory: XcoreOperandValue {}

extension XcoreIns: InstructionType {}
