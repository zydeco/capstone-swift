import Foundation
import Ccapstone

public class Instruction: CustomStringConvertible {
    let cs: Capstone
    let insn: cs_insn
    
    internal init(_ insn: cs_insn, cs: Capstone) {
        self.cs = cs
        self.insn = insn
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
}
