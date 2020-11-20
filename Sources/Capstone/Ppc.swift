import Ccapstone

extension PowerPCInstruction: OperandContainer {
    /// Branch code for branch instructions.
    ///
    /// `nil` when detail mode is off, or not an appropriate instruction.
    public var branchCode: PpcBc! {
        optionalEnumCast(detail?.ppc.bc, ignoring: PPC_BC_INVALID)
    }

    /// Hint for branch instructions.
    ///
    /// `nil` when detail mode is off, or not an appropriate instruction.
    public var branchHint: PpcBh! {
        optionalEnumCast(detail?.ppc.bh, ignoring: PPC_BH_INVALID)
    }

    /// `true` if this dot instruction updates CR0.
    ///
    /// `nil` when detail mode is off.
    public var updatesCR0: Bool! { detail?.ppc.update_cr0 }

    /// Instruction operands.
    ///
    /// Empty when detail mode is off.
    public var operands: [Operand] {
        let operands: [cs_ppc_op] = readDetailsArray(array: detail?.ppc.operands, size: detail?.ppc.op_count)
        return operands.map({ Operand(op: $0) })
    }

    /// Operand for PowerPC instructions.
    ///
    /// The operand's value can be accessed by the `value` property, or by a property corresponding to the operand's type:
    /// - `register` or `registers` for `reg` operands.
    /// - `immediateValue` for `imm` operands.
    /// - `memory` for `mem` operands.
    /// - `condition` for `crx` operands.
    public struct Operand: InstructionOperand {
        internal var op: cs_ppc_op

        /// Operand type.
        public var type: PpcOp { enumCast(op.type) }

        /// Operand value.
        public var value: PpcOperandValue {
            switch type {
            case .reg:
                return register
            case .imm:
                return immediateValue
            case .mem:
                return memory
            case .crx:
                return condition
            default:
                fatalError("Invalid ppc operand type \(type.rawValue)")
            }
        }

        /// Register value for `reg` operand.
        ///
        /// `nil` when not an appropriate operand.
        public var register: PpcReg! {
            guard type == .reg else { return nil }
            return enumCast(op.reg)
        }

        /// Immediate value for `imm` operand.
        ///
        /// `nil` when not an appropriate operand.
        public var immediateValue: Int64! {
            guard type == .imm else { return nil }
            return op.imm
        }

        /// Base/displacement for `mem` operand.
        ///
        /// `nil` when not an appropriate operand.
        public var memory: Memory! {
            guard type == .mem else { return nil }
            return Memory(op.mem)
        }

        /// Condition for `crx` operand.
        ///
        /// `nil` when not an appropriate operand.
        public var condition: Condition! {
            guard type == .crx else { return nil }
            return Condition(op.crx)
        }

        /// Operand value referring to memory.
        public struct Memory {
            /// Base register.
            public let base: PpcReg?
            /// Displacement value.
            public let displacement: Int32

            init(_ mem: ppc_op_mem) {
                base = optionalEnumCast(mem.base, ignoring: PPC_REG_INVALID)
                displacement = mem.disp
            }
        }

        /// Condition value.
        public struct Condition {
            public let scale: UInt32
            public let register: PpcReg
            public let condition: PpcBc

            init(_ crx: ppc_op_crx) {
                scale = crx.scale
                register = enumCast(crx.reg)
                condition = enumCast(crx.cond)
            }
        }
    }
}

public protocol PpcOperandValue {}
extension PpcReg: PpcOperandValue {}
extension Int64: PpcOperandValue {}
extension PowerPCInstruction.Operand.Memory: PpcOperandValue {}
extension PowerPCInstruction.Operand.Condition: PpcOperandValue {}

extension PpcIns: InstructionType {}
