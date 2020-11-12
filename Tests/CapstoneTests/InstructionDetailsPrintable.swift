import Capstone

protocol InstructionDetailsPrintable {
    func printInstructionDetails(cs: Capstone)
}

extension Instruction {
    func printInstructionBase() {
        print("0x\(String(address, radix: 16)):\t\(mnemonic)\t\(operandsString)")
    }
    
    func printOperandAccess(index i: Int, access: Access) {
        switch access {
        case .read:
            print("\t\toperands[\(i)].access: READ")
        case .write:
            print("\t\toperands[\(i)].access: WRITE")
        case [.read, .write]:
            print("\t\toperands[\(i)].access: READ | WRITE")
        default:
            break
        }
    }
    
    func printRegisters(_ regs: (read: [String], written: [String])) {
        if !regs.read.isEmpty {
            print("\tRegisters read: \(regs.read.joined(separator: " "))")
        }
        if !regs.written.isEmpty {
            print("\tRegisters modified: \(regs.written.joined(separator: " "))")
        }
    }
}

func hex<T: BinaryInteger>(_ n: T) -> String where T.Magnitude: FixedWidthInteger {
    if T.isSigned && n < 0 {
        return hex(T.Magnitude(truncatingIfNeeded: n))
    }
    return String(n, radix: 16)
}

fileprivate func printInstructionValue<T: RawRepresentable>(_ name: String, value: T?) where T.RawValue: FixedWidthInteger {
    printInstructionValue(name, value: value?.rawValue)
}

fileprivate func printInstructionValue(_ name: String, value: Bool?) {
    guard let value = value, value else {
        return
    }
    print("\t\(name): True")
}

fileprivate func printInstructionValue<T: FixedWidthInteger>(_ name: String, value: T?) {
    guard let value = value else {
        return
    }
    print("\t\(name): \(value)")
}

extension ArmInstruction: InstructionDetailsPrintable {
    func printInstructionDetails(cs: Capstone) {
        printInstructionBase()
        guard hasDetail else {
            return
        }
        
        let registerName = { (reg: ArmReg) -> String in
            cs.name(ofRegister: reg.rawValue)!
        }
        
        if operands.count > 0 {
            print("\top_count: \(operands.count)")
        }
        
        for (i, op) in operands.enumerated() {
            switch op.type {
            case .invalid:
                fatalError("Invalid operand")
            case .reg:
                print("\t\toperands[\(i)].type: REG = \(registerName(op.register!))")
            case .imm:
                print("\t\toperands[\(i)].type: IMM = 0x\(hex(op.immediateValue!))")
            case .mem:
                print("\t\toperands[\(i)].type: MEM")
                let mem = op.memory!
                print("\t\t\toperands[\(i)].mem.base: REG = \(mem.base)")
                if let memIndex = mem.index {
                    print("\t\t\toperands[\(i)].mem.index: REG = \(memIndex)")
                }
                if mem.scale != .plus {
                    print("\t\t\toperands[\(i)].mem.scale: -1")
                }
                if mem.displacement != 0 {
                    print("\t\t\toperands[\(i)].mem.disp: 0x\(hex(Int32(mem.displacement)))")
                }
                if let leftShift = mem.leftShift {
                    print("\t\t\toperands[\(i)].mem.lshift: 0x\(hex(leftShift))")
                }
            case .fp:
                print("\t\toperands[\(i)].type: FP = \(op.doubleValue!)")
            case .cimm:
                print("\t\toperands[\(i)].type: C-IMM = \(op.immediateValue!)")
            case .pimm:
                print("\t\toperands[\(i)].type: P-IMM = \(op.immediateValue!)")
            case .setend:
                print("\t\toperands[\(i)].type: SETEND = \(op.setend!)")
            case .sysreg:
                print("\t\toperands[\(i)].type: SYSREG = \(op.systemRegister!.rawValue)")
            }
            
            if let neonLane = op.neonLane {
                print("\t\toperands[\(i)].neon_lane = \(neonLane)")
            }
            
            printOperandAccess(index: i, access: op.access)
            
            switch op.shift {
            case .some(.immediate(direction: let direction, value: let value)):
                print("\t\t\tShift: \(direction.rawValue) = \(value)")
            case .some(.register(direction: let direction, register: let register)):
                print("\t\t\tShift: \(direction.rawValue + 5) = \(registerName(register))")
            default:
                break;
            }
            
            if let vectorIndex = op.vectorIndex {
                print("\t\toperands[\(i)].vector_index = \(vectorIndex)")
            }
            
            if op.subtracted {
                print("\t\tSubtracted: True")
            }
        }
        
        if let cc = conditionCode, cc != .al {
            printInstructionValue("Code condition", value: cc)
        }
        
        printInstructionValue("Update-flags", value: updatesFlags)
        printInstructionValue("Write-back", value: writeBack)
        printInstructionValue("CPSI-mode", value: cpsMode?.mode)
        printInstructionValue("CPSI-flag", value: cpsMode?.flag)
        printInstructionValue("Vector-data", value: vectorDataType)
        if vectorSize > 0 {
            printInstructionValue("Vector-size", value: vectorSize)
        }
        printInstructionValue("User-mode", value: usermode)
        printInstructionValue("Memory-barrier", value: memoryBarrier)
        
        printRegisters(registerNamesAccessed)
        print()
    }
}

protocol Arm64OperandSysValue {
    var rawValue: UInt32 { get }
}
extension Arm64Ic: Arm64OperandSysValue {}
extension Arm64Dc: Arm64OperandSysValue {}
extension Arm64At: Arm64OperandSysValue {}
extension Arm64Tlbi: Arm64OperandSysValue {}

extension Arm64Instruction: InstructionDetailsPrintable {
    func printInstructionDetails(cs: Capstone) {
        printInstructionBase()
        guard hasDetail else {
            return
        }
        
        let registerName = { (reg: Arm64Reg) -> String in
            cs.name(ofRegister: reg.rawValue)!
        }

        if operands.count > 0 {
            print("\top_count: \(operands.count)")
        }
        
        for (i, op) in operands.enumerated() {
            switch op.type {
            case .invalid:
                fatalError("Invalid operand")
            case .reg:
                print("\t\toperands[\(i)].type: REG = \(registerName(op.register!))")
            case .imm:
                print("\t\toperands[\(i)].type: IMM = 0x\(hex(op.immediateValue!))")
            case .mem:
                print("\t\toperands[\(i)].type: MEM")
                let mem = op.memory!
                print("\t\t\toperands[\(i)].mem.base: REG = \(mem.base)")
                if let memIndex = mem.index {
                    print("\t\t\toperands[\(i)].mem.index: REG = \(memIndex)")
                }
                if mem.displacement != 0 {
                    print("\t\t\toperands[\(i)].mem.disp: 0x\(hex(Int32(mem.displacement)))")
                }
            case .fp:
                print("\t\toperands[\(i)].type: FP = \(op.doubleValue!)")
            case .cimm:
                print("\t\toperands[\(i)].type: C-IMM = \(op.immediateValue!)")
            case .regMrs:
                print("\t\toperands[\(i)].type: REG_MRS = 0x\(hex(op.systemRegister!.rawValue))")
            case .regMsr:
                print("\t\toperands[\(i)].type: REG_MSR = 0x\(hex(op.systemRegister!.rawValue))")
            case .pstate:
                print("\t\toperands[\(i)].type: PSTATE = 0x\(hex(op.pState!.rawValue))")
            case .sys:
                let value = op.value as! Arm64OperandSysValue
                print("\t\toperands[\(i)].type: SYS = 0x\(hex(value.rawValue))")
            case .prefetch:
                print("\t\toperands[\(i)].type: PREFETCH = 0x\(hex(op.prefetch!.rawValue))")
            case .barrier:
                print("\t\toperands[\(i)].type: BARRIER = 0x\(hex(op.barrier!.rawValue))")
            }
            
            printOperandAccess(index: i, access: op.access)
            
            if let shift = op.shift {
                print("\t\t\tShift: type = \(shift.type.rawValue), value = \(shift.value)")
            }
            
            if let ext = op.extender {
                print("\t\t\tExt: \(ext.rawValue)")
            }
            
            if let vas = op.vectorArrangementSpecifier {
                print("\t\t\tVector Arrangement Specifier: 0x\(hex(vas.rawValue))")
            }
            
            if let vess = op.vectorElementSizeSpecifier {
                print("\t\t\tVector Element Size Specifier: \(vess.rawValue)")
            }
            
            if let vectorIndex = op.vectorIndex {
                print("\t\t\tVector Index: \(vectorIndex)")
            }
        }
        
        printInstructionValue("Update-flags", value: updatesFlags)
        printInstructionValue("Write-back", value: writeBack)
        
        if let cc = conditionCode, cc != .al {
            printInstructionValue("Code-condition", value: cc)
        }
        
        printRegisters(registerNamesAccessed)
        print()
    }
}

extension PowerPCInstruction: InstructionDetailsPrintable {
    func printInstructionDetails(cs: Capstone) {
        printInstructionBase()
        guard hasDetail else {
            return
        }
        
        let registerName = { (reg: PpcReg) -> String in
            cs.name(ofRegister: reg.rawValue)!
        }

        if operands.count > 0 {
            print("\top_count: \(operands.count)")
        }
        
        for (i, op) in operands.enumerated() {
            switch op.type {
            case .invalid:
                fatalError("Invalid operand")
            case .reg:
                print("\t\toperands[\(i)].type: REG = \(registerName(op.register!))")
            case .imm:
                print("\t\toperands[\(i)].type: IMM = 0x\(hex(op.immediateValue!))")
            case .mem:
                print("\t\toperands[\(i)].type: MEM")
                if let reg = op.memory.base {
                    print("\t\t\toperands[\(i)].mem.base: REG = \(registerName(reg))")
                }
                if op.memory.displacement != 0 {
                    print("\t\t\toperands[\(i)].mem.disp: 0x\(hex(op.memory.displacement))")
                }
            case .crx:
                print("\t\toperands[\(i)].type: CRX")
                print("\t\t\toperands[\(i)].crx.scale: \(op.condition.scale)")
                print("\t\t\toperands[\(i)].crx.reg: \(registerName(op.condition.register))")
                print("\t\t\toperands[\(i)].crx.cond: \(op.condition.condition)")
            }
        }
        
        printInstructionValue("Branch code", value: branchCode)
        printInstructionValue("Branch hint", value: branchHint)
        printInstructionValue("Update-CR0", value: updatesCR0)
        
        print()
    }
}
