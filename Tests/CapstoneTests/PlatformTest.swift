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
        // swiftlint:disable force_cast
        try run(address: address, options: testOptions) { ($1 as! InstructionDetailsPrintable).printInstructionDetails(cs: $0) }
        // swiftlint:enable force_cast
    }

    func run(address: UInt64, options testOptions: Options = Options.default, iterator: (Capstone, Instruction) -> Void) throws {
        // Initialize Capstone
        let capstone = try Capstone(arch: arch, mode: mode)
        try testOptions.capstoneOptions.forEach({ try capstone.set(option: $0) })
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
        instructions.forEach({ iterator(capstone, $0) })
        if let lastInstruction = instructions.last, testOptions.printEndAddress {
            let endAddress = lastInstruction.address + numericCast(lastInstruction.size)
            print("0x\(hex(endAddress, uppercase: testOptions.uppercaseHex)):\n")
        }
    }

    struct Options {
        let separator: String
        let uppercaseHex: Bool
        let printEndAddress: Bool
        let capstoneOptions: [DisassemblyOption]

        static let `default` = Options(
            separator: basic.separator,
            uppercaseHex: basic.uppercaseHex,
            printEndAddress: basic.printEndAddress,
            capstoneOptions: [.detail(value: true)])

        static let basic = Options(
            separator: "****************",
            uppercaseHex: false,
            printEndAddress: true,
            capstoneOptions: [])
    }
}
