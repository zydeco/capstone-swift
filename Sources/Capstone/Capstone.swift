import Foundation
import Ccapstone

/// An instance of Capstone used to disassemble code
public class Capstone {
    public static var version: (major: Int32, minor: Int32) {
        get {
            var major: Int32 = 0
            var minor: Int32 = 0
            cs_version(&major, &minor)
            return (major, minor)
        }
    }
    
    internal let handle: csh
    // when using skipdata options, the pointer to the mnemonic must be kept as long as it's used
    internal var skipDataMnemonicPtr: UnsafeMutablePointer<Int8>!
    internal var skipDataCallback: SkipDataCallback?
    internal var currentCode: Data?
    // valid specific type for disassembled instructions
    internal let instructionType: Instruction.Type
    // is detail mode enabled?
    internal var detail = false
    
    /// Create an instance of Capstone
    ///  * parameter arch: `Architecture` type
    ///  * parameter mode: combination of `Mode` values - some are architecture-specific
    /// Throws on invalid combinatins of  arch and mode, or if the version of the capstone library isn't supported by the Swift bindings
    public init(arch: Architecture, mode: Mode = []) throws {
        guard CS_VERSION_MAJOR == 5, Capstone.version.major == 5 else {
            throw CapstoneError.unsupportedVersion
        }
        
        var h: csh = 0
        let err = cs_open(cs_arch(arch.rawValue), cs_mode(mode.rawValue), &h)
        guard err == CS_ERR_OK else {
            throw CapstoneError(err)
        }
        handle = h
        instructionType = arch.instructionType
    }
    
    /// Check if an architecture is supported
    ///  * parameter arch: Architecture to check for
    ///  * returns: true if the architecture is supported, false otherwise
    public static func supports(arch: Architecture) -> Bool {
        return cs_support(Int32(arch.rawValue))
    }
    
    /// Check build mode of the library
    public static func supports(buildMode: BuildMode) -> Bool {
        return cs_support(buildMode.rawValue)
    }
    
    deinit {
        var h = handle
        cs_close(&h)
        skipDataMnemonicPtr?.deallocate()
    }
    
    /// Disassembles binary code
    /// - parameter code: code to disassemble
    /// - parameter address: address of the first instruction in given `code`
    /// - parameter count: number of instructions to disassemble; 0 or nil to get all of them
    /// - parameter InsType: instruction type to return. Must be `Instruction`, or the specific type for the current architecture
    /// - returns disassembled instructions
    /// - throws if an error occurs during disassembly
    public func disassemble<InsType: Instruction>(code: Data, address: UInt64, count: Int? = nil) throws -> [InsType] {
        guard InsType.self == Instruction.self || InsType.self == instructionType else {
            throw CapstoneError.unsupportedArchitecture
        }
        var insnsPtr: UnsafeMutablePointer<cs_insn>? = nil
        currentCode = code
        let resultCount = code.withUnsafeBytes({ (ptr: UnsafeRawBufferPointer) in
            cs_disasm(handle, ptr.bindMemory(to: UInt8.self).baseAddress!, code.count, address, count ?? 0, &insnsPtr)
        })
        currentCode = nil
        guard resultCount > 0, let insns = insnsPtr else {
            throw CapstoneError(cs_errno(handle))
        }
        let mgr = InstructionMemoryManager(insns, count: resultCount, cs: self)
        return (0..<resultCount).map({ instructionType.init(mgr, index: $0) as! InsType })
    }
    
    /// Returns friendly name of an instruction in a string.
    func name(ofInstruction id: UInt32) -> String? {
        guard let namePtr = cs_insn_name(handle, id) else {
            return nil
        }
        return String(cString: namePtr)
    }
}

public enum BuildMode: Int32 {
    /// Support value to verify diet mode of the engine.
    case diet = 0x10000 // CS_SUPPORT_DIET
    /// Support value to verify X86 reduce mode of the engine.
    case x86reduce = 0x10001 // CS_SUPPORT_X86_REDUCE
}
