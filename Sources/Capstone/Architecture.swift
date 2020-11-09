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
}

/// ARM Instruction
public class ArmInstruction: PlatformInstruction<ArmIns, ArmGrp, ArmReg> {}

/// ARM-64 Instruction
public class Arm64Instruction: PlatformInstruction<Arm64Ins, Arm64Grp, Arm64Reg> {}

/// Mips Instruction
public class MipsInstruction: PlatformInstruction<MipsIns, MipsGrp, MipsReg> {}

/// X86 Instruction
public class X86Instruction: PlatformInstruction<X86Ins, X86Grp, X86Reg> {}

/// PowerPC Instruction
public class PowerPCInstruction: PlatformInstruction<PpcIns, PpcGrp, PpcReg> {}

/// Sparc Instruction
public class SparcInstruction: PlatformInstruction<SparcIns, SparcGrp, SparcReg> {}

/// SystemZ Instruction
public class SystemZInstruction: PlatformInstruction<SyszIns, SyszGrp, SyszReg> {}

/// XCore Instruction
public class XCoreInstruction: PlatformInstruction<XcoreIns, XcoreGrp, XcoreReg> {}

/// 68K Instruction
public class M68kInstruction: PlatformInstruction<M68kIns, M68kGrp, M68kReg> {}

/// TMS320C64x Instruction
public class TMS320C64xInstruction: PlatformInstruction<Tms320c64xIns, Tms320c64xGrp, Tms320c64xReg> {}

/// M680x Instruction
public class M680xInstruction: PlatformInstruction<M680xIns, M680xGrp, M680xReg> {}

/// Ethereum Instruction
public class EthereumInstruction: PlatformInstruction_IG<EvmIns, EvmGrp> {}

/// MOS65XX Instruction
public class Mos65xxInstruction: PlatformInstruction<Mos65xxIns, Mos65xxGrp, Mos65xxReg> {}

public extension Architecture {
    /// The type of instructions used for this architecture
    /// `Instruction` is always a valid type
    var instructionType: Instruction.Type {
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
        }
    }
}
