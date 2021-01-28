import Foundation
import Capstone
import ArgumentParser

struct ArchMode {
    let arch: Architecture
    let mode: Mode
    let option: DisassemblyOption?
    let description: String?

    init(_ arch: Architecture, _ mode: Mode, _ description: String? = nil) {
        self.init(arch, mode, nil, description)
    }

    init(_ arch: Architecture, _ mode: Mode, _ option: DisassemblyOption? = nil, _ description: String? = nil) {
        self.arch = arch
        self.mode = mode
        self.option = option
        self.description = description
    }

    static let values: [String: ArchMode] = [
        "arm": ArchMode(.arm, [Mode.arm.arm, Mode.endian.little], "arm"),
        "armb": ArchMode(.arm, [Mode.arm.arm, Mode.endian.big]),
        "armbe": ArchMode(.arm, [Mode.arm.arm, Mode.endian.big], "arm + big endian"),
        "arml": ArchMode(.arm, [Mode.arm.arm, Mode.endian.little]),
        "armle": ArchMode(.arm, [Mode.arm.arm, Mode.endian.little]),
        "armv8": ArchMode(.arm, [Mode.arm.arm, Mode.arm.v8], "arm v8"),
        "thumbv8": ArchMode(.arm, [Mode.arm.arm, Mode.arm.thumb, Mode.arm.v8], "thumb v8"),
        "armv8be": ArchMode(.arm, [Mode.arm.arm, Mode.arm.v8, Mode.endian.big], "arm v8 + big endian"),
        "thumbv8be": ArchMode(.arm, [Mode.arm.arm, Mode.arm.thumb, Mode.arm.v8, Mode.endian.big], "thumb v8 + big endian"),
        "cortexm": ArchMode(.arm, [Mode.arm.arm, Mode.arm.thumb, Mode.arm.mClass], "thumb + cortex-m extensions"),
        "thumb": ArchMode(.arm, [Mode.arm.arm, Mode.arm.thumb], "thumb mode"),
        "thumbbe": ArchMode(.arm, [Mode.arm.arm, Mode.arm.thumb, Mode.endian.big], "thumb + big endian"),
        "thumble": ArchMode(.arm, [Mode.arm.arm, Mode.arm.thumb, Mode.endian.little]),
        "arm64": ArchMode(.arm64, [Mode.endian.little], "aarch64 mode"),
        "arm64be": ArchMode(.arm64, [Mode.endian.big], "aarch64 + big endian"),
        "mips": ArchMode(.mips, [Mode.bits.b32, Mode.endian.little], "mips32 + little endian"),
        "mipsmicro": ArchMode(.mips, [Mode.bits.b32, Mode.mips.micro], "mips32 + microMIPS"),
        "mipsbemicro": ArchMode(.mips, [Mode.bits.b32, Mode.mips.micro, Mode.endian.big], "mips32 + microMIPS + big endian"),
        "mipsbe32r6": ArchMode(.mips, [Mode.mips.mips32r6, Mode.endian.big], "mips32r6 + big endian"),
        "mipsbe32r6micro": ArchMode(.mips, [Mode.mips.mips32r6, Mode.endian.big, Mode.mips.micro], "mips32r6 + microMIPS + big endian"),
        "mips32r6": ArchMode(.mips, [Mode.mips.mips32r6], "mips32r6 + little endian"),
        "mips32r6micro": ArchMode(.mips, [Mode.mips.mips32r6, Mode.mips.micro], "mips32r6 + microMIPS"),
        "mipsbe": ArchMode(.mips, [Mode.bits.b32, Mode.endian.big], "mips32 + big endian"),
        "mips64": ArchMode(.mips, [Mode.bits.b64, Mode.endian.little], "mips64 + little endian"),
        "mips64be": ArchMode(.mips, [Mode.bits.b64, Mode.endian.big], "mips64 + big endian"),
        "x16": ArchMode(.x86, [Mode.bits.b16], "16-bit X86"),
        "x16att": ArchMode(.x86, [Mode.bits.b16], .syntax(syntax: .att), "16-bit X86 (AT&T syntax)"),
        "x32": ArchMode(.x86, [Mode.bits.b32], "32-bit X86"),
        "x32att": ArchMode(.x86, [Mode.bits.b32], .syntax(syntax: .att), "32-bit X86 (AT&T syntax)"),
        "x64": ArchMode(.x86, [Mode.bits.b64], "64-bit X86"),
        "x64att": ArchMode(.x86, [Mode.bits.b64], .syntax(syntax: .att), "64-bit X86 (AT&T syntax)"),
        "ppc32": ArchMode(.ppc, [Mode.bits.b32, Mode.endian.little], "ppc32 + little endian"),
        "ppc32be": ArchMode(.ppc, [Mode.bits.b32, Mode.endian.big], "ppc32 + big endian"),
        "ppc32qpx": ArchMode(.ppc, [Mode.bits.b32, Mode.ppc.qpx, Mode.endian.little], "ppc32 + qpx + little endian"),
        "ppc32beqpx": ArchMode(.ppc, [Mode.bits.b32, Mode.ppc.qpx, Mode.endian.big], "ppc32 + qpx + big endian"),
        "ppc64": ArchMode(.ppc, [Mode.bits.b64, Mode.endian.little], "ppc64 + little endian"),
        "ppc64be": ArchMode(.ppc, [Mode.bits.b64, Mode.endian.big], "ppc64 + big endian"),
        "ppc64qpx": ArchMode(.ppc, [Mode.bits.b64, Mode.ppc.qpx, Mode.endian.little], "ppc64 + qpx + little endian"),
        "ppc64beqpx": ArchMode(.ppc, [Mode.bits.b64, Mode.ppc.qpx, Mode.endian.big], "ppc64 + qpx + big endian"),
        "sparc": ArchMode(.sparc, [Mode.endian.big], "sparc"),
        "sparcv9": ArchMode(.sparc, [Mode.endian.big, Mode.sparc.v9], "sparc v9"),
        "systemz": ArchMode(.sysz, [Mode.endian.big], "systemz (x390x)"),
        "sysz": ArchMode(.sysz, [Mode.endian.big]),
        "s390x": ArchMode(.sysz, [Mode.endian.big]),
        "xcore": ArchMode(.xcore, [Mode.endian.big], "xcore"),
        "m68k": ArchMode(.m68k, [Mode.endian.big], "m68k"),
        "m68k40": ArchMode(.m68k, [Mode.m68k.mc68040], "m68k + 68040 mode"),
        "tms320c64x": ArchMode(.tms320c64x, [Mode.endian.big], "TMS320C64x"),
        "m6800": ArchMode(.m680x, [Mode.m680x.m6800], "M6800/2"),
        "m6801": ArchMode(.m680x, [Mode.m680x.m6801], "M6801/3"),
        "m6805": ArchMode(.m680x, [Mode.m680x.m6805], "M6805"),
        "m6808": ArchMode(.m680x, [Mode.m680x.m6808], "M68HC08"),
        "m6809": ArchMode(.m680x, [Mode.m680x.m6809], "M6809"),
        "m6811": ArchMode(.m680x, [Mode.m680x.m6811], "M68HC11"),
        "cpu12": ArchMode(.m680x, [Mode.m680x.cpu12], "M68HC12/HCS12"),
        "hd6301": ArchMode(.m680x, [Mode.m680x.m6301], "HD6301/3"),
        "hd6309": ArchMode(.m680x, [Mode.m680x.m6309], "HD6309"),
        "hcs08": ArchMode(.m680x, [Mode.m680x.hcs08], "HCS08"),
        "evm": ArchMode(.evm, [], "Ethereum Virtual Machine"),
        "wasm": ArchMode(.wasm, [], "WebAssembly"),
        "bpf": ArchMode(.bpf, [Mode.endian.little, Mode.bpf.classic], "Classic BPF"),
        "bpfbe": ArchMode(.bpf, [Mode.endian.big, Mode.bpf.classic], "Classic BPF + big endian"),
        "ebpf": ArchMode(.bpf, [Mode.endian.little, Mode.bpf.extended], "Extended BPF"),
        "ebpfbe": ArchMode(.bpf, [Mode.endian.big, Mode.bpf.extended], "Extended BPF + big endian"),
        "riscv32": ArchMode(.riscv, [Mode.riscv.riscv32], "RISCV 32-bit"),
        "riscv64": ArchMode(.riscv, [Mode.riscv.riscv64], "RISCV 64-bit"),
        "6502": ArchMode(.mos65xx, [Mode.mos65xx.mos6502], "MOS 6502"),
        "65c02": ArchMode(.mos65xx, [Mode.mos65xx.wdc65C02], "WDC 65c02"),
        "w65c02": ArchMode(.mos65xx, [Mode.mos65xx.wdcW65C02], "WDC w65c02"),
        "65816": ArchMode(.mos65xx, [Mode.mos65xx.wdc65816longMX], "WDC 65816 (long m/x)")
    ]

    static var helpString: String {
        values
            .sorted(by: { $0.value.arch == $1.value.arch ? $0.key < $1.key : $0.value.arch.rawValue < $1.value.arch.rawValue })
            .filter({ $0.value.description != nil })
            .map({ "\($0.key.padding(toLength: 18, withPad: " ", startingAt: 0))\($0.value.description!)" })
            .joined(separator: "\n")
    }

    static func parse(_ string: String) throws -> ArchMode {
        guard let archMode = values[string] else {
            throw ValidationError("\nValid arch-modes:\n\(helpString)")
        }
        return archMode
    }
}

struct CSTool: ParsableCommand {
    static let configuration = CommandConfiguration(commandName: "cstool", version: version)

    static var version: String {
        let version = Capstone.version
        guard let lastArchitecture = (0..<0x10000).last(where: { Architecture(rawValue: $0) != nil }) else {
            fatalError("Could not find last architecture")
        }
        let supportedArchitectures = (0...lastArchitecture)
            .compactMap({ Architecture(rawValue: $0) })
            .filter({ Capstone.supports(arch: $0)})
            .map({ String(describing: $0)})
            .sorted()
        var lines = [
            "CSTool for Capstone Disassembler Engine v\(version.major).\(version.minor)",
            "Supported architectures: \(supportedArchitectures.joined(separator: " "))"
        ]
        if Capstone.supports(buildMode: .diet) {
            lines.append("Capstone built in diet mode")
        }
        if Capstone.supports(buildMode: .x86reduce) {
            lines.append("Capstone built in x86 reduced mode")
        }
        return lines.joined(separator: "\n")
    }

    @Flag(name: .short, help: "show detailed information of the instructions")
    var detailed = false

    @Flag(name: .short, help: "decode in SKIPDATA mode")
    var skipData = false

    @Flag(name: .short, help: "show immediates as unsigned")
    var unsigned = false

    @Argument(help: ArgumentHelp("archictecture and mode", discussion: ArchMode.helpString), transform: ArchMode.parse)
    var archMode: ArchMode

    @Argument(help: "code to disassemble (hex)", transform: parseHexData)
    var code: Data

    @Argument(help: "start address (hex)", transform: parseAddress)
    var startAddress: UInt64?

    private static func parseHexData(_ hex: String) throws -> Data {
        let hexDigits = hex.map({ $0.hexDigitValue })
        var data = Data(capacity: hex.count/2)
        var i = 0
        while i < hexDigits.count-1 {
            if let highNibble = hexDigits[i], let lowNibble = hexDigits[i+1] {
                i += 2
                data.append(UInt8((highNibble << 4) + lowNibble))
            } else {
                i += 1
            }
        }
        return data
    }

    private static func parseAddress(_ hex: String) throws -> UInt64 {
        let hexString = hex.hasPrefix("0x") ? String(hex.dropFirst(2)) : hex
        guard let value = UInt64(hexString, radix: 16) else {
            if let invalidDigit = hexString.first(where: { !$0.isHexDigit}) {
                throw ValidationError("Invalid hex digit '\(invalidDigit)'")
            } else if hexString.count > 8 {
                throw ValidationError("Out of range")
            } else {
                throw ValidationError("Invalid")
            }
        }
        return value
    }

    func run() throws {
        let capstone = try Capstone(arch: archMode.arch, mode: archMode.mode)
        if let option = archMode.option {
            try capstone.set(option: option)
        }
        try capstone.set(option: .skipDataEnabled(skipData))
        try capstone.set(option: .unsigned(value: unsigned))
        try capstone.set(option: .detail(value: detailed))

        let instructions = try capstone.disassemble(code: code, address: startAddress ?? 0)
        guard !instructions.isEmpty else {
            print("ERROR: invalid code")
            throw ExitCode(-4)
        }

        // calculate max instruction size for padding
        let padSize = max(4, instructions.map({ $0.bytes.count }).max() ?? 0)

        for ins in instructions {
            guard let printable = ins as? InstructionDetailsPrintable else {
                fatalError("Intruction class \(type(of: ins)) is not printable!")
            }
            ins.printInstructionBase(padSize: padSize)
            printable.printInstructionDetails(cs: capstone)
        }
    }
}

extension Instruction {
    func printInstructionBase() {
        // unused, but called by printInstructionDetails
    }

    func printInstructionBase(padSize: Int) {
        let codeString = bytes.map({ String(format: "%02x ", $0) }).joined()
        print("\(String(format: "%2llx", address))  \(codeString.padding(toLength: 3 * padSize, withPad: " ", startingAt: 0)) \(mnemonic)\t\(operandsString)")
    }
}
