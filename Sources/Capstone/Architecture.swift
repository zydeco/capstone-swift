import Ccapstone

/// Architecture type
public enum Architecture: UInt32 {
    // this enum must match cs_arch
    /// ARM architecture (including Thumb, Thumb-2)
    case arm
    /// ARM-64, also called AArch64
    case arm64
    /// Mips architecture
    case mips
    /// X86 architecture (including x86 & x86-64)
    case x86
    /// PowerPC architecture
    case ppc
    /// Sparc architecture
    case sparc
    /// SystemZ architecture
    case sysz
    /// XCore architecture
    case xcore
    /// 68K architecture
    case m68k
    /// TMS320C64x architecture
    case tms320c64x
    /// 680X architecture
    case m680x
    /// Ethereum architecture
    case evm
    /// MOS65XX architecture (including MOS6502)
    case mos65xx
    /// WebAssembly architecture
    case wasm
    /// Berkeley Packet Filter architecture (including eBPF)
    case bpf
    /// RISCV architecture
    case riscv
}

/// ARM Instruction
public class ArmInstruction: PlatformInstruction<ArmIns, ArmGrp, ArmReg> {}

/// ARM-64 Instruction
public class Arm64Instruction: PlatformInstruction<Arm64Ins, Arm64Grp, Arm64Reg> {}

/// MIPS Instruction
public class MipsInstruction: PlatformInstruction<MipsIns, MipsGrp, MipsReg> {}

/// X86 Instruction
public class X86Instruction: PlatformInstruction<X86Ins, X86Grp, X86Reg> {}

/// PowerPC Instruction
public class PowerPCInstruction: PlatformInstruction<PpcIns, PpcGrp, PpcReg> {}

/// SPARC Instruction
public class SparcInstruction: PlatformInstruction<SparcIns, SparcGrp, SparcReg> {}

/// SystemZ Instruction
public class SystemZInstruction: PlatformInstruction<SyszIns, SyszGrp, SyszReg> {}

/// XCore Instruction
public class XCoreInstruction: PlatformInstruction<XcoreIns, XcoreGrp, XcoreReg> {}

/// M68K Instruction
public class M68kInstruction: PlatformInstruction<M68kIns, M68kGrp, M68kReg> {}

/// TMS320C64x Instruction
public class TMS320C64xInstruction: PlatformInstruction<Tms320c64xIns, Tms320c64xGrp, Tms320c64xReg> {}

/// M680x Instruction
public class M680xInstruction: PlatformInstruction<M680xIns, M680xGrp, M680xReg> {}

/// Ethereum Instruction
public class EthereumInstruction: PlatformInstructionBase<EvmIns, EvmGrp> {}

/// MOS65xx Instruction
public class Mos65xxInstruction: PlatformInstruction<Mos65xxIns, Mos65xxGrp, Mos65xxReg> {}

/// WebAssembly Instruction
public class WasmInstruction: PlatformInstructionBase<WasmIns, WasmGrp> {}

/// Berkeley Packet Filter Instruction
public class BpfInstruction: PlatformInstruction<BpfIns, BpfGrp, BpfReg> {}

/// RISCV Instruction
public class RiscvInstruction: PlatformInstruction<RiscvIns, RiscvGrp, RiscvReg> {}

public extension Architecture {
    /// The class for disassembled instructions used for this architecture.
    ///
    /// This is a subclass of `Instruction`, with accessors for operands and architecture-specific properties.
    var instructionClass: Instruction.Type {
        switch self {
        case .arm:
            return ArmInstruction.self
        case .arm64:
            return Arm64Instruction.self
        case .mips:
            return MipsInstruction.self
        case .x86:
            return X86Instruction.self
        case .ppc:
            return PowerPCInstruction.self
        case .sparc:
            return SparcInstruction.self
        case .sysz:
            return SystemZInstruction.self
        case .xcore:
            return XCoreInstruction.self
        case .m68k:
            return M68kInstruction.self
        case .tms320c64x:
            return TMS320C64xInstruction.self
        case .m680x:
            return M680xInstruction.self
        case .evm:
            return EthereumInstruction.self
        case .mos65xx:
            return Mos65xxInstruction.self
        case .wasm:
            return WasmInstruction.self
        case .bpf:
            return BpfInstruction.self
        case .riscv:
            return RiscvInstruction.self
        }
    }

    /// The type for registers used in this architecture (if any).
    ///
    /// This is an enum with values corresponding to the registers.
    var registerType: Any.Type? {
        instructionClass.registerType
    }

    /// The type for instructions used in this architecture.
    ///
    /// This is an enum with values corresponding to instruction mnemonics.
    var instructionType: InstructionType.Type {
        instructionClass.instructionType
    }
}

/// Protocol conformed to by enumerations representing architecture-specific instructions.
public protocol InstructionType {
    var rawValue: UInt32 { get }
    init?(rawValue: UInt32)
}
