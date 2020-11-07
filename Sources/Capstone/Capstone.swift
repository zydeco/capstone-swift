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
    
    /// Create an instance of Capstone
    ///  * parameter arch: `Architecture` type
    ///  * parameter mode: combination of `Mode` values - some are architecture-specific
    /// Throws on invalid combinatins of  arch and mode.
    public convenience init(arch: Architecture, mode: Mode = []) throws {
        try self.init(arch: cs_arch(arch.rawValue), mode: cs_mode(mode.rawValue))
    }
    
    init(arch: cs_arch, mode: cs_mode) throws {
        var h: csh = 0
        let err = cs_open(arch, mode, &h)
        guard err == CS_ERR_OK else {
            throw CapstoneError(err)
        }
        handle = h
    }
    
    deinit {
        var h = handle
        cs_close(&h)
        skipDataMnemonicPtr?.deallocate()
    }
    
    public func disassemble(code: Data, address: UInt64, count: Int? = nil) throws -> [Instruction] {
        var insns: UnsafeMutablePointer<cs_insn>? = nil
        let resultCount = code.withUnsafeBytes({ (ptr: UnsafeRawBufferPointer) in
            cs_disasm(handle, ptr.bindMemory(to: UInt8.self).baseAddress!, code.count, address, count ?? 0, &insns)
        })
        guard resultCount > 0 else {
            throw CapstoneError(cs_errno(handle))
        }
        defer {
            cs_free(insns, resultCount)
        }
        return (0..<resultCount).map({ Instruction(insns![$0], cs: self) })
    }
}
