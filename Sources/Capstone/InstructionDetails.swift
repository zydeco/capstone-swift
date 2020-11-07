// Instruction details
extension Instruction {
    /// List of basic groups this instruction belongs to
    /// - returns `[.invalid]` if detail mode is disabled
    public var baseGroups: [InstructionGroup] {
        return getInstructionGroups()
    }
    
    internal func getInstructionGroups<T: RawRepresentable>() -> [T] where T.RawValue == UInt8 {
        guard let detail = insn.detail?.pointee else {
            return [T(rawValue: 0)!]
        }
        let count = min(8, Int(detail.groups_count))
        let groups = withUnsafePointer(to: detail.groups, { $0.withMemoryRebound(to: UInt8.self, capacity: count, { groups in
            (0..<count).compactMap({ T(rawValue:groups[$0]) })
        })})
        return groups
    }
    
    internal func getRegsRead<T: RawRepresentable>() -> [T] where T.RawValue == UInt16 {
        guard let detail = insn.detail?.pointee else {
            return [T(rawValue: 0)!]
        }
        let count = min(16, Int(detail.regs_read_count))
        return withUnsafePointer(to: detail.regs_read, { $0.withMemoryRebound(to: UInt16.self, capacity: count, { regs in
            (0..<count).compactMap({ T(rawValue:regs[$0]) })
        })})
    }
    
    internal func getRegsWritten<T: RawRepresentable>() -> [T] where T.RawValue == UInt16 {
        guard let detail = insn.detail?.pointee else {
            return [T(rawValue: 0)!]
        }
        let count = min(20, Int(detail.regs_write_count))
        return withUnsafePointer(to: detail.regs_write, { $0.withMemoryRebound(to: UInt16.self, capacity: count, { regs in
            (0..<count).compactMap({ T(rawValue:regs[$0]) })
        })})
    }
}

/// Common instruction operand types - to be consistent across all architectures.
public enum OperandType: UInt32 {
    // must match cs_op_type
    case invalid
    /// Register operand.
    case register
    /// Immediate operand.
    case immediate
    /// Memory operand.
    case memory
    /// Floating point operand.
    case floatingPoint
}

/// Common instruction operand access types - to be consistent across all architectures.
public struct OperandAccessType: OptionSet {
    // must match cs_ac_type
    public var rawValue: UInt32
    
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }
    
    /// Operand read from memory or register.
    public static let read = 1
    /// Operand write to memory or register.
    public static let write = 2
    
}

/// Common instruction groups - to be consistent across all architectures.
public enum InstructionGroup: UInt8 {
    // must match cs_group_type
    /// uninitialized/invalid group.
    case invalid
    /// all jump instructions (conditional+direct+indirect jumps)
    case jump
    /// all call instructions
    case call
    /// all return instructions
    case ret
    /// all interrupt instructions (int+syscall)
    case int
    /// all interrupt return instructions
    case iret
    /// all privileged instructions
    case privilege
    /// all relative branching instructions
    case branchRelative
}

