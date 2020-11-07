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
}

extension CapstoneError {
    init(_ err: cs_err) {
        switch err {
        case CS_ERR_OK:
            self = .ok
        case CS_ERR_MEM:
            self = .outOfMemory
        case CS_ERR_ARCH:
            self = .unsupportedArchitecture
        case CS_ERR_MODE:
            self = .invalidMode
        case CS_ERR_OPTION:
            self = .invalidOption
        case CS_ERR_DETAIL:
            self = .detailNotAvailable
        case CS_ERR_VERSION:
            self = .unsupportedVersion
        case CS_ERR_DIET:
            self = .notInDiet
        case CS_ERR_SKIPDATA:
            self = .skipData
        case CS_ERR_X86_ATT:
            self = .unsupportedSyntax(syntax: .att)
        case CS_ERR_X86_INTEL:
            self = .unsupportedSyntax(syntax: .intel)
        case CS_ERR_X86_MASM:
            self = .unsupportedSyntax(syntax: .masm)
        default:
            self = .ok
        }
    }
}
