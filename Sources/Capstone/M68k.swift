import Ccapstone

extension M68kInstruction: OperandContainer {
    /// Instruction operands.
    ///
    /// Empty when detail mode is off.
    public var operands: [Operand] {
        let operands: [cs_m68k_op] = readDetailsArray(array: detail?.m68k.operands, size: detail?.m68k.op_count)
        return operands.map({ Operand(op: $0) })
    }

    /// Size the data operand works on in bytes (.b, .w, .l).
    ///
    /// `nil` when detail mode is off.
    public var operationSize: OperationSize! {
        guard let size = detail?.m68k.op_size, size.type != M68K_SIZE_TYPE_INVALID else {
            return nil
        }
        switch size.type {
        case M68K_SIZE_TYPE_CPU:
            return .cpu(size: enumCast(size.cpu_size))
        case M68K_SIZE_TYPE_FPU:
            return .fpu(size: enumCast(size.fpu_size))
        default:
            return nil
        }
    }

    /// Operation size of the current instruction (NOT the size of the instruction)
    public enum OperationSize {
        case cpu(size: M68kCpuSize)
        case fpu(size: M68kFpuSize)
    }

    /// Operand for M68k instructions.
    ///
    /// The operand's value can be accessed by the `value` property, or by a property corresponding to the operand's type:
    /// - `register` or `registers` for `reg` operands.
    /// - `immediateValue` for `imm` operands.
    /// - `floatValue` for `fpSingle` operands.
    /// - `doubleValue` for `fpDouble` operands.
    /// - `registerList` or `registers` for `regBits` operands.
    /// - `registerPair` or `registers` for `regPair` operands.
    /// - `brDisp` for `branchDisplacement` operands.
    public struct Operand: InstructionOperand {
        internal let op: cs_m68k_op

        /// Operand type.
        public var type: M68kOp { enumCast(op.type) }

        /// M68K addressing mode for this op.
        public var addressingMode: M68kAm {
            enumCast(op.address_mode)
        }

        /// Operand value.
        public var value: M68kOperandValue {
            switch type {
            case .reg:
                return register
            case .imm:
                return immediateValue
            case .mem:
                return memory
            case .fpSingle:
                return floatValue
            case .fpDouble:
                return doubleValue
            case .regBits:
                return registerList
            case .regPair:
                return registerPair
            case .brDisp:
                return branchDisplacement
            default:
                fatalError("Invalid m68k operand type \(type.rawValue)")
            }
        }

        /// Immediate value for `imm` operand.
        ///
        /// `nil` when not an appropriate operand.
        public var immediateValue: UInt64! {
            guard type == .imm else {
                return nil
            }
            return op.imm
        }

        /// Immediate value for `fpDouble` operand.
        ///
        /// `nil` when not an appropriate operand.
        public var doubleValue: Double! {
            guard type == .fpDouble else {
                return nil
            }
            return op.dimm
        }

        /// Immediate value for `fpSingle` operand.
        ///
        /// `nil` when not an appropriate operand.
        public var floatValue: Float! {
            guard type == .fpSingle else {
                return nil
            }
            return op.simm
        }

        /// Register value for `reg` operand.
        ///
        /// `nil` when not an appropriate operand.
        public var register: M68kReg! {
            guard type == .reg else {
                return nil
            }
            return enumCast(op.reg)
        }

        /// Register pair for `regPair` operand.
        ///
        /// `nil` when not an appropriate operand.
        public var registerPair: [M68kReg]! {
            guard type == .regPair else {
                return nil
            }
            return [enumCast(op.reg_pair.reg_0), enumCast(op.reg_pair.reg_1)]
        }

        /// Register list for `regBits` operand.
        ///
        /// `nil` when not an appropriate operand.
        public var registerList: [M68kReg]! {
            guard type == .regBits else {
                return nil
            }
            // register bits for movem etc. (always in d0-d7, a0-a7, fp0 - fp7 order)
            return (1...24)
                .filter({ (op.register_bits & UInt32(1 << ($0 - 1))) != 0 })
                .map({ M68kReg(rawValue: $0)! })
        }

        /// Registers for `reg`, `regPair` or `regBits` operand..
        ///
        /// `nil` when not an appropriate operand.
        public var registers: [M68kReg]! {
            switch type {
            case .reg:
                return [register]
            case .regPair:
                return registerPair
            case .regBits:
                return registerList
            default:
                return nil
            }
        }

        /// Data when operand is targeting memory.
        ///
        /// `nil` when not an appropriate operand.
        public var memory: Memory! {
            guard type == .mem else {
                return nil
            }
            return Memory(op.mem)
        }

        /// Data when operand is a branch displacement
        public var branchDisplacement: BranchDisplacement! {
            guard type == .brDisp else {
                return nil
            }
            return BranchDisplacement(op.br_disp)
        }

        /// Instruction operand referring to memory
        public struct Memory {
            /// Base register
            public let base: M68kReg?
            /// Index information
            public let index: (register: M68kReg, scale: UInt8, size: M68kCpuSize)?
            /// Indirect base register
            public let indirectBase: M68kReg?
            /// Indirect displacement
            public let baseDisplacement: UInt32
            /// Outer displacement
            public let outerDisplacement: UInt32
            /// Displacement value
            public let displacement: Int16
            /// Used for bf* instructions
            public let bitField: (width: UInt8, offset: UInt8)?

            init(_ mem: m68k_op_mem) {
                base = optionalEnumCast(mem.base_reg, ignoring: M68K_REG_INVALID)
                if mem.index_reg != M68K_REG_INVALID {
                    index = (
                        register: enumCast(mem.index_reg),
                        scale: mem.scale,
                        size: mem.index_size == 0 ? .word : .long
                    )
                } else {
                    index = nil
                }
                indirectBase = optionalEnumCast(mem.in_base_reg, ignoring: M68K_REG_INVALID)
                baseDisplacement = mem.in_disp
                outerDisplacement = mem.out_disp
                displacement = mem.disp
                if mem.bitfield != 0 {
                    bitField = (
                        width: mem.width,
                        offset: mem.offset
                    )
                } else {
                    bitField = nil
                }
            }
        }

        /// Data when operand is a branch displacement
        public struct BranchDisplacement {
            public let size: M68kOpBrDispSize
            public let value: Int32

            init(_ disp: m68k_op_br_disp) {
                size = enumCast(disp.disp_size)
                value = disp.disp
            }
        }
    }
}

public protocol M68kOperandValue {}
extension UInt64: M68kOperandValue {}
extension Double: M68kOperandValue {}
extension Float: M68kOperandValue {}
extension M68kReg: M68kOperandValue {}
extension Array: M68kOperandValue where Element == M68kReg {
    public var registerBits: UInt32 {
        // register bits for movem etc. (always in d0-d7, a0-a7, fp0 - fp7 order)
        map({ UInt32(1 << ($0.rawValue - 1)) }).reduce(0, { $0 + $1 })
    }
}
extension M68kInstruction.Operand.Memory: M68kOperandValue {}
extension M68kInstruction.Operand.BranchDisplacement: M68kOperandValue {}

extension M68kAm: CustomStringConvertible {
    public var description: String {
        switch self {
        case .none:
            return "None"
        case .regDirectData:
            return "Register Direct - Data"
        case .regDirectAddr:
            return "Register Direct - Address"
        case .regiAddr:
            return "Register Indirect - Address"
        case .regiAddrPostInc:
            return "Register Indirect - Address with Postincrement"
        case .regiAddrPreDec:
            return "Register Indirect - Address with Predecrement"
        case .regiAddrDisp:
            return "Register Indirect - Address with Displacement"
        case .aregiIndex8BitDisp:
            return "Address Register Indirect With Index - 8-bit displacement"
        case .aregiIndexBaseDisp:
            return "Address Register Indirect With Index - Base displacement"
        case .memiPostIndex:
            return "Memory indirect - Postindex"
        case .memiPreIndex:
            return "Memory indirect - Preindex"
        case .pciDisp:
            return "Program Counter Indirect - with Displacement"
        case .pciIndex8BitDisp:
            return "Program Counter Indirect with Index - with 8-Bit Displacement"
        case .pciIndexBaseDisp:
            return "Program Counter Indirect with Index - with Base Displacement"
        case .pcMemiPostIndex:
            return "Program Counter Memory Indirect - Postindexed"
        case .pcMemiPreIndex:
            return "Program Counter Memory Indirect - Preindexed"
        case .absoluteDataShort:
            return "Absolute Data Addressing  - Short"
        case .absoluteDataLong:
            return "Absolute Data Addressing  - Long"
        case .immediate:
            return "Immediate value"
        case .branchDisplacement:
            return "Address as displacement from (PC+2)"
        }
    }
}

extension M68kIns: InstructionType {}
