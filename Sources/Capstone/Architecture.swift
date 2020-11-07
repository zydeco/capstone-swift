import Ccapstone

/// Architecture type
public enum Architecture: UInt32 {
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
