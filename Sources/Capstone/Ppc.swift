import Ccapstone

extension PowerPCInstruction: OperandContainer {
    /// Branch code for branch instructions
    public var branchCode: PpcBc! {
        optionalEnumCast(detail?.ppc.bc, ignoring: PPC_BC_INVALID)
    }
    
    /// Branch hint for branch instructions
    public var branchHint: PpcBh! {
        optionalEnumCast(detail?.ppc.bh, ignoring: PPC_BH_INVALID)
    }
    
    /// True if this 'dot' insn updates CR0
    public var updatesCR0: Bool! { detail?.ppc.update_cr0 }
    
    public var operands: [Operand] {
        let operands: [cs_ppc_op] = readDetailsArray(array: detail?.ppc.operands, size: detail?.ppc.op_count)
        return operands.map({ Operand(op: $0) })
    }

    public struct Operand: InstructionOperand {
        internal var op: cs_ppc_op
        
        public var type: PpcOp { enumCast(op.type) }
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
        
        /// Register value for register operand
        public var register: PpcReg! {
            guard type == .reg else { return nil }
            return enumCast(op.reg)
        }
        
        /// Immediate value for immediate operand
        public var immediateValue: Int64! {
            guard type == .imm else { return nil }
            return op.imm
        }
                
        /// Base/displacement for memory operand
        public var memory: Memory! {
            guard type == .mem else { return nil }
            return Memory(op.mem)
        }
                
        /// Operand with condition register
        public var condition: Condition! {
            guard type == .crx else { return nil }
            return Condition(op.crx)
        }
        
        /// Instruction's operand referring to memory
        public struct Memory {
            /// Base register
            public let base: PpcReg?
            public let displacement: Int32
            
            init(_ mem: ppc_op_mem) {
                base = optionalEnumCast(mem.base, ignoring: PPC_REG_INVALID)
                displacement = mem.disp
            }
        }
        
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
