import Ccapstone

// swiftlint:disable type_name

/// Mode type
///
/// Used to set modes when creating an instance of Capstone.
public struct Mode: OptionSet {
    public var rawValue: UInt32

    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }

    private init(_ modeValue: cs_mode) {
        self.init(rawValue: modeValue.rawValue)
    }

    /// Endianness modes
    public enum endian {
        /// little-endian mode (default mode)
        public static let little = Mode(CS_MODE_LITTLE_ENDIAN)
        /// big-endian mode
        public static let big = Mode(CS_MODE_BIG_ENDIAN)
    }

    /// Bitness modes
    public enum bits {
        /// 16-bit mode
        public static let b16 = Mode(CS_MODE_16)
        /// 32-bit mode
        public static let b32 = Mode(CS_MODE_32)
        /// 64-bit mode
        public static let b64 = Mode(CS_MODE_64)
    }

    /// ARM modes
    public enum arm {
        /// 32-bit ARM
        public static let arm = Mode(CS_MODE_ARM)
        /// ARM's Thumb mode, including Thumb-2
        public static let thumb = Mode(CS_MODE_THUMB)
        /// ARM's Cortex-M series
        public static let mClass = Mode(CS_MODE_MCLASS)
        /// ARMv8 A32 encodings for ARM
        public static let v8 = Mode(CS_MODE_V8)
    }

    /// MIPS modes
    public enum mips {
        /// MicroMips mode (MIPS)
        public static let micro = Mode(CS_MODE_MICRO)
        /// Mips II ISA
        public static let mips2 = Mode(CS_MODE_MIPS2)
        /// Mips III ISA
        public static let mips3 = Mode(CS_MODE_MIPS3)
        /// Mips32r6 ISA
        public static let mips32r6 = Mode(CS_MODE_MIPS32R6)
    }

    /// SPARC modes
    public enum sparc {
        /// SparcV9 mode
        public static let v9 = Mode(CS_MODE_V9)
    }

    /// PowerPC modes
    public enum ppc {
        /// Quad Processing eXtensions mode
        public static let qpx = Mode(CS_MODE_QPX)
        /// Signal Processing Engine mode
        public static let spe = Mode(CS_MODE_SPE)
        /// Book-E mode
        public static let bookE = Mode(CS_MODE_BOOKE)
    }

    /// M68K modes
    public enum m68k {
        /// M68K 68000 mode
        public static let mc68000 = Mode(CS_MODE_M68K_000)
        /// M68K 68010 mode
        public static let mc68010 = Mode(CS_MODE_M68K_010)
        /// M68K 68020 mode
        public static let mc68020 = Mode(CS_MODE_M68K_020)
        /// M68K 68030 mode
        public static let mc68030 = Mode(CS_MODE_M68K_030)
        /// M68K 68040 mode
        public static let mc68040 = Mode(CS_MODE_M68K_040)
        /// M68K 68060 mode
        public static let mc68060 = Mode(CS_MODE_M68K_060)
    }

    /// M680X modes
    public enum m680x {
        /// M680X Hitachi 6301,6303 mode
        public static let m6301 = Mode(CS_MODE_M680X_6301)
        /// M680X Hitachi 6309 mode
        public static let m6309 = Mode(CS_MODE_M680X_6309)
        /// M680X Motorola 6800,6802 mode
        public static let m6800 = Mode(CS_MODE_M680X_6800)
        /// M680X Motorola 6801,6803 mode
        public static let m6801 = Mode(CS_MODE_M680X_6801)
        /// M680X Motorola/Freescale 6805 mode
        public static let m6805 = Mode(CS_MODE_M680X_6805)
        /// M680X Motorola/Freescale/NXP 68HC08 mode
        public static let m6808 = Mode(CS_MODE_M680X_6808)
        /// M680X Motorola 6809 mode
        public static let m6809 = Mode(CS_MODE_M680X_6809)
        /// M680X Motorola/Freescale/NXP 68HC11 mode
        public static let m6811 = Mode(CS_MODE_M680X_6811)
        /// M680X Motorola/Freescale/NXP CPU12, used on M68HC12/HCS12
        public static let cpu12 = Mode(CS_MODE_M680X_CPU12)
        /// M680X Freescale/NXP HCS08 mode
        public static let hcs08 = Mode(CS_MODE_M680X_HCS08)
    }

    // MOS65xx modes
    public struct mos65xx {
        /// MOS65XXX MOS 6502
        public static let mos6502 = Mode(CS_MODE_MOS65XX_6502)
        /// MOS65XXX WDC 65c02
        public static let wdc65C02 = Mode(CS_MODE_MOS65XX_65C02)
        /// MOS65XXX WDC W65c02
        public static let wdcW65C02 = Mode(CS_MODE_MOS65XX_W65C02)
        /// MOS65XXX WDC 65816, 8-bit m/x
        public static let wdc65816 = Mode(CS_MODE_MOS65XX_65816)
        /// MOS65XXX WDC 65816, 16-bit m, 8-bit x
        public static let wdc65816longM = Mode(CS_MODE_MOS65XX_65816_LONG_M)
        /// MOS65XXX WDC 65816, 8-bit m, 16-bit x
        public static let wdc65816longX = Mode(CS_MODE_MOS65XX_65816_LONG_X)
        /// MOS65XXX WDC 65816, 16-bit m, 16-bit x
        public static let wdc65816longMX = Mode(CS_MODE_MOS65XX_65816_LONG_MX)
    }

    // BPF modes
    public struct bpf {
        /// Classic BPF mode (default)
        public static let classic = Mode(CS_MODE_BPF_CLASSIC)
        /// Extended BPF mode
        public static let extended = Mode(CS_MODE_BPF_EXTENDED)
    }

    /// RISCV modes
    public struct riscv {
        /// RISCV RV32G
        public static let riscv32 = Mode(CS_MODE_RISCV32)
        /// RISCV RV64G
        public static let riscv64 = Mode(CS_MODE_RISCV64)
        /// RISCV Compressed Instruction Mode
        public static let compressed = Mode(CS_MODE_RISCVC)
    }
}
