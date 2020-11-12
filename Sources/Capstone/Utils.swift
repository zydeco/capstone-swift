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

@inlinable internal func optionalEnumCast<T: BinaryInteger, U: RawRepresentable>(_ x: T?, ignoring invalidValues: [T] = []) -> U? where U.RawValue : BinaryInteger {
    guard let x = x, !invalidValues.contains(x) else {
        return nil
    }
    return U(rawValue: numericCast(x))
}

@inlinable internal func optionalEnumCast<T: BinaryInteger, U: RawRepresentable>(_ x: T?, ignoring invalidValues: T...) -> U? where U.RawValue : BinaryInteger {
    return optionalEnumCast(x, ignoring: invalidValues)
}

@inlinable internal func optionalEnumCast<T: RawRepresentable, U: RawRepresentable>(_ x: T?, ignoring invalidValues: T...) -> U? where T.RawValue : BinaryInteger, U.RawValue : BinaryInteger {
    return optionalEnumCast(x?.rawValue, ignoring: invalidValues.map({ $0.rawValue }))
}
