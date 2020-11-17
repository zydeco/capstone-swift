import Foundation
import Ccapstone

public class Instruction: CustomStringConvertible {
    let mgr: InstructionMemoryManager
    let index: Int
    var insn: cs_insn { mgr.insns[index] }
    public class var registerType: Any.Type? { nil }
    public class var instructionType: InstructionType.Type { fatalError("Not implemented") }

    internal required init(_ mgr: InstructionMemoryManager, index: Int) {
        self.mgr = mgr
        self.index = index
    }

    /// Instruction ID (basically a numeric ID for the instruction mnemonic)
    /// This information is available even when detail option is disabled
    public var id: UInt32 {
        insn.id
    }

    /// Address (EIP) of this instruction
    /// This information is available even when detail option is disabled
    public var address: UInt64 {
        insn.address
    }

    /// Size of this instruction
    /// This information is available even when detail option is disabled
    public var size: UInt16 {
        insn.size
    }

    /// Machine bytes of this instruction
    /// This information is available even when detail option is disabled
    public var bytes: Data {
        withUnsafePointer(to: insn.bytes, { Data(bytes: $0, count: Int(insn.size)) })
    }

    /// Ascii text of instruction mnemonic
    /// This information is available even when detail option is disabled
    public var mnemonic: String {
        withUnsafePointer(to: insn.mnemonic, { $0.withMemoryRebound(to: Int8.self, capacity: Int(CS_MNEMONIC_SIZE), { String(cString: $0) }) })
    }

    /// Ascii text of instruction operands
    /// This information is available even when detail option is disabled
    public var operandsString: String {
        withUnsafePointer(to: insn.op_str, { $0.withMemoryRebound(to: Int8.self, capacity: 160, { String(cString: $0) }) })
    }

    public var description: String {
        "\(mnemonic) \(operandsString)"
    }

    /// Friendly name of an instruction in a string.
    var name: String {
        String(cString: cs_insn_name(mgr.cs.handle, id))
    }
}

// Instruction Memory Management
// Ensures cs_free is called when there are no more references to instructions
public class InstructionMemoryManager {
    let insns: UnsafeMutablePointer<cs_insn>
    let count: Int
    let cs: Capstone

    internal init(_ insns: UnsafeMutablePointer<cs_insn>, count: Int, cs: Capstone) {
        self.insns = insns
        self.count = count
        self.cs = cs
    }

    deinit {
        cs_free(insns, count)
    }
}

// Superclass for platform-specific instruction classes without registers
public class PlatformInstructionBase<
    InsType: InstructionType,
    GroupType: RawRepresentable
>: Instruction where
    GroupType.RawValue == UInt8 {
    public var instruction: InsType {
        InsType(rawValue: super.id)!
    }

    override public class var instructionType: InstructionType.Type { InsType.self }
}

// Superclass for platform-specific instruction classes with registers
public class PlatformInstruction<
    InsType: InstructionType,
    GroupType: RawRepresentable,
    RegType: RawRepresentable
>: PlatformInstructionBase<InsType, GroupType> where
    GroupType.RawValue == UInt8,
    RegType.RawValue == UInt16 {
    override public class var registerType: Any.Type? { RegType.self }
}
