import Ccapstone

// Instruction details
extension Instruction {
    // detail accessor
    var detail: cs_detail? { insn.detail?.pointee }

    /// List of basic groups this instruction belongs to.
    /// This API is only valid when detail mode is on (it's off by default).
    /// When in 'diet' mode, this API is irrelevant because engine does not store registers.
    /// See `groups` for architecture-specific groups.
    /// - returns: list of groups, or `[.invalid]` if detail mode is disabled
    public var baseGroups: [InstructionGroup] {
        return getInstructionGroups().compactMap({ InstructionGroup(rawValue: $0) })
    }
    
    /// Check if a disassembled instruction belong to a particular group.
    /// This API is only valid when detail mode is on (it's off by default).
    /// When in 'diet' mode, this API is irrelevant because engine does not store registers.
    /// - parameter group: group to check
    /// - returns: `true` if detail mode is enabled and the instruction belongs to this group, `false` otherwise
    public func isIn(group: InstructionGroup) {
        return withUnsafePointer(to: insn, { cs_insn_group(mgr.cs.handle, $0, UInt32(group.rawValue)) })
    }
    
    /// List of group names this instruction belongs to.
    /// This API is only valid when detail mode is on (it's off by default).
    /// When in 'diet' mode, this API is irrelevant because engine does not store groups.
    public var groupNames: [String] {
        getInstructionGroups().compactMap({ String(cString: cs_group_name(mgr.cs.handle, UInt32($0))) })
    }
    
    internal func getInstructionGroups() -> [UInt8] {
        readDetailsArray(array: detail?.groups, size: detail?.groups_count, maxSize: 8)
    }
    
    /// List of register names this instruction reads from.
    /// This API is only valid when detail mode is on (it's off by default).
    /// When in 'diet' mode, this API is irrelevant because engine does not store registers.
    public var registerNamesRead: [String] {
        getRegsRead().compactMap({ String(cString: cs_reg_name(mgr.cs.handle, UInt32($0))) })
    }
    
    internal func getRegsRead() -> [UInt16] {
        (try? getRegsAccessed())?.read ?? []
    }
    
    /// List of register names this instruction writes to.
    /// This API is only valid when detail mode is on (it's off by default).
    /// When in 'diet' mode, this API is irrelevant because engine does not store registers.
    public var registerNamesWritten: [String] {
        getRegsWritten().compactMap({ String(cString: cs_reg_name(mgr.cs.handle, UInt32($0))) })
    }
    
    internal func getRegsWritten() -> [UInt16] {
        (try? getRegsAccessed())?.written ?? []
    }
    
    internal func readDetailsArray<E,A,C>(array: A?, size: C?, maxSize: Int) -> [E] where E: FixedWidthInteger, C: FixedWidthInteger {
        guard id != 0 else {
            // skipped data
            return []
        }
        guard let array = array, let size = size else {
            // no details available, return code for `invalid`
            return [0]
        }
        let count = min(maxSize, Int(size))
        return withUnsafePointer(to: array, { $0.withMemoryRebound(to: E.self, capacity: count, { regs in
            (0..<count).map({ regs[$0] })
        })})
    }
    
    internal func getRegsAccessed() throws -> (read: [UInt16], written: [UInt16]) {
        var regsRead = Array(repeating: UInt16(0), count: 64)
        var regsWritten = Array(repeating: UInt16(0), count: 64)
        var regsReadCount = UInt8(0)
        var regsWrittenCount = UInt8(0)
        let err = withUnsafePointer(to: insn, { cs_regs_access(mgr.cs.handle, $0, &regsRead, &regsReadCount, &regsWritten, &regsWrittenCount) })
        guard err == CS_ERR_OK else {
            throw CapstoneError(err)
        }
        regsRead.removeLast(64 - numericCast(regsReadCount))
        regsWritten.removeLast(64 - numericCast(regsWrittenCount))
        return (read: regsRead, written: regsWritten)
    }
}

/// Common instruction operand access types - to be consistent across all architectures.
public struct Access: OptionSet, CustomStringConvertible {
    // must match cs_ac_type
    public var rawValue: UInt32
    
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }
    
    /// Operand read from memory or register.
    public static let read = Access(rawValue: 1)
    /// Operand write to memory or register.
    public static let write = Access(rawValue: 2)
    
    
    public var description: String {
        var description = ""
        if self.contains(Access.read) {
            description += "r"
        }
        if self.contains(Access.write) {
            description += "w"
        }
        return description
    }
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

extension PlatformInstruction_IG {
    /// List of architecture-specific groups this instruction belongs to.
    /// This API is only valid when detail mode is on (it's off by default)
    /// See `groups` for architecture-specific groups.
    /// - returns `[.invalid]` if detail mode is disabled
    public var groups: [GroupType] {
        getInstructionGroups().compactMap({ GroupType(rawValue: $0) })
    }
    
    /// Check if a disassembled instruction belong to a particular group.
    /// This API is only valid when detail mode is on (it's off by default)
    /// - parameter group: group to check
    /// - returns: `true` i the instruction belongs to this group, `false` otherwise
    public func isIn(group: GroupType) {
        return withUnsafePointer(to: insn, { cs_insn_group(mgr.cs.handle, $0, UInt32(group.rawValue)) })
    }
}

extension PlatformInstruction {
    /// Registers read by this instruction.
    /// This API is only valid when detail mode is on (it's off by default)
    public var registersRead: [RegType] {
        getRegsRead().compactMap({ RegType(rawValue: $0) })
    }
    
    /// Registers written by this instruction.
    /// This API is only valid when detail mode is on (it's off by default)
    public var registersWritten: [RegType] {
        getRegsWritten().compactMap({ RegType(rawValue: $0) })
    }
}
