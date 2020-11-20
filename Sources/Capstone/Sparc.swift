import Ccapstone

extension SparcInstruction: OperandContainer {
    /// Instruction operands.
    ///
    /// Empty when detail mode is off.
    public var operands: [Operand] {
        let operands: [cs_sparc_op] = readDetailsArray(array: detail?.sparc.operands, size: detail?.sparc.op_count)
        return operands.map({ Operand(op: $0) })
    }

    /// Condition code.
    ///
    /// `nil` when detail mode is off.
    public var conditionCode: SparcCc! { optionalEnumCast(detail?.sparc.cc, ignoring: SPARC_CC_INVALID) }

    /// Hints.
    ///
    /// `nil` when detail mode is off.
    public var hint: SparcHint! { optionalEnumCast(detail?.sparc.hint) }

    /// Operand for SPARC instructions.
    ///
    /// The operand's value can be accessed by the `value` property, or by a property corresponding to the operand's type:
    /// - `register` or `registers` for `reg` operands.
    /// - `immediateValue` for `imm` operands.
    /// - `memory` for `mem` operands.
    public struct Operand: InstructionOperand {
        internal let op: cs_sparc_op

        /// Operand type.
        public var type: SparcOp { enumCast(op.type) }

        /// Operand value.
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

        /// Register value for `reg` operand.
        ///
        /// `nil` when not an appropriate operand.
        public var register: SparcReg! {
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

        /// Base/index/displacement value for `mem` operand.
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
            public let base: SparcReg
            public let index: SparcReg?
            /// displacement/offset value.
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
