// Various utility functions that didn't fit anywhere else

@inlinable internal func optionalNumericCast<T, U>(_ x: T?) -> U? where T : BinaryInteger, U : BinaryInteger {
    guard let x = x else {
        return nil
    }
    return numericCast(x)
}

@inlinable internal func enumCast<T, U: RawRepresentable>(_ x: T) -> U where T : BinaryInteger, U.RawValue : BinaryInteger {
    return U(rawValue: numericCast(x))!
}

@inlinable internal func enumCast<T: RawRepresentable, U: RawRepresentable>(_ x: T) -> U where T.RawValue : BinaryInteger, U.RawValue : BinaryInteger {
    return enumCast(x.rawValue)
}

@inlinable internal func optionalEnumCast<T, U: RawRepresentable>(_ x: T?) -> U? where T : BinaryInteger, U.RawValue : BinaryInteger {
    guard let x = x else {
        return nil
    }
    return U(rawValue: numericCast(x))
}

@inlinable internal func optionalEnumCast<T: RawRepresentable, U: RawRepresentable>(_ x: T?) -> U? where T.RawValue : BinaryInteger, U.RawValue : BinaryInteger {
    return optionalEnumCast(x?.rawValue)
}
