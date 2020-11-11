import Capstone

protocol InstructionDetailsPrintable {
    func printInstructionDetails(cs: Capstone)
}

extension Instruction {
    func printInstructionBase() {
        print("0x\(String(address, radix: 16)):\t\(mnemonic)\t\(operandsString)")
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
            
            switch op.access {
            case .read:
                print("\t\toperands[\(i)].access: READ")
            case .write:
                print("\t\toperands[\(i)].access: WRITE")
            case [.read, .write]:
                print("\t\toperands[\(i)].access: READ | WRITE")
            default:
                break
            }
            
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
        
        let regs = registerNamesAccessed
        if !regs.read.isEmpty {
            print("\tRegisters read: \(regs.read.joined(separator: " "))")
        }
        if !regs.written.isEmpty {
            print("\tRegisters modified: \(regs.written.joined(separator: " "))")
        }
        
        print()
    }
}

