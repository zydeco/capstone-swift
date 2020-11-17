import Ccapstone

extension EthereumInstruction {
    /// number of items popped from the stack
    public var pop: UInt8! { detail?.evm.pop }

    /// number of items pushed into the stack
    public var push: UInt8! { detail?.evm.push }

    /// gas fee for the instruction
    public var fee: UInt32! { detail?.evm.fee }
}

extension EvmIns: InstructionType {}
