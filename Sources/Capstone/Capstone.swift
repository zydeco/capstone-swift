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
}
