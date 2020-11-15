import Ccapstone

extension Arm64Instruction: OperandContainer {
    /// Condition code
    /// nil when detail mode is off, or instruction has no condition code
    public var conditionCode: Arm64Cc! {
        optionalEnumCast(detail?.arm64.cc, ignoring: ARM64_CC_INVALID)
    }
    
    /// Does this instruction update flags?
    /// nil when detail mode is off
    public var updatesFlags: Bool! { detail?.arm64.update_flags }
    
    /// Does this instruction write-back?
    /// nil when detail mode is off
    public var writeBack: Bool! { detail?.arm64.writeback }
    
    public var operands: [Operand] {
        let operands: [cs_arm64_op] = readDetailsArray(array: detail?.arm64.operands, size: detail?.arm64.op_count)
        return operands.map({ Operand(op: $0, ins: instruction) })
    }
    
    public struct Operand: InstructionOperand {
        internal var op: cs_arm64_op
        internal var ins: Arm64Ins

        public var type: Arm64Op { enumCast(op.type) }
        
        /// Operand access mode
        public var access: Access { enumCast(op.access) }
        
        /// Vector Index for some vector operands
        public var vectorIndex: Int! {
            guard op.vector_index != -1 else {
                return nil
            }
            return numericCast(op.vector_index)
        }
        
        /// Vector Arrangement Specifier
        public var vectorArrangementSpecifier: Arm64Vas! {
            optionalEnumCast(op.vas, ignoring: ARM64_VAS_INVALID)
        }
        
        /// Vector Element Size Specifier
        public var vectorElementSizeSpecifier: Arm64Vess! {
            optionalEnumCast(op.vess, ignoring: ARM64_VESS_INVALID)
        }
        
        /// Shift for this operand
        public var shift: (type: Arm64Sft, value: UInt)! {
            guard op.shift.type != ARM64_SFT_INVALID else {
                return nil
            }
            return (type: enumCast(op.shift.type), value: numericCast(op.shift.value))
        }
        
        /// Extender type of this operand
        public var extender: Arm64Ext! {
            optionalEnumCast(op.ext, ignoring: ARM64_EXT_INVALID)
        }
        
        /// Operand value
        public var value: Arm64OperandValue {
            switch type {
            case .reg:
                return register
            case .imm, .cimm:
                return immediateValue
            case .mem:
                return memory
            case .fp:
                return doubleValue
            case .regMrs, .regMsr:
                return systemRegister
            case .pstate:
                return pState
            case .sys:
                switch ins {
                case .ic:
                    return ic
                case .dc:
                    return dc
                case .at:
                    return at
                case .tlbi:
                    return tlbi
                default:
                    fatalError("Invalid arm64 instruction for type sys: \(ins.rawValue)")
                }
            case .prefetch:
                return pState
            case .barrier:
                return barrier
            default:
                // this shouldn't happen
                fatalError("Invalid arm64 operand type \(type.rawValue)")
            }
            return Int64(0)
        }
        
        /// Register value for REG operand
        public var register: Arm64Reg! {
            guard type == .reg else {
                return nil
            }
            return enumCast(op.reg)
        }
        
        /// System register for REG_MRS and REG_MSR operands
        public var systemRegister: Arm64Sysreg! {
            guard type == .regMrs || type == .regMsr else {
                return nil
            }
            return enumCast(op.reg)
        }
        
        /// Immediate value, or index for C-IMM or IMM operand
        public var immediateValue: Int64! {
            guard type == .imm || type == .cimm else {
                return nil
            }
            return op.imm
        }
        
        /// Floating point value for FP operand
        public var doubleValue: Double! {
            guard type == .fp else {
                return nil
            }
            return op.fp
        }
        
        /// base/index/displacement value for MEM operand.
        public var memory: Memory! {
            guard type == .mem else {
                return nil
            }
            return Memory(
                base: enumCast(op.mem.base),
                index: optionalEnumCast(op.mem.index, ignoring: ARM64_REG_INVALID),
                displacement: op.mem.disp
            )
        }
        
        /// PState field of MSR instruction.
        public var pState: Arm64Pstate! {
            guard type == .pstate else {
                return nil
            }
            return enumCast(op.pstate)
        }
        
        /// PRFM operation.
        public var prefetch: Arm64Prfm! {
            guard type == .prefetch else {
                return nil
            }
            return enumCast(op.prefetch)
        }
        
        /// Memory barrier operation (ISB/DMB/DSB instructions).
        public var barrier: Arm64Barrier! {
            guard type == .barrier else {
                return nil
            }
            return enumCast(op.barrier)
        }
        
        /// Operand for IC operation
        public var ic: Arm64Ic! {
            guard type == .sys && ins == .ic else {
                return nil
            }
            return enumCast(op.sys)
        }
        
        /// Operand for DC operation
        public var dc: Arm64Dc! {
            guard type == .sys && ins == .dc else {
                return nil
            }
            return enumCast(op.sys)
        }
        
        /// Operand for AT operation
        public var at: Arm64At! {
            guard type == .sys && ins == .at else {
                return nil
            }
            return enumCast(op.sys)
        }
        
        /// Operand for TLBI operation
        public var tlbi: Arm64Tlbi! {
            guard type == .sys && ins == .tlbi else {
                return nil
            }
            return enumCast(op.sys)
        }
        
        /// Instruction's operand referring to memory
        public struct Memory {
            /// Base register
            public let base: Arm64Reg
            /// Index register
            public let index: Arm64Reg?
            /// Displacement/offset value
            public let displacement: Int32
        }
    }
}

public protocol Arm64OperandValue {}
extension Arm64Reg: Arm64OperandValue {}
extension Arm64Sysreg: Arm64OperandValue {}
extension Int64: Arm64OperandValue {}
extension Double: Arm64OperandValue {}
extension Arm64Instruction.Operand.Memory: Arm64OperandValue {}
extension Arm64Pstate: Arm64OperandValue {}
extension Arm64Barrier: Arm64OperandValue {}
extension Arm64Ic: Arm64OperandValue {}
extension Arm64Dc: Arm64OperandValue {}
extension Arm64At: Arm64OperandValue {}
extension Arm64Tlbi: Arm64OperandValue {}

extension Arm64Ins: InstructionType {}
