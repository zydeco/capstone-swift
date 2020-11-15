import Ccapstone

extension XCoreInstruction: OperandContainer {
    public var operands: [Operand] {
        let operands: [cs_xcore_op] = readDetailsArray(array: detail?.xcore.operands, size: detail?.xcore.op_count)
        return operands.map({ Operand(op: $0) })
    }
    
    /// Instruction operand
    public struct Operand: InstructionOperand {
        internal let op: cs_xcore_op
        
        public var type: XcoreOp { enumCast(op.type) }

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
        
        /// Register value for register operand
        public var register: XcoreReg! {
            guard type == .reg else {
                return nil
            }
            return enumCast(op.reg)
        }
        
        /// Immediate value for immediate operand
        public var immediateValue: Int32! {
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
                index: optionalEnumCast(op.mem.index, ignoring: UInt8(XCORE_REG_INVALID.rawValue)),
                displacement: op.mem.disp,
                direction: numericCast(op.mem.direct))
        }
        
        /// Instruction's operand referring to memory
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
