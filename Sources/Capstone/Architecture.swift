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
public class ArmInstruction: PlatformInstruction<armIns, armGrp, armReg> {}

/// ARM-64 Instruction
public class Arm64Instruction: PlatformInstruction<arm64Ins, arm64Grp, arm64Reg> {}

/// Mips Instruction
public class MipsInstruction: PlatformInstruction<mipsIns, mipsGrp, mipsReg> {}

/// X86 Instruction
public class X86Instruction: PlatformInstruction<x86Ins, x86Grp, x86Reg> {}

/// PowerPC Instruction
public class PowerPCInstruction: PlatformInstruction<ppcIns, ppcGrp, ppcReg> {}

/// Sparc Instruction
public class SparcInstruction: PlatformInstruction<sparcIns, sparcGrp, sparcReg> {}

/// SystemZ Instruction
public class SystemZInstruction: PlatformInstruction<syszIns, syszGrp, syszReg> {}

/// XCore Instruction
public class XCoreInstruction: PlatformInstruction<xcoreIns, xcoreGrp, xcoreReg> {}

/// 68K Instruction
public class M68kInstruction: PlatformInstruction<m68kIns, m68kGrp, m68kReg> {}

/// TMS320C64x Instruction
public class TMS320C64xInstruction: PlatformInstruction<tms320c64xIns, tms320c64xGrp, tms320c64xReg> {}

/// M680x Instruction
public class M680xInstruction: PlatformInstruction<m680xIns, m680xGrp, m680xReg> {}

/// Ethereum Instruction
public class EthereumInstruction: PlatformInstruction_IG<evmIns, evmGrp> {}

/// MOS65XX Instruction
public class Mos65xxInstruction: PlatformInstruction<mos65xxIns, mos65xxGrp, mos65xxReg> {}

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
