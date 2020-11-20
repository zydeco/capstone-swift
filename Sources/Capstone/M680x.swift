import Ccapstone

extension M680xInstruction: OperandContainer {
    /// Instruction operands.
    ///
    /// Empty when detail mode is off.
    public var operands: [Operand] {
        let operands: [cs_m680x_op] = readDetailsArray(array: detail?.m680x.operands, size: detail?.m680x.op_count)
        return operands.enumerated().map({ Operand(op: $0.element, isInMnemonic: isOperandInMnemonic(index: $0.offset)) })
    }

    /// Flags indicating if operands are part of the mnemonic.
    ///
    /// `nil` when detail mode is off.
    public var opFlags: M680xOpFlags! {
        optionalEnumCast(detail?.m680x.flags)
    }

    /// Check if an operand is part of the mnemonic.
    ///
    /// Some instructions can have implicit operands expressed as part of the mnemonic.
    /// Example: `suba $10` has two operands: register A (implicit), and direct address $10.
    /// - parameter index: operand to check for
    /// - returns: `true` iff detail mode is on, and the operand is encoded in the mnemonic
    func isOperandInMnemonic(index: Int) -> Bool {
        guard let flags = opFlags else {
            return false
        }
        return (index == 0 && flags.contains(.firstOpInMnem)) || (index == 1 && flags.contains(.secondOpInMnem))
    }

    /// Operand for M680x instructions.
    ///
    /// The operand's value can be accessed by the `value` property, or by a property corresponding to the operand's type:
    /// - `register` or `registers` for `reg` operands.
    /// - `immediateValue` for `imm` operands.
    /// - `constantValue` for `constant` operands.
    /// - `indexedAddress` for `indexed` operands.
    /// - `relativeAddress` for `relative` operands.
    /// - `extendedAddress` for `extended` operands.
    /// - `directAddress` for `direct` operands.
    public struct Operand: InstructionOperand {
        internal let op: cs_m680x_op

        /// `true` if the operand is implicit in the mnemonic.
        public var isInMnemonic: Bool

        /// Operand type.
        public var type: M680xOp { enumCast(op.type) }

        /// Size of this operand (in bytes).
        public var size: UInt8 { op.size }

        /// Operand access mode.
        public var access: Access { enumCast(op.access) }

        /// Operand value.
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

        /// Register value for `register` operand.
        ///
        /// `nil` when not an appropriate operand.
        public var register: M680xReg! {
            guard type == .register else {
                return nil
            }
            return enumCast(op.reg)
        }

        /// Immediate value for `immediate` operand.
        ///
        /// `nil` when not an appropriate operand.
        public var immediateValue: Int32! {
            guard type == .immediate else {
                return nil
            }
            return op.imm
        }

        /// Indexed addressing operand.
        ///
        /// `nil` when not an appropriate operand.
        public var indexedAddress: IndexedAddress! {
            guard type == .indexed else {
                return nil
            }
            return IndexedAddress(op.idx)
        }

        /// Relative addressing operand (Bcc/LBcc).
        ///
        /// `nil` when not an appropriate operand.
        public var relativeAddress: RelativeAddress! {
            guard type == .relative else {
                return nil
            }
            return RelativeAddress(
                address: op.rel.address,
                offset: op.rel.offset
            )
        }

        /// Extended address.
        ///
        /// `nil` when not an appropriate operand.
        public var extendedAddress: ExtendedAddress! {
            guard type == .extended else {
                return nil
            }
            return ExtendedAddress(
                address: op.ext.address,
                indirect: op.ext.indirect
            )
        }

        /// Direct address.
        ///
        /// `nil` when not an appropriate operand.
        public var directAddress: UInt16! {
            guard type == .direct else {
                return nil
            }
            return UInt16(op.direct_addr)
        }

        /// Constant value (bit index, page nr.).
        ///
        /// `nil` when not an appropriate operand.
        public var constantValue: UInt8! {
            guard type == .constant else {
                return nil
            }
            return op.const_val
        }

        /// Operand referring to indexed addressing.
        public struct IndexedAddress {
            public let base: M680xReg?
            public let offset: (register: M680xReg?, width: M680xOffset, value: Int16, address: UInt16)

            /// Increment or decrement (-8 to 8).
            ///
            /// `post` or `pre` tell if it's pre-increment/decrement or post-increment/decrement.
            public let incDec: Int8
            /// Indexed addressing flags.
            public let flags: M680xIdx

            public var indirect: Bool { flags.contains(.indirect) }
            /// `true` if post-increment or post-decrement.
            public var post: Bool { flags.contains(.postIncDec) }
            /// `true` if pre-increment or pre-decrement.
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

        /// Operand referring to relative addressing (Bcc/LBcc).
        public struct RelativeAddress {
            /// The absolute address, calculated as PC + offset.
            ///
            /// PC is the first address after the instruction.
            public let address: UInt16
            /// the offset/displacement value.
            public let offset: Int16
        }

        /// Operand referring to extended addressing.
        public struct ExtendedAddress {
            /// The absolute address.
            public let address: UInt16
            /// `true` if extended indirect addressing.
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

extension M680xIns: InstructionType {}
