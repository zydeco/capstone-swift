import Capstone
import Foundation

// swiftlint:disable file_length
// swiftlint:disable cyclomatic_complexity
// swiftlint:disable function_body_length

protocol InstructionDetailsPrintable {
    func printInstructionDetails(cs: Capstone)
}

extension Access {
    var testDescription: String {
        switch self {
        case .read:
            return "READ"
        case .write:
            return "WRITE"
        case [.read, .write]:
            return "READ | WRITE"
        default:
            return "UNKNOWN(\(rawValue))"
        }
    }
}

extension Instruction {
    func printOperandAccess(index i: Int, access: Access) {
        if !access.isEmpty {
            print("\t\toperands[\(i)].access: \(access.testDescription)")
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

func hex<T: BinaryInteger>(_ n: T, uppercase: Bool = false, digits: Int? = nil) -> String where T.Magnitude: FixedWidthInteger {
    if T.isSigned && n < 0 {
        return hex(T.Magnitude(truncatingIfNeeded: n), uppercase: uppercase, digits: digits)
    }
    var string = String(n, radix: 16)
    if uppercase {
        string = string.uppercased()
    }
    if let digits = digits, string.count < digits {
        return String(repeating: "0", count: digits - string.count) + string
    }
    return string
}

func hex(_ data: Data) -> String {
    return data.reduce("") { $0 + String(format: "%02x", $1) }
}

private func printInstructionValue<T: RawRepresentable>(_ name: String, value: T?) where T.RawValue: FixedWidthInteger {
    printInstructionValue(name, value: value?.rawValue)
}

private func printInstructionValue(_ name: String, value: Bool?) {
    guard let value = value, value else {
        return
    }
    print("\t\(name): True")
}

private func printInstructionValue<T: FixedWidthInteger>(_ name: String, value: T?) {
    guard let value = value else {
        return
    }
    print("\t\(name): \(value)")
}

private func printInstructionValue<T: FixedWidthInteger>(_ name: String, hex value: T?) {
    guard let value = value else {
        return
    }
    print("\t\(name): 0x\(hex(value))")
}

extension ArmInstruction: InstructionDetailsPrintable {
    func printInstructionDetails(cs: Capstone) {
        printInstructionBase()
        guard hasDetail else {
            return
        }

        let registerName = { (reg: ArmReg) -> String in
            cs.name(ofRegister: reg)!
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
                break
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
extension Arm64Sysreg: Arm64OperandSysValue {}

extension Arm64Instruction: InstructionDetailsPrintable {
    func printInstructionDetails(cs: Capstone) {
        printInstructionBase()
        guard hasDetail else {
            return
        }

        let registerName = { (reg: Arm64Reg) -> String in
            cs.name(ofRegister: reg)!
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
                guard let value = op.value as? Arm64OperandSysValue else {
                    fatalError("Invalid sys operand value: \(op.value)")
                }
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
            cs.name(ofRegister: reg)!
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

extension X86Instruction: InstructionDetailsPrintable {
    var formattedPrefix: String {
        // prefix formatted as 4 hex bytes
        String(format: "0x%02x 0x%02x 0x%02x 0x%02x ",
               prefix.first(where: { (X86Prefix.lock.rawValue...X86Prefix.rep.rawValue).contains($0.rawValue) })?.rawValue ?? 0,
               prefix.first(where: { (X86Prefix.cs.rawValue...X86Prefix.gs.rawValue).contains($0.rawValue) })?.rawValue ?? 0,
               prefix.contains(.opsize) ? X86Prefix.opsize.rawValue : 0,
               prefix.contains(.addrsize) ? X86Prefix.addrsize.rawValue : 0)
    }

    var formattedOpcode: String {
        // opcode formatted as 4 hex bytes
        var bytes = Array(repeating: UInt8(0), count: 4)
        bytes.replaceSubrange(0..<opcode.count, with: opcode)
        return String(format: "0x%02x 0x%02x 0x%02x 0x%02x ", bytes[0], bytes[1], bytes[2], bytes[3])
    }

    func printInstructionDetails(cs: Capstone) {
        printInstructionBase()
        guard hasDetail else {
            return
        }

        let registerName = { (reg: X86Reg) -> String in
            cs.name(ofRegister: reg)!
        }

        print("\tPrefix:\(formattedPrefix)")
        print("\tOpcode:\(formattedOpcode)")
        printInstructionValue("rex", hex: rex ?? 0) // match C test output
        printInstructionValue("addr_size", value: addressSize)
        printInstructionValue("modrm", hex: modRM)
        printInstructionValue("modrm_offset", hex: encoding.modRMOffset)
        printInstructionValue("disp", hex: displacement ?? 0) // match C test output
        if let disp = encoding.displacement {
            printInstructionValue("disp_offset", hex: disp.offset)
            printInstructionValue("disp_size", hex: disp.size)
        }

        if let sib = sib {
            printInstructionValue("sib", hex: sib.value)
            print("\t\tsib_base: \(registerName(sib.base))")
            print("\t\tsib_index: \(registerName(sib.index))")
            print("\t\tsib_scale: \(sib.scale)")
        }

        printInstructionValue("xop_cc", value: xopConditionCode)
        printInstructionValue("sse_cc", value: sseConditionCode)
        printInstructionValue("avx_cc", value: avxConditionCode)
        if avxSuppressAllException {
            printInstructionValue("avx_sae", value: 1)
        }
        printInstructionValue("avx_rm", value: avxStaticRoundingMode)

        // Print out all immediate operands
        let imms = operands.filter({ $0.type == .imm })
        if !imms.isEmpty {
            printInstructionValue("imm_count", value: imms.count)
        }
        for (i, imm) in imms.enumerated() {
            print("\t\timms[\(i+1)]: 0x\(hex(imm.immediateValue))")
            if let enc = encoding.immediate {
                printInstructionValue("imm_offset", hex: enc.offset)
                printInstructionValue("imm_size", hex: enc.size)
            }
        }

        if operands.count > 0 {
            print("\top_count: \(operands.count)")
        }

        // Print out all operands
        for (i, op) in operands.enumerated() {
            switch op.type {
            case .invalid:
                fatalError("Invalid operand")
            case .reg:
                print("\t\toperands[\(i)].type: REG = \(registerName(op.register))")
            case .imm:
                print("\t\toperands[\(i)].type: IMM = 0x\(hex(op.immediateValue))")
            case .mem:
                print("\t\toperands[\(i)].type: MEM")
                if let segment = op.memory.segment {
                    print("\t\t\toperands[\(i)].mem.segment: REG = \(registerName(segment))")
                }
                if let base = op.memory.base {
                    print("\t\t\toperands[\(i)].mem.base: REG = \(registerName(base))")
                }
                if let index = op.memory.index {
                    print("\t\t\toperands[\(i)].mem.index: REG = \(registerName(index))")
                }
                if op.memory.scale != 1 {
                    print("\t\t\toperands[\(i)].mem.scale: \(op.memory.scale)")
                }
                if op.memory.displacement != 0 {
                    print("\t\t\toperands[\(i)].mem.disp: 0x\(hex(op.memory.displacement))")
                }
            }

            printInstructionValue("\toperands[\(i)].avx_bcast", value: op.avxBroadcastType)
            if op.avxZeroOpmask {
                print("\t\toperands[\(i)].avx_zero_opmask: TRUE")
            }
            printInstructionValue("\toperands[\(i)].size", value: op.size)
            printOperandAccess(index: i, access: op.access)
        }

        printRegisters(registerNamesAccessed)

        if let flags = eFlags, !flags.isEmpty {
            print("\tEFLAGS: \(flags)")
        } else if let flags = fpuFlags, !flags.isEmpty {
            print("\tFPU_FLAGS: \(flags)")
        }

        print()
    }
}

extension M68kInstruction: InstructionDetailsPrintable {
    func printInstructionDetails(cs: Capstone) {
        printInstructionBase()
        guard hasDetail else {
            return
        }

        let registerName = { (reg: M68kReg) -> String in
            cs.name(ofRegister: reg)!
        }

        if operands.count > 0 {
            print("\top_count: \(operands.count)")
        }

        // print registers one in each line
        let registers = registerNamesAccessed
        for reg in registers.read {
            print("\treading from reg: \(reg)")
        }
        for reg in registers.written {
            print("\twriting to reg:   \(reg)")
        }

        print("\tgroups_count: \(groups.count)")

        for (i, op) in operands.enumerated() {
            switch op.type {
            case .invalid:
                fatalError("Invalid operand")
            case .reg:
                print("\t\toperands[\(i)].type: REG = \(registerName(op.register))")
            case .imm:
                let imm32 = UInt32(op.immediateValue! & 0xffffffff)
                print("\t\toperands[\(i)].type: IMM = 0x\(hex(imm32))")
            case .mem:
                print("\t\toperands[\(i)].type: MEM")
                let mem = op.memory!
                if let base = mem.base {
                    print("\t\t\toperands[\(i)].mem.base: REG = \(registerName(base))")
                }
                if let index = mem.index {
                    print("\t\t\toperands[\(i)].mem.index: REG = \(registerName(index.register))")
                    print("\t\t\toperands[\(i)].mem.index: size = \(String(describing: index.size).prefix(1))")
                }
                if mem.displacement != 0 {
                    print("\t\t\toperands[\(i)].mem.disp: 0x\(hex(mem.displacement))")
                }
                if let scale = mem.index?.scale, scale != 0 {
                    print("\t\t\toperands[\(i)].mem.scale: \(scale)")
                }
                print("\t\taddress mode: \(op.addressingMode)")
            case .fpSingle:
                print("\t\toperands[\(i)].type: FP_SINGLE")
                print("\t\t\toperands[\(i)].simm: \(String(format: "%f", op.floatValue!))")
            case .fpDouble:
                print("\t\toperands[\(i)].type: FP_DOUBLE")
                print("\t\t\toperands[\(i)].dimm: \(String(format: "%lf", op.doubleValue!))")
            case .regBits:
                print("\t\toperands[\(i)].type: REG_BITS = $\(hex(op.registerList.registerBits))")
            case .regPair:
                break
            case .brDisp:
                break
            }
        }

        print()
    }
}

extension SparcInstruction: InstructionDetailsPrintable {
    func printInstructionDetails(cs: Capstone) {
        printInstructionBase()
        guard hasDetail else {
            return
        }

        let registerName = { (reg: SparcReg) -> String in
            cs.name(ofRegister: reg)!
        }

        if operands.count > 0 {
            print("\top_count: \(operands.count)")
        }

        for (i, op) in operands.enumerated() {
            switch op.type {
            case .invalid:
                fatalError("Invalid operand")
            case .reg:
                print("\t\toperands[\(i)].type: REG = \(registerName(op.register))")
            case .imm:
                print("\t\toperands[\(i)].type: IMM = 0x\(hex(op.immediateValue!))")
            case .mem:
                print("\t\toperands[\(i)].type: MEM")
                let mem = op.memory!
                print("\t\t\toperands[\(i)].mem.base: REG = \(registerName(mem.base))")
                if let index = mem.index {
                    print("\t\t\toperands[\(i)].mem.index: REG = \(registerName(index))")
                }
                if mem.displacement != 0 {
                    print("\t\t\toperands[\(i)].mem.disp: 0x\(hex(mem.displacement))")
                }
            }
        }

        printInstructionValue("Code condition", value: conditionCode)
        if !hint.isEmpty {
            printInstructionValue("Hint code", value: hint)
        }
        print()
    }
}

extension EthereumInstruction: InstructionDetailsPrintable {
    func printInstructionDetails(cs: Capstone) {
        printInstructionBase()
        guard hasDetail else {
            return
        }

        print("\tPop:     \(pop!)")
        print("\tPush:    \(push!)")
        print("\tGas fee: \(fee!)")

        if !groups.isEmpty {
            print("\tGroups: \(groupNames.joined(separator: " ")) ")
        }
        print()
    }
}

extension MipsInstruction: InstructionDetailsPrintable {
    func printInstructionDetails(cs: Capstone) {
        printInstructionBase()
        guard hasDetail else {
            return
        }

        let registerName = { (reg: MipsReg) -> String in
            cs.name(ofRegister: reg)!
        }

        if operands.count > 0 {
            print("\top_count: \(operands.count)")
        }

        for (i, op) in operands.enumerated() {
            switch op.type {
            case .invalid:
                fatalError("Invalid operand")
            case .reg:
                print("\t\toperands[\(i)].type: REG = \(registerName(op.register))")
            case .imm:
                print("\t\toperands[\(i)].type: IMM = 0x\(hex(op.immediateValue!))")
            case .mem:
                print("\t\toperands[\(i)].type: MEM")
                let mem = op.memory!
                print("\t\t\toperands[\(i)].mem.base: REG = \(registerName(mem.base))")
                if mem.displacement != 0 {
                    print("\t\t\toperands[\(i)].mem.disp: 0x\(hex(mem.displacement))")
                }
            }
        }

        print()
    }
}

extension M680xInstruction: InstructionDetailsPrintable {
    func printInstructionDetails(cs: Capstone) {
        let hexString = hex(bytes).uppercased()
        let hexAndSpaces = bytes.count <= 5 ?
            hexString.padding(toLength: 11, withPad: " ", startingAt: 0) :
            hexString + "         "
        print("0x\(hex(address, uppercase: true, digits: 4)): \(hexAndSpaces)\(mnemonic.padding(toLength: 5, withPad: " ", startingAt: 0)) \(operandsString)")

        guard hasDetail else {
            return
        }

        let registerName = { (reg: M680xReg) -> String in
            cs.name(ofRegister: reg)!
        }

        if operands.count > 0 {
            print("\top_count: \(operands.count)")
        }

        for (i, op) in operands.enumerated() {
            switch op.type {
            case .invalid:
                fatalError("Invalid operand")
            case .register:
                let comment = op.isInMnemonic ? " (in mnemonic)" : ""
                print("\t\toperands[\(i)].type: REGISTER = \(registerName(op.register))\(comment)")
            case .constant:
                print("\t\toperands[\(i)].type: CONSTANT = \(op.constantValue!)")
            case .immediate:
                print("\t\toperands[\(i)].type: IMMEDIATE = #\(op.immediateValue!)")
            case .direct:
                print("\t\toperands[\(i)].type: DIRECT = 0x\(hex(op.directAddress!, uppercase: true, digits: 2))")
            case .extended:
                let ext = op.extendedAddress!
                print("\t\toperands[\(i)].type: EXTENDED \(ext.indirect ? "INDIRECT" : "") = 0x\(hex(ext.address, uppercase: true, digits: 4))")
            case .relative:
                print("\t\toperands[\(i)].type: RELATIVE = 0x\(hex(op.relativeAddress.address, uppercase: true, digits: 4))")
            case .indexed:
                let idx = op.indexedAddress!
                print("\t\toperands[\(i)].type: INDEXED" + (idx.indirect ? " INDIRECT" : ""))
                if let reg = idx.base {
                    print("\t\t\tbase register: \(registerName(reg))")
                }
                if let reg = idx.offset.register {
                    print("\t\t\toffset register: \(registerName(reg))")
                }
                if idx.offset.width != .none && idx.incDec == 0 {
                    print("\t\t\toffset: \(idx.offset.value)")
                    if idx.base == .pc {
                        print("\t\t\toffset address: 0x\(hex(idx.offset.address, uppercase: true))")
                    }
                    print("\t\t\toffset bits: \(idx.offset.width.rawValue)")
                }
                if idx.incDec != 0 {
                    let value = idx.incDec
                    let postPre = idx.pre ? "pre" : "post"
                    let incDec = value > 0 ? "increment" : "decrement"
                    print("\t\t\t\(postPre) \(incDec): \(abs(value))")
                }
            }

            if op.size > 0 {
                print("\t\t\tsize: \(op.size)")
            }

            if !op.access.isEmpty {
                print("\t\t\taccess: \(op.access.testDescription)")
            }
        }

        printRegisters(registerNamesAccessed)

        if !groups.isEmpty {
            printInstructionValue("groups_count", value: groups.count)
        }
        print()
    }
}

extension SystemZInstruction: InstructionDetailsPrintable {
    func printInstructionDetails(cs: Capstone) {
        printInstructionBase()
        guard hasDetail else {
            return
        }

        let registerName = { (reg: SyszReg) -> String in
            cs.name(ofRegister: reg)!
        }

        if operands.count > 0 {
            print("\top_count: \(operands.count)")
        }

        for (i, op) in operands.enumerated() {
            switch op.type {
            case .invalid:
                fatalError("Invalid operand")
            case .reg:
                print("\t\toperands[\(i)].type: REG = \(registerName(op.register))")
            case .acreg:
                print("\t\toperands[\(i)].type: ACREG = \(registerName(op.register))")
            case .imm:
                print("\t\toperands[\(i)].type: IMM = 0x\(hex(op.immediateValue!))")
            case .mem:
                print("\t\toperands[\(i)].type: MEM")
                let mem = op.memory!
                print("\t\t\toperands[\(i)].mem.base: REG = \(registerName(mem.base))")
                if let idx = mem.index {
                    print("\t\t\toperands[\(i)].mem.index: REG = \(registerName(idx))")
                }
                if mem.length != 0 {
                    print("\t\t\toperands[\(i)].mem.length: 0x\(hex(mem.length))")
                }
                if mem.displacement != 0 {
                    print("\t\t\toperands[\(i)].mem.disp: 0x\(hex(mem.displacement))")
                }
            }
        }

        printInstructionValue("Code condition", value: conditionCode)

        print()
    }
}

extension XCoreInstruction: InstructionDetailsPrintable {
    func printInstructionDetails(cs: Capstone) {
        printInstructionBase()
        guard hasDetail else {
            return
        }

        let registerName = { (reg: XcoreReg) -> String in
            cs.name(ofRegister: reg)!
        }

        if operands.count > 0 {
            print("\top_count: \(operands.count)")
        }

        for (i, op) in operands.enumerated() {
            switch op.type {
            case .invalid:
                fatalError("Invalid operand")
            case .reg:
                print("\t\toperands[\(i)].type: REG = \(registerName(op.register))")
            case .imm:
                print("\t\toperands[\(i)].type: IMM = 0x\(hex(op.immediateValue!))")
            case .mem:
                print("\t\toperands[\(i)].type: MEM")
                let mem = op.memory!
                print("\t\t\toperands[\(i)].mem.base: REG = \(registerName(mem.base))")
                if let idx = mem.index {
                    print("\t\t\toperands[\(i)].mem.index: REG = \(registerName(idx))")
                }
                if mem.displacement != 0 {
                    print("\t\t\toperands[\(i)].mem.disp: 0x\(hex(mem.displacement))")
                }
            }
        }

        print()
    }
}

extension TMS320C64xInstruction: InstructionDetailsPrintable {
    func printInstructionDetails(cs: Capstone) {
        printInstructionBase()
        guard hasDetail else {
            return
        }

        let registerName = { (reg: Tms320c64xReg) -> String in
            cs.name(ofRegister: reg)!
        }

        if operands.count > 0 {
            print("\top_count: \(operands.count)")
        }

        for (i, op) in operands.enumerated() {
            switch op.type {
            case .invalid:
                fatalError("Invalid operand")
            case .reg:
                print("\t\toperands[\(i)].type: REG = \(registerName(op.register))")
            case .imm:
                print("\t\toperands[\(i)].type: IMM = 0x\(hex(op.immediateValue!))")
            case .mem:
                print("\t\toperands[\(i)].type: MEM")
                let mem = op.memory!
                print("\t\t\toperands[\(i)].mem.base: REG = \(registerName(mem.base))")
                switch mem.displacement {
                case .constant(value: let value):
                    print("\t\t\toperands[\(i)].mem.disptype: Constant")
                    print("\t\t\toperands[\(i)].mem.disp: \(value)")
                case .register(register: let reg):
                    print("\t\t\toperands[\(i)].mem.disptype: Register")
                    print("\t\t\toperands[\(i)].mem.disp: \(registerName(reg))")
                }
                print("\t\t\toperands[\(i)].mem.unit: \(mem.unit)")
                print("\t\t\toperands[\(i)].mem.direction: \(mem.direction)")
                print("\t\t\toperands[\(i)].mem.modify: \(mem.modification)")
                print("\t\t\toperands[\(i)].mem.scaled: \(mem.scaled)")
            case .regpair:
                print("\t\toperands[\(i)].type: REGPAIR = \(op.registerPair.map({ registerName($0) }).joined(separator: ":"))")
            }
        }

        print("\tFunctional unit: \(functionalUnit!)")
        if crossPath {
            print("\tCrosspath: 1")
        }

        if let cc = condition {
            print("\tCondition: [\(cc.zero ? "!" : " ")\(registerName(cc.register))]")
        }
        print("\tParallel: \(parallel ? "true" : "false")")

        print()
    }
}

extension Mos65xxInstruction: InstructionDetailsPrintable {
    func printInstructionDetails(cs: Capstone) {
        printInstructionBase()
        guard hasDetail else {
            return
        }

        let registerName = { (reg: Mos65xxReg) -> String in
            cs.name(ofRegister: reg)!
        }

        print("\taddress mode: \(addressingMode!)")
        print("\tmodifies flags: \(modifiesFlags!)")

        if operands.count > 0 {
            print("\top_count: \(operands.count)")
        }

        for (i, op) in operands.enumerated() {
            switch op.type {
            case .invalid:
                fatalError("Invalid operand")
            case .reg:
                print("\t\toperands[\(i)].type: REG = \(registerName(op.register))")
            case .imm:
                print("\t\toperands[\(i)].type: IMM = 0x\(hex(op.immediateValue!))")
            case .mem:
                print("\t\toperands[\(i)].type: MEM = 0x\(hex(op.address!))")
            }
        }

        print()
    }
}
