import Ccapstone

extension Mos65xxInstruction: OperandContainer {
    public var operands: [Operand] {
        let operands: [cs_mos65xx_op] = readDetailsArray(array: detail?.mos65xx.operands, size: detail?.mos65xx.op_count)
        return operands.map({ Operand(op: $0) })
    }
    
    /// Addressing mode for this instruction
    public var addressingMode: Mos65xxAm! { optionalEnumCast(detail?.mos65xx.am) }
    
    /// True if this instruction modifies flags
    public var modifiesFlags: Bool! { detail?.mos65xx.modifies_flags }
    
    /// Instruction operand
    public struct Operand: InstructionOperand {
        internal let op: cs_mos65xx_op
        
        public var type: Mos65xxOp { enumCast(op.type) }

        public var value: Mos65xxOperandValue {
            switch type {
            case .imm:
                return immediateValue
            case .reg:
                return register
            case .mem:
                return address
            default:
                fatalError("Invalid mos65xx operand type \(type.rawValue)")
            }
        }
        
        /// Register value for register operand
        public var register: Mos65xxReg! {
            guard type == .reg else {
                return nil
            }
            return enumCast(op.reg)
        }
        
        /// Immediate value for immediate operand
        public var immediateValue: UInt16! {
            guard type == .imm else {
                return nil
            }
            return op.imm
        }
        
        /// Address for memory operand
        public var address: UInt32! {
            guard type == .mem else {
                return nil
            }
            return op.mem
        }
    }
}

public protocol Mos65xxOperandValue {}
extension Mos65xxReg: Mos65xxOperandValue {}
extension UInt16: Mos65xxOperandValue {}
extension UInt32: Mos65xxOperandValue {}

extension Mos65xxAm: CustomStringConvertible {
    public var description: String {
        switch self {
        case .none:
            return "No address mode"
        case .imp:
            return "implied"
        case .acc:
            return "accumulator"
        case .imm:
            return "immediate value"
        case .rel:
            return "relative"
        case .int:
            return "interrupt signature"
        case .block:
            return "block move"
        case .zp:
            return "zero page"
        case .zpX:
            return "zero page indexed with x"
        case .zpY:
            return "zero page indexed with y"
        case .zpRel:
            return "relative bit branch"
        case .zpInd:
            return "zero page indirect"
        case .zpXInd:
            return "zero page indexed with x indirect"
        case .zpIndY:
            return "zero page indirect indexed with y"
        case .zpIndLong:
            return "zero page indirect long"
        case .zpIndLongY:
            return "zero page indirect long indexed with y"
        case .abs:
            return "absolute"
        case .absX:
            return "absolute indexed with x"
        case .absY:
            return "absolute indexed with y"
        case .absInd:
            return "absolute indirect"
        case .absXInd:
            return "absolute indexed with x indirect"
        case .absIndLong:
            return "absolute indirect long"
        case .absLong:
            return "absolute long"
        case .absLongX:
            return "absolute long indexed with x"
        case .sr:
            return "stack relative"
        case .srIndY:
            return "stack relative indirect indexed with y"
        }
    }
}

extension Mos65xxIns: InstructionType {}
