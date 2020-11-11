import Ccapstone

extension ArmInstruction: OperandContainer {
    public var operands: [ArmOperand] {
        let operands: [cs_arm_op] = readDetailsArray(array: detail?.arm.operands, size: detail?.arm.op_count, maxSize: 36)
        return operands.map({ ArmOperand(op: $0) })
    }
    
    /// User-mode registers to be loaded (for LDM/STM instructions).
    /// nil when detail mode is off
    public var usermode: Bool! { detail?.arm.usermode }
    
    /// Scalar size for vector instructions
    /// nil when detail mode is off
    public var vectorSize: Int! { optionalNumericCast(detail?.arm.vector_size) }
    
    /// Data type for elements of vector instructions
    /// nil when detail mode is off, or wrong instruction
    public var vectorDataType: ArmVectordata! {
        guard let value = detail?.arm.vector_data, value != ARM_VECTORDATA_INVALID else {
            return nil
        }
        return enumCast(value)
    }
    
    /// CPS mode for CPS instruction
    /// nil when detail mode is off, or wrong instruction
    public var cpsMode: (mode: ArmCpsmode, flag: ArmCpsflag)! {
        guard let mode = detail?.arm.cps_mode, mode != ARM_CPSMODE_INVALID,
              let flag = detail?.arm.cps_flag, flag != ARM_CPSFLAG_INVALID else {
            return nil
        }
        return (enumCast(mode), enumCast(flag))
    }
    
    /// Condition code
    /// nil when detail mode is off, or instruction has no condition code
    public var conditionCode: ArmCc! {
        guard let cc = detail?.arm.cc, cc != ARM_CC_INVALID else {
            return nil
        }
        return enumCast(cc)
    }
    
    /// Does this instruction update flags?
    /// nil when detail mode is off
    public var updatesFlags: Bool! { detail?.arm.update_flags }
    
    /// Does this instruction write-back?
    /// nil when detail mode is off
    public var writeBack: Bool! { detail?.arm.writeback }
    
    /// Option for some memory barrier instructions
    /// nil when detail mode is off, or wrong instruction
    public var memoryBarrier: ArmMb! {
        guard let mb = detail?.arm.mem_barrier, mb != ARM_MB_INVALID else {
            return nil
        }
        return enumCast(mb)
    }
}

public struct ArmOperand: InstructionOperand, CustomStringConvertible {
    internal var op: cs_arm_op
    
    public typealias OperandType = ArmOp
    public var type: ArmOp { enumCast(op.type) }
    public var access: Access { enumCast(op.access) }
    
    /// Vector Index for some vector operands
    public var vectorIndex: Int! {
        guard op.vector_index != -1 else {
            return nil
        }
        return numericCast(op.vector_index)
    }
    
    /// Operand shift
    public var shift: Shift? {
        guard op.shift.type != ARM_SFT_INVALID else {
            return nil
        }
        return Shift(op.shift)
    }
    
    /// In some instructions, an operand can be subtracted or added to the base register
    public var subtracted: Bool { op.subtracted }
    
    /// Neon lane index for NEON instructions
    public var neonLane: Int! {
        guard op.neon_lane != -1 else {
            return nil
        }
        return numericCast(op.neon_lane)
    }
    
    /// Register value for register operand
    public var register: ArmReg! {
        guard type == .reg else { return nil }
        return enumCast(op.reg)
    }
    
    /// Register value for system register operand
    public var systemRegister: ArmSysreg! {
        guard type == .sysreg else { return nil }
        return enumCast(op.reg)
    }
    
    /// Immediate value for C-IMM, P-IMM or IMM operand
    public var immediateValue: Int32! {
        guard type.immediate else { return nil }
        return op.imm
    }
    
    /// Floating point value for FP operand
    public var doubleValue: Double! {
        guard type == .fp else { return nil }
        return op.fp
    }
    
    /// Base/index/scale/disp value for memory operand
    public var memory: ArmOperandMemory! {
        guard type == .mem else { return nil }
        return ArmOperandMemory(
            base: enumCast(op.mem.base),
            index: op.mem.index == ARM_REG_INVALID ? nil : enumCast(op.mem.index),
            scale: op.mem.scale == 1 ? .plus : .minus,
            displacement: numericCast(op.mem.disp)
        )
    }
    
    /// Operand type for SETEND instruction
    public var setend: ArmSetend! {
        guard type == .setend else { return nil }
        return enumCast(op.setend)
    }
    
    /// Operand value
    public var value: ArmOperandValue {
        switch type {
        case .reg:
            return register
        case .sysreg:
            return systemRegister
        case .imm, .cimm, .pimm:
            return immediateValue
        case .fp:
            return doubleValue
        case .mem:
            return memory
        case .setend:
            return setend
        default:
            // this shouldn't happen
            return 0
        }
    }
    
    public var description: String {
        "\(type)<\(value)>"
    }
    
    public enum Shift {
        public enum Direction: UInt8 {
            /// Arithmetic Shift Right
            case asr = 1
            /// Logical Shift Left
            case lsl = 2
            /// Logical Shift Right
            case lsr = 3
            /// ROtate Right
            case ror = 4
            /// Rotate Right with eXtend
            case rrx = 5
        }
        
        case immediate(direction: Direction, value: UInt)
        case register(direction: Direction, register: ArmReg)
        
        init(_ shift: cs_arm_op.__Unnamed_struct_shift) {
            switch shift.type.rawValue {
            case ARM_SFT_LSL.rawValue...ARM_SFT_RRX.rawValue:
                self = .immediate(direction: enumCast(shift.type), value: numericCast(shift.value))
            case ARM_SFT_LSL_REG.rawValue...ARM_SFT_RRX_REG.rawValue:
                self = .register(direction: enumCast(shift.type.rawValue - 5), register: enumCast(shift.value))
            default:
                self = .immediate(direction: .lsl, value: 0)
            }
        }
    }
}

public protocol ArmOperandValue {}
extension ArmReg: ArmOperandValue {}
extension ArmSysreg: ArmOperandValue {}
extension Int32: ArmOperandValue {}
extension Double: ArmOperandValue {}
extension ArmOperandMemory: ArmOperandValue {}
extension ArmSetend: ArmOperandValue {}

extension ArmOp {
    var immediate: Bool {
        self == .cimm || self == .pimm || self == .imm
    }
}

public struct ArmOperandMemory {
    public let base: ArmReg
    public let index: ArmReg?
    public let scale: FloatingPointSign
    public let displacement: Int
}

