import Ccapstone

extension Arm64Instruction: OperandContainer {
    /// Condition code.
    ///
    /// `nil` when detail mode is off, or instruction has no condition code.
    public var conditionCode: Arm64Cc! {
        optionalEnumCast(detail?.arm64.cc, ignoring: ARM64_CC_INVALID)
    }

    /// Does this instruction update flags?
    ///
    /// `nil` when detail mode is off.
    public var updatesFlags: Bool! { detail?.arm64.update_flags }

    /// Does this instruction write-back?
    ///
    /// `nil` when detail mode is off.
    public var writeBack: Bool! { detail?.arm64.writeback }

    /// Instruction operands.
    ///
    /// Empty when detail mode is off.
    public var operands: [Operand] {
        let operands: [cs_arm64_op] = readDetailsArray(array: detail?.arm64.operands, size: detail?.arm64.op_count)
        return operands.map({ Operand(op: $0, ins: instruction) })
    }

    /// Operand for Arm64 instructions.
    ///
    /// The operand's value can be accessed by the `value` property, or by a property corresponding to the operand's type:
    /// - `register` for `reg` operands.
    /// - `systemRegister` for `regMrs` or `regMsr` operands, or `sys` operands of `mrs` or `msr` instructions.
    /// - `immediateValue` for `imm` or `cimm` operands.
    /// - `doubleValue` for `fp` operands.
    /// - `memory` for `mem` operands.
    /// - `pState` for `pstate` operands.
    /// - `ic`, `dc`, `at` or `tlbi` for `sys` operands of those instructions.
    /// - `prefetch` for `prefetch` operands
    /// - `barrier` for `barrier` operands
    public struct Operand: InstructionOperand {
        internal var op: cs_arm64_op
        internal var ins: Arm64Ins

        /// Operand type.
        public var type: Arm64Op { enumCast(op.type) }

        /// Operand access mode.
        public var access: Access { enumCast(op.access) }

        /// Vector Index for some vector operands.
        ///
        /// `nil` if not applicable.
        public var vectorIndex: Int! {
            guard op.vector_index != -1 else {
                return nil
            }
            return numericCast(op.vector_index)
        }

        /// Vector Arrangement Specifier.
        ///
        /// `nil` if not applicable.
        public var vectorArrangementSpecifier: Arm64Vas! {
            optionalEnumCast(op.vas, ignoring: ARM64_VAS_INVALID)
        }

        /// Vector Element Size Specifier
        public var vectorElementSizeSpecifier: Arm64Vess! {
            optionalEnumCast(op.vess, ignoring: ARM64_VESS_INVALID)
        }

        /// Shift for this operand.
        ///
        /// `nil` if not applicable.
        public var shift: (type: Arm64Sft, value: UInt)! {
            guard op.shift.type != ARM64_SFT_INVALID else {
                return nil
            }
            return (type: enumCast(op.shift.type), value: numericCast(op.shift.value))
        }

        /// Extender type of this operand.
        ///
        /// `nil` if not applicable.
        public var extender: Arm64Ext! {
            optionalEnumCast(op.ext, ignoring: ARM64_EXT_INVALID)
        }

        /// Operand value.
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
                return prefetch
            case .barrier:
                return barrier
            default:
                // this shouldn't happen
                fatalError("Invalid arm64 operand type \(type.rawValue)")
            }
        }

        /// Register value for `reg` operand.
        ///
        /// `nil` when not an appropriate operand.
        public var register: Arm64Reg! {
            guard type == .reg else {
                return nil
            }
            return enumCast(op.reg)
        }

        /// System register value for `regMrs`, `regMsr` and some `sys` operands.
        ///
        /// `nil` when not an appropriate operand.
        public var systemRegister: Arm64Sysreg! {
            guard type == .regMrs || type == .regMsr else {
                return nil
            }
            return enumCast(op.reg)
        }

        /// Immediate register value for `imm` or `cimm` operands.
        ///
        /// `nil` when not an appropriate operand.
        public var immediateValue: Int64! {
            guard type == .imm || type == .cimm else {
                return nil
            }
            return op.imm
        }

        /// Floating point value for `fp` operand.
        ///
        /// `nil` when not an appropriate operand.
        public var doubleValue: Double! {
            guard type == .fp else {
                return nil
            }
            return op.fp
        }

        /// Base/index/displacement value for `mem` operand.
        ///
        /// `nil` when not an appropriate operand.
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

        /// PState field of MSR instruction (`pstate` operand).
        ///
        /// `nil` when not an appropriate operand.
        public var pState: Arm64Pstate! {
            guard type == .pstate else {
                return nil
            }
            return enumCast(op.pstate)
        }

        /// PRFM operation (`prefetch` operand).
        ///
        /// `nil` when not an appropriate operand.
        public var prefetch: Arm64Prfm! {
            guard type == .prefetch else {
                return nil
            }
            return enumCast(op.prefetch)
        }

        /// Memory barrier operation (`barrier` operand of ISB/DMB/DSB instructions).
        ///
        /// `nil` when not an appropriate operand.
        public var barrier: Arm64Barrier! {
            guard type == .barrier else {
                return nil
            }
            return enumCast(op.barrier)
        }

        /// Operand for IC operation.
        ///
        /// `nil` when not an appropriate operand.
        public var ic: Arm64Ic! {
            guard type == .sys && ins == .ic else {
                return nil
            }
            return enumCast(op.sys)
        }

        /// Operand for DC operation.
        ///
        /// `nil` when not an appropriate operand.
        public var dc: Arm64Dc! {
            guard type == .sys && ins == .dc else {
                return nil
            }
            return enumCast(op.sys)
        }

        /// Operand for AT operation.
        ///
        /// `nil` when not an appropriate operand.
        public var at: Arm64At! {
            guard type == .sys && ins == .at else {
                return nil
            }
            return enumCast(op.sys)
        }

        /// Operand for TLBI operation.
        ///
        /// `nil` when not an appropriate operand.
        public var tlbi: Arm64Tlbi! {
            guard type == .sys && ins == .tlbi else {
                return nil
            }
            return enumCast(op.sys)
        }

        /// Operand value referring to memory.
        public struct Memory {
            /// Base register.
            public let base: Arm64Reg
            /// Index register, if any.
            public let index: Arm64Reg?
            /// Displacement/offset value.
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
extension Arm64Prfm: Arm64OperandValue {}

extension Arm64Ins: InstructionType {}
