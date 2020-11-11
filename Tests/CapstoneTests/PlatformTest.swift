import Foundation
import Capstone

struct PlatformTest {
    let name: String
    let arch: Architecture
    let mode: Mode
    let code: Data
    let options: [DisassemblyOption]
    
    init(name: String, arch: Architecture, mode: Mode, code: Data, options: [DisassemblyOption] = []) {
        self.name = name
        self.arch = arch
        self.mode = mode
        self.code = code
        self.options = options
    }
    
    func run(address: UInt64) throws {
        // Initialize Capstone
        let capstone = try Capstone(arch: arch, mode: mode)
        try capstone.set(option: .detail(value: true))
        try options.forEach({ try capstone.set(option: $0) })
        
        print("****************")
        print("Platform: \(name)")
        print("Code:\(code.map({ String(format: "0x%02x ", $0)}).joined())")
        
        // Disassemble and print results
        let instructions = try capstone.disassemble(code: code, address: address)
        if instructions.isEmpty {
            print("ERROR: Failed to disasm given code!")
            abort()
        }
        
        print("Disasm:")
        instructions
            .compactMap({ $0 as? InstructionDetailsPrintable })
            .forEach({ $0.printInstructionDetails(cs: capstone) })
        if let lastInstruction = instructions.last {
            let endAddress = lastInstruction.address + numericCast(lastInstruction.size)
            print("0x\(hex(endAddress)):\n")
        }
    }
}
