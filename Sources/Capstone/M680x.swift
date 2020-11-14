import Ccapstone

extension M680xInstruction: OperandContainer {
    public var operands: [Operand] {
        let operands: [cs_m680x_op] = readDetailsArray(array: detail?.m680x.operands, size: detail?.m680x.op_count)
        return operands.enumerated().map({ Operand(op: $0.element, isInMnemonic: isOperandInMnemonic(index: $0.offset)) })
    }

    /// Flags indicating if operands are part of the mnemonic
    public var opFlags: M680xOpFlags! {
        optionalEnumCast(detail?.m680x.flags)
    }
    
    public func isOperandInMnemonic(index: Int) -> Bool {
        guard let flags = opFlags else {
            return false
        }
        return (index == 0 && flags.contains(.firstOpInMnem)) || (index == 1 && flags.contains(.secondOpInMnem))
    }
    
    public struct Operand: InstructionOperand {
        internal let op: cs_m680x_op
        public var isInMnemonic: Bool
        
        public var type: M680xOp { enumCast(op.type) }
        
        /// size of this operand (in bytes)
        public var size: UInt8 { op.size }

        /// Operand access mode
        public var access: Access { enumCast(op.access) }
        
        public var value: M680xOperandValue {
            switch type {
            case .immediate:
                return immediateValue
            case .register:
                return register
            case .indexed:
                return indexedAddress
            case .relative:
                return relativeAddress
            case .extended:
                return extendedAddress
            case .direct:
                return directAddress
            case .constant:
                return constantValue
            default:
                fatalError("Invalid m680x operand type \(type.rawValue)")
            }
        }
        
        /// Register value for register operand
        public var register: M680xReg! {
            guard type == .register else {
                return nil
            }
            return enumCast(op.reg)
        }
        
        /// Immediate value for immediate operand
        public var immediateValue: Int32! {
            guard type == .immediate else {
                return nil
            }
            return op.imm
        }
        
        /// Indexed addressing operand
        public var indexedAddress: IndexedAddress! {
            guard type == .indexed else {
                return nil
            }
            return IndexedAddress(op.idx)
        }
        
        /// Relative addressing operand (Bcc/LBcc)
        public var relativeAddress: RelativeAddress! {
            guard type == .relative else {
                return nil
            }
            return RelativeAddress(
                address: op.rel.address,
                offset: op.rel.offset
            )
        }
        
        /// Extended address
        public var extendedAddress: ExtendedAddress! {
            guard type == .extended else {
                return nil
            }
            return ExtendedAddress(
                address: op.ext.address,
                indirect: op.ext.indirect
            )
        }
        
        /// Direct address
        public var directAddress: UInt16! {
            guard type == .direct else {
                return nil
            }
            return UInt16(op.direct_addr)
        }
        
        /// Constant value (bit index, page nr.)
        public var constantValue: UInt8! {
            guard type == .constant else {
                return nil
            }
            return op.const_val
        }
        
        /// Instruction's operand referring to indexed addressing
        public struct IndexedAddress {
            public let base: M680xReg?
            public let offset: (register: M680xReg?, width: M680xOffset, value: Int16, address: UInt16)
            /// Increment or decrement (-8 to 8)
            /// post-inc/decrement if flag `postIncDec` set, otherwise pre-inc/decrement
            public let incDec: Int8
            public let flags: M680xIdx
            
            public var indirect: Bool { flags.contains(.indirect) }
            /// true if post-increment or post-decrement
            public var post: Bool { flags.contains(.postIncDec) }
            /// true if pre-increment or pre-decrement
            public var pre: Bool { !post }
            
            init(_ idx: m680x_op_idx) {
                base = optionalEnumCast(idx.base_reg, ignoring: M680X_REG_INVALID)
                offset = (
                    register: optionalEnumCast(idx.offset_reg, ignoring: M680X_REG_INVALID),
                    width: enumCast(idx.offset_bits),
                    value: idx.offset,
                    address: idx.offset_addr
                )
                incDec = idx.inc_dec
                flags = enumCast(idx.flags)
            }
        }
        
        /// Instruction's memory operand referring to relative addressing (Bcc/LBcc)
        public struct RelativeAddress {
            /// The absolute address, calculated as PC + offset.
            /// PC is the first address after the instruction.
            public let address: UInt16
            /// the offset/displacement value
            public let offset: Int16
        }
        
        /// Instruction's operand referring to extended addressing
        public struct ExtendedAddress {
            /// The absolute address
            public let address: UInt16
            /// true if extended indirect addressing
            public let indirect: Bool
        }
    }
}

public protocol M680xOperandValue {}
extension M680xReg: M680xOperandValue {}
extension Int32: M680xOperandValue {}
extension M680xInstruction.Operand.IndexedAddress: M680xOperandValue {}
extension M680xInstruction.Operand.RelativeAddress: M680xOperandValue {}
extension M680xInstruction.Operand.ExtendedAddress: M680xOperandValue {}
extension UInt16: M680xOperandValue {}
extension UInt8: M680xOperandValue {}
