import Ccapstone

extension ArmInstruction: OperandContainer {
    public var operands: [ArmOperand] {
        let operands: [cs_arm_op] = readDetailsArray(array: detail?.arm.operands, size: detail?.arm.op_count, maxSize: 36)
        return operands.map({ ArmOperand(op: $0) })
    }
    
    /// User-mode registers to be loaded (for LDM/STM instructions).
    /// nil when detail mode is off
    var usermode: Bool! { detail?.arm.usermode }
    
    /// Scalar size for vector instructions
    /// nil when detail mode is off
    var vectorSize: Int! { optionalNumericCast(detail?.arm.vector_size) }
    
    /// Data type for elements of vector instructions
    /// nil when detail mode is off, or wrong instruction
    var vectorDataType: ArmVectordata! {
        guard let value = detail?.arm.vector_data, value != ARM_VECTORDATA_INVALID else {
            return nil
        }
        return enumCast(value)
    }
    
    /// CPS mode for CPS instruction
    /// nil when detail mode is off, or wrong instruction
    var cpsMode: (mode: ArmCpsmode, flag: ArmCpsflag)! {
        guard let mode = detail?.arm.cps_mode, mode != ARM_CPSMODE_INVALID,
              let flag = detail?.arm.cps_flag, flag != ARM_CPSFLAG_INVALID else {
            return nil
        }
        return (enumCast(mode), enumCast(flag))
    }
    
    /// Condition code
    /// nil when detail mode is off, or instruction has no condition code
    var conditionCode: ArmCc! {
        guard let cc = detail?.arm.cc, cc != ARM_CC_INVALID else {
            return nil
        }
        return enumCast(cc)
    }
    
    /// Does this instruction update flags?
    /// nil when detail mode is off
    var updatesFlags: Bool! { detail?.arm.update_flags }
    
    /// Does this instruction write-back?
    /// nil when detail mode is off
    var writeBack: Bool! { detail?.arm.writeback }
    
    /// Option for some memory barrier instructions
    /// nil when detail mode is off, or wrong instruction
    var memoryBarrier: ArmMb! {
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
    var vectorIndex: Int! {
        guard op.vector_index != -1 else {
            return nil
        }
        return numericCast(op.vector_index)
    }
    
    /// Instruction shift
    var shift: ArmOperandShift? {
        guard op.shift.type != ARM_SFT_INVALID else {
            return nil
        }
        return (enumCast(op.shift.type), numericCast(op.shift.value))
    }
    
    /// In some instructions, an operand can be subtracted or added to the base register
    var subtracted: Bool { op.subtracted }
    
    /// Neon lane index for NEON instructions
    var neonLane: Int! {
        guard op.neon_lane != -1 else {
            return nil
        }
        return numericCast(op.neon_lane)
    }
    
    /// Register value for register operand
    var register: ArmReg! {
        guard type == .reg else { return nil }
        return enumCast(op.reg)
    }
    
    /// Register value for system register operand
    var systemRegister: ArmSysreg! {
        guard type == .sysreg else { return nil }
        return enumCast(op.reg)
    }
    
    /// Immediate value for C-IMM, P-IMM or IMM operand
    var immediateValue: Int32! {
        guard type.immediate else { return nil }
        return op.imm
    }
    
    /// Floating point value for FP operand
    var doubleValue: Double! {
        guard type == .fp else { return nil }
        return op.fp
    }
    
    /// Base/index/scale/disp value for memory operand
    var memory: ArmOperandMemory! {
        guard type == .mem else { return nil }
        return ArmOperandMemory(
            base: enumCast(op.mem.base),
            index: op.mem.index == ARM_REG_INVALID ? nil : enumCast(op.mem.index),
            scale: op.mem.scale == 1 ? .plus : .minus,
            displacement: numericCast(op.mem.disp)
        )
    }
    
    /// Operand type for SETEND instruction
    var setend: ArmSetend! {
        guard type == .setend else { return nil }
        return enumCast(op.setend)
    }
    
    /// Operand value
    var value: ArmOperandValue {
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

typealias ArmOperandShift = (type: ArmSft, value: UInt)

public struct ArmOperandMemory: CustomStringConvertible {
    let base: ArmReg
    let index: ArmReg?
    let scale: FloatingPointSign
    let displacement: Int
    
    public var description: String {
        var description = "\(base)"
        if let index = index {
            description += ",\(index)"
        }
        if displacement > 0 {
            let scaleString = scale == .plus ? "+" : "-"
            description += ",\(scaleString)\(displacement)"
        }
        return description
    }
}

