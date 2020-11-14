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
    
    func run(address: UInt64, options testOptions: Options = Options.default) throws {
        // Initialize Capstone
        let capstone = try Capstone(arch: arch, mode: mode)
        try capstone.set(option: .detail(value: true))
        try options.forEach({ try capstone.set(option: $0) })
        
        print(testOptions.separator)
        print("Platform: \(name)")
        let codeFormat = testOptions.uppercaseHex ? "0x%02X " : "0x%02x "
        print("Code: \(code.map({ String(format: codeFormat, $0)}).joined())")
        
        // Disassemble and print results
        let instructions = try capstone.disassemble(code: code, address: address)
        if instructions.isEmpty {
            print("ERROR: Failed to disasm given code!")
            abort()
        }
        
        print("Disasm:")
        instructions
            .map({ $0 as! InstructionDetailsPrintable })
            .forEach({ $0.printInstructionDetails(cs: capstone) })
        if let lastInstruction = instructions.last, testOptions.printEndAddress {
            let endAddress = lastInstruction.address + numericCast(lastInstruction.size)
            print("0x\(hex(endAddress, uppercase: testOptions.uppercaseHex)):\n")
        }
    }
    
    struct Options {
        let separator: String
        let uppercaseHex: Bool
        let printEndAddress: Bool
        
        static let `default` = Options(
            separator: "****************",
            uppercaseHex: false,
            printEndAddress: true)
    }
}
