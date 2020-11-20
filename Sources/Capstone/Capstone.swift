import Foundation
import Ccapstone

/// An instance of Capstone is used to disassemble code.
public class Capstone {
    /// The linked version of Capstone.
    public static var version: (major: Int32, minor: Int32) {
        var major: Int32 = 0
        var minor: Int32 = 0
        cs_version(&major, &minor)
        return (major, minor)
    }

    internal let handle: csh
    // when using skipdata options, the pointer to the mnemonic must be kept as long as it's used
    internal var skipDataMnemonicPtr: UnsafeMutablePointer<Int8>!
    internal var skipDataCallback: SkipDataCallback?
    internal var currentCode: Data?
    // valid specific type for disassembled instructions
    internal let instructionClass: Instruction.Type
    // is detail mode enabled?
    internal var detail = false

    /// Creates a new instance of Capstone for a given architecture and mode.
    ///
    /// - parameter arch: target architecture to disassemble
    /// - parameter mode: combination of modes - some are architecture-specific
    /// - throws:
    ///   * `CapstoneError.unsupportedArchitecture` if capstone was built without support for the chosen architecture
    ///   * `CapstoneError.invalidMode` if the given combination of modes is invalid for the target architecture
    ///   * `CapstoneError.unsupportedVersion` if the installed version of capstone does not match the Swift bindings
    public init(arch: Architecture, mode: Mode = []) throws {
        guard CS_VERSION_MAJOR == 4, Capstone.version.major == CS_VERSION_MAJOR else {
            throw CapstoneError.unsupportedVersion
        }

        var h: csh = 0
        let err = cs_open(cs_arch(arch.rawValue), cs_mode(Int32(bitPattern: mode.rawValue)), &h)
        guard err == CS_ERR_OK else {
            throw CapstoneError(err)
        }
        handle = h
        instructionClass = arch.instructionClass
    }

    /// Check if an architecture is supported.
    ///
    /// By default, Capstone is built with support for all architectures, but some can be removed to reduce size.
    /// - parameter arch: architecture to check for
    /// - returns: `true` if the architecture is supported, `false` otherwise
    public static func supports(arch: Architecture) -> Bool {
        return cs_support(Int32(arch.rawValue))
    }

    /// Check the build mode of the library.
    ///
    /// - parameter buildMode: mode to check for
    /// - returns: `true` if capstone was built in this mode
    public static func supports(buildMode: BuildMode) -> Bool {
        return cs_support(buildMode.rawValue)
    }

    deinit {
        var h = handle
        cs_close(&h)
        skipDataMnemonicPtr?.deallocate()
    }

    /// Disassembles binary code.
    ///
    /// - parameter InsType: instruction class to return. Must be `Instruction`, or the specific class for the target architecture
    /// - parameter code: code to disassemble
    /// - parameter address: address of the first instruction in given `code`
    /// - parameter count: number of instructions to disassemble; 0 or nil to get all of them
    /// - returns: disassembled instructions in the instruction class of the target architecture
    /// - throws:
    ///   * `CapstoneError.unsupportedArchitecture` if the return array is not of `Instruction` or the target architecture's instruction class
    ///   * `CapstoneError.outOfMemory` if capstone runs out of memory during disassembly
    public func disassemble<InsType: Instruction>(code: Data, address: UInt64, count: Int? = nil) throws -> [InsType] {
        guard InsType.self == Instruction.self || InsType.self == instructionClass else {
            throw CapstoneError.unsupportedArchitecture
        }
        var insnsPtr: UnsafeMutablePointer<cs_insn>?
        currentCode = code
        let resultCount = code.withUnsafeBytes({ (ptr: UnsafeRawBufferPointer) in
            cs_disasm(handle, ptr.bindMemory(to: UInt8.self).baseAddress!, code.count, address, count ?? 0, &insnsPtr)
        })
        currentCode = nil
        guard resultCount > 0, let insns = insnsPtr else {
            throw CapstoneError(cs_errno(handle))
        }
        let mgr = InstructionMemoryManager(insns, count: resultCount, cs: self)
        // swiftlint:disable force_cast
        return (0..<resultCount).map({ instructionClass.init(mgr, index: $0) as! InsType })
        // swiftlint:enable force_cast
    }

    func name(ofInstruction id: UInt32) -> String? {
        guard let namePtr = cs_insn_name(handle, id) else {
            return nil
        }
        return String(cString: namePtr)
    }

    func name(ofRegister id: UInt16) -> String? {
        guard let namePtr = cs_reg_name(handle, numericCast(id)) else {
            return nil
        }
        return String(cString: namePtr)
    }

    /// Returns the name of a register in a string.
    ///
    /// - parameter id: register to name. must match the register enum for the target architecture.
    /// - returns: the name of the register, or `nil` if it's not a valid value.
    public func name<T: RawRepresentable>(ofRegister id: T) -> String? where T.RawValue == UInt16 {
        guard instructionClass.registerType == T.self else {
            return nil
        }
        return name(ofRegister: id.rawValue)
    }
}

/// Compilation modes for the Capstone library.
///
/// By default, Capstone is built in full mode, with all supported architectures.
/// Use `Capstone.supports(buildMode:)` to check if Capstone was built in any special mode.
public enum BuildMode: Int32 {
    /// Support value to verify diet mode of the engine.
    ///
    /// If capstone is compiled in "diet" mode, the following information is not available:
    /// * Instruction mnemonics
    /// * Instruction operand strings
    /// * Instruction groups
    /// * Registers implicitly read/written by instructions
    ///
    /// See [capstone-engine.org/diet.html](https://www.capstone-engine.org/diet.html) .
    case diet = 0x10000 // CS_SUPPORT_DIET
    /// Support value to verify X86-reduce mode of the engine.
    ///
    /// In X86-reduce mode, some parts of the X86 instruction set are removed:
    /// * Floating Point Unit (FPU)
    /// * MultiMedia eXtension (MMX)
    /// * Streaming SIMD Extensions (SSE)
    /// * 3DNow
    /// * Advanced Vector Extensions (AVX)
    /// * Fused Multiply Add Operations (FMA)
    /// * eXtended Operations (XOP)
    /// * Transactional Synchronization Extensions (TSX)
    ///
    /// See [capstone-engine.org/x86reduce.html](https://www.capstone-engine.org/x86reduce.html) .
    case x86reduce = 0x10001 // CS_SUPPORT_X86_REDUCE
}
