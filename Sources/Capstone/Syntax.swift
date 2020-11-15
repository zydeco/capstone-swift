import Ccapstone

/// Syntax options
public enum Syntax: Int {
    /// Default asm syntax
    case `default`
    /// X86 Intel asm syntax - default on X86
    case intel
    /// X86 ATT asm syntax
    case att
    /// Prints register name with only number
    case noRegName
    /// X86 Intel Masm syntax
    case masm
    /// MOS65XX use $ as hex prefix
    case motorola
}
