import Ccapstone

extension WasmInstruction: OperandContainer {
    /// Instruction operands.
    ///
    /// Empty when detail mode is off.
    public var operands: [Operand] {
        let operands: [cs_wasm_op] = readDetailsArray(array: detail?.wasm.operands, size: detail?.wasm.op_count)
        return operands.map({ Operand(op: $0) })
    }

    /// Operand for WASM instructions.
    ///
    /// The operand's value can be accessed by the `value` property, or by a property corresponding to the operand's type:
    /// - `int7Value` for `int7` operands.
    /// - `uint32Value` for `varuint32` or `uint32` operands
    /// - `uint64Value` for `varuint64` or  `uint64` operands
    /// - `branchTableValue` for `brtable` operands
    /// - `immediateValues` for `imm` operands
    public struct Operand: InstructionOperand {
        internal let op: cs_wasm_op

        /// Operand type.
        public var type: WasmOp { enumCast(op.type) }

        /// Operand value.
        public var value: WasmOperandValue {
            switch type {
            // can an operand type be none?
            case .int7:
                return int7Value
            case .uint32, .varuint32:
                return uint32Value
            case .uint64, .varuint64:
                return uint64Value
            case .imm:
                return immediateValues
            case .brtable:
                return branchTableValue
            default:
                fatalError("Invalid wasm operand type \(type.rawValue)")
            }
        }

        /// Operand size.
        public var size: UInt32 {
            op.size
        }

        /// Value for `int7` operand.
        public var int7Value: Int8! {
            guard type == .int7 else {
                return nil
            }
            return op.int7
        }

        /// Value for `uint32` or `varuint32` operand.
        public var uint32Value: UInt32! {
            switch type {
            case .uint32:
                return op.uint32
            case .varuint32:
                return op.varuint32
            default:
                return nil
            }
        }

        /// Value for `uint64` or `varuint64` operand.
        public var uint64Value: UInt64! {
            switch type {
            case .uint64:
                return op.uint64
            case .varuint64:
                return op.varuint64
            default:
                return nil
            }
        }

        /// Values for `imm` operand.
        public var immediateValues: [UInt32]! {
            guard type == .imm else {
                return nil
            }
            return [op.immediate.0, op.immediate.1]
        }

        /// Value for `brtable` operand.
        public var branchTableValue: BranchTable! {
            guard type == .brtable else {
                return nil
            }
            return BranchTable(
                length: op.brtable.length,
                address: op.brtable.address,
                defaultTarget: op.brtable.default_target
            )
        }

        public struct BranchTable: WasmOperandValue {
            public let length: UInt32
            public let address: UInt64
            public let defaultTarget: UInt32
        }
    }
}

public protocol WasmOperandValue {}
extension Int8: WasmOperandValue {}
extension UInt32: WasmOperandValue {}
extension UInt64: WasmOperandValue {}
extension Array: WasmOperandValue where Element == UInt32 {}

extension WasmIns: InstructionType {}
