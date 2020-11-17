import Ccapstone

/// Errors thrown by Capstone
public enum CapstoneError: Error {
    /// No error: everything was fine (this error is not thrown)
    case ok
    /// Out-Of-Memory error
    case outOfMemory
    /// Unsupported architecture: thrown by`Capstone(arch:, mode:)`
    case unsupportedArchitecture
    /// Invalid/unsupported mode: thrown by`Capstone(arch:, mode:)`
    case invalidMode
    /// Invalid/unsupported option: thrown by `Capstone.set(option:)`
    case invalidOption
    /// Information is unavailable because detail option is OFF
    case detailNotAvailable
    /// Unsupported version (bindings)
    case unsupportedVersion
    /// Access irrelevant data in "diet" engine
    case notInDiet
    /// Access irrelevant data for "data" instruction in `skipData` mode
    case skipData
    /// Unsupported syntax
    case unsupportedSyntax(syntax: Syntax)
    /// Unknown error
    case unknown(code: UInt32)
}

extension cs_err: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension CapstoneError {
    private static let errorMapping: [cs_err: CapstoneError] = [
        CS_ERR_OK: .ok,
        CS_ERR_MEM: .outOfMemory,
        CS_ERR_ARCH: .unsupportedArchitecture,
        CS_ERR_MODE: .invalidMode,
        CS_ERR_OPTION: .invalidOption,
        CS_ERR_DETAIL: .detailNotAvailable,
        CS_ERR_VERSION: .unsupportedVersion,
        CS_ERR_DIET: .notInDiet,
        CS_ERR_SKIPDATA: .skipData,
        CS_ERR_X86_ATT: .unsupportedSyntax(syntax: .att),
        CS_ERR_X86_INTEL: .unsupportedSyntax(syntax: .intel),
        CS_ERR_X86_MASM: .unsupportedSyntax(syntax: .masm)
    ]

    init(_ err: cs_err) {
        self = CapstoneError.errorMapping[err] ?? .unknown(code: err.rawValue)
    }
}
