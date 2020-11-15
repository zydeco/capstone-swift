import Ccapstone

extension TMS320C64xInstruction: OperandContainer {
    public var operands: [Operand] {
        let operands: [cs_tms320c64x_op] = readDetailsArray(array: detail?.tms320c64x.operands, size: detail?.tms320c64x.op_count)
        return operands.map({ Operand(op: $0) })
    }
    
    /// Condition
    public var condition: (register: Tms320c64xReg, zero: Bool)! {
        guard let cc = detail?.tms320c64x.condition, cc.reg != 0 else {
            return nil
        }
        return (register: enumCast(cc.reg), zero: cc.zero != 0)
    }
    
    /// Functional Unit
    public var functionalUnit: FunctionalUnit! {
        guard let funit = detail?.tms320c64x.funit, funit.unit != 0 else {
            return nil
        }
        return FunctionalUnit(unit: enumCast(funit.unit), side: funit.side)
    }
    
    /// Cross path
    public var crossPath: Bool! {
        guard let value = detail?.tms320c64x.funit.crosspath else {
            return nil
        }
        return value == 1
    }
    
    /// Parallel
    public var parallel: Bool! {
        guard let value = detail?.tms320c64x.parallel else {
            return nil
        }
        return value == 1
    }
    
    public struct FunctionalUnit {
        let unit: Tms320c64xFunit
        let side: UInt32
    }
    
    /// Instruction operand
    public struct Operand: InstructionOperand {
        internal let op: cs_tms320c64x_op
        
        public var type: Tms320c64xOp { enumCast(op.type) }

        public var value: Tms320c64xOperandValue {
            switch type {
            case .imm:
                return immediateValue
            case .reg:
                return register
            case .mem:
                return memory
            case .regpair:
                return registerPair
            default:
                fatalError("Invalid tms320c64x operand type \(type.rawValue)")
            }
        }
        
        /// Register value for register operand
        public var register: Tms320c64xReg! {
            guard type == .reg else {
                return nil
            }
            return enumCast(op.reg)
        }
        
        /// Register values for register pair operand
        public var registerPair: [Tms320c64xReg]! {
            guard type == .regpair else {
                return nil
            }
            return [enumCast(op.reg+1), enumCast(op.reg)]
        }
        
        /// Immediate value for immediate operand
        public var immediateValue: Int32! {
            guard type == .imm else {
                return nil
            }
            return op.imm
        }
        
        public var memory: Memory! {
            guard type == .mem else {
                return nil
            }
            return Memory(op.mem)
        }
        
        /// Instruction's operand referring to memory
        public struct Memory {
            public let base: Tms320c64xReg
            /// Displacement
            public let displacement: Displacement
            /// Unit of base and offset register
            public let unit: UInt32
            /// Offset scaled
            public let scaled: UInt32
            /// Direction
            public let direction: Tms320c64xMemDir
            /// Modification
            public let modification: Tms320c64xMemMod
            
            /// Displacement type and value
            public enum Displacement {
                case constant(value: UInt32)
                case register(register: Tms320c64xReg)
            }
            
            init(_ mem: tms320c64x_op_mem) {
                base = enumCast(mem.base)
                switch mem.disptype {
                case TMS320C64X_MEM_DISP_CONSTANT.rawValue:
                    displacement = .constant(value: mem.disp)
                case TMS320C64X_MEM_DISP_REGISTER.rawValue:
                    displacement = .register(register: enumCast(mem.disp))
                default:
                    fatalError("Invalid tms320c64x displacement type: \(mem.disptype)")
                }
                unit = mem.unit
                scaled = mem.scaled
                direction = enumCast(mem.direction)
                modification = enumCast(mem.modify)
            }
        }
    }
}

public protocol Tms320c64xOperandValue {}
extension Tms320c64xReg: Tms320c64xOperandValue {}
extension Array: Tms320c64xOperandValue where Element == Tms320c64xReg {}
extension Int32: Tms320c64xOperandValue {}
extension TMS320C64xInstruction.Operand.Memory: Tms320c64xOperandValue {}

extension TMS320C64xInstruction.FunctionalUnit: CustomStringConvertible {
    public var description: String {
        switch unit {
        case .invalid:
            return "Invalid"
        case .no:
            return "No Functional Unit"
        default:
            return "\(unit)\(side)".uppercased()
        }
    }
}

extension Tms320c64xMemDir: CustomStringConvertible {
    public var description: String {
        switch self {
        case .fw:
            return "Forward"
        case .bw:
            return "Backward"
        case .invalid:
            return "Invalid"
        }
    }
}

extension Tms320c64xMemMod: CustomStringConvertible {
    public var description: String {
        switch self {
        case .invalid:
            return "Invalid"
        case .no:
            return "No"
        case .pre:
            return "Pre"
        case .post:
            return "Post"
        }
    }
}

extension Tms320c64xIns: InstructionType {}
