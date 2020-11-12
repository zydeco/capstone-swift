import Ccapstone

// Instruction details
extension Instruction {
    // detail accessor
    var detail: cs_detail? {
        /// NOTE: detail pointer is only valid when both requirements below are met:
        /// (1) CS_OP_DETAIL = CS_OPT_ON
        /// (2) Engine is not in Skipdata mode (CS_OP_SKIPDATA option set to CS_OPT_ON)
        guard hasDetail else {
            return nil
        }
        return insn.detail?.pointee
    }
    
    public var hasDetail: Bool { mgr.cs.detail && insn.id != 0 }

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
        readDetailsArray(array: detail?.groups, size: detail?.groups_count)
    }
    
    /// List of register names this instruction reads from.
    /// This API is only valid when detail mode is on (it's off by default).
    /// When in 'diet' mode, this API is irrelevant because engine does not store registers.
    public var registerNamesRead: [String] {
        getRegsRead().compactMap({ mgr.cs.name(ofRegister: $0) })
    }
    
    internal func getRegsRead() -> [UInt16] {
        (try? getRegsAccessed())?.read ?? []
    }
    
    /// List of register names this instruction writes to.
    /// This API is only valid when detail mode is on (it's off by default).
    /// When in 'diet' mode, this API is irrelevant because engine does not store registers.
    public var registerNamesWritten: [String] {
        getRegsWritten().compactMap({ mgr.cs.name(ofRegister: $0) })
    }
    
    internal func getRegsWritten() -> [UInt16] {
        (try? getRegsAccessed())?.written ?? []
    }
    
    internal func readDetailsArray<E,A,C>(array: A?, size: C?) -> [E] where C: FixedWidthInteger {
        guard let array = array, let size = size else {
            // skipped data or no details
            return []
        }
        let maxSize = Mirror(reflecting: array).children.count
        let count = min(maxSize, Int(size))
        return withUnsafePointer(to: array, { $0.withMemoryRebound(to: E.self, capacity: count, { regs in
            (0..<count).map({ regs[$0] })
        })})
    }
    
    internal func getRegsAccessed() throws -> (read: [UInt16], written: [UInt16]) {
        let maxRegs = MemoryLayout<cs_regs>.size / MemoryLayout<UInt16>.size
        var regsRead = Array(repeating: UInt16(0), count: maxRegs)
        var regsWritten = Array(repeating: UInt16(0), count: maxRegs)
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

public protocol OperandContainer {
    associatedtype OperandType where OperandType: InstructionOperand
    
    /// Operands for this instruction
    /// Empty if detail mode is off
    var operands: [OperandType] { get }
}

public protocol InstructionOperand {
    associatedtype OperandTypeType
    associatedtype OperandValueType
    
    /// Operand type
    var type: OperandTypeType { get }
    /// Operand access mode
    var access: Access { get }
    /// Operand value
    var value: OperandValueType { get }
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
    
    /// Registers read and written by this instruction.
    /// This API is only valid when detail mode is on (it's off by default)
    public var registersAccessed: (read: [RegType], written: [RegType]) {
        guard let registers = try? getRegsAccessed() else {
            return (read: [], written: [])
        }
        return (read: registers.read.compactMap({ RegType(rawValue: $0) }),
                written: registers.written.compactMap({ RegType(rawValue: $0) }))
    }
    
    /// Register names read and written by this instruction.
    /// This API is only valid when detail mode is on (it's off by default)
    public var registerNamesAccessed: (read: [String], written: [String]) {
        guard let registers = try? getRegsAccessed() else {
            return (read: [], written: [])
        }
        return (read: registers.read.compactMap({ mgr.cs.name(ofRegister: numericCast($0)) }),
                written: registers.written.compactMap({ mgr.cs.name(ofRegister: numericCast($0)) }))
    }
}
