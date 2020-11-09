// For Capstone Engine. AUTO-GENERATED FILE, DO NOT EDIT (Evm)


/// EVM instruction
public enum EvmIns: UInt32 {
    case stop = 0
    case add = 1
    case mul = 2
    case sub = 3
    case div = 4
    case sdiv = 5
    case mod = 6
    case smod = 7
    case addmod = 8
    case mulmod = 9
    case exp = 10
    case signextend = 11
    case lt = 16
    case gt = 17
    case slt = 18
    case sgt = 19
    case eq = 20
    case iszero = 21
    case and = 22
    case or = 23
    case xor = 24
    case not = 25
    case byte = 26
    case sha3 = 32
    case address = 48
    case balance = 49
    case origin = 50
    case caller = 51
    case callvalue = 52
    case calldataload = 53
    case calldatasize = 54
    case calldatacopy = 55
    case codesize = 56
    case codecopy = 57
    case gasprice = 58
    case extcodesize = 59
    case extcodecopy = 60
    case returndatasize = 61
    case returndatacopy = 62
    case blockhash = 64
    case coinbase = 65
    case timestamp = 66
    case number = 67
    case difficulty = 68
    case gaslimit = 69
    case pop = 80
    case mload = 81
    case mstore = 82
    case mstore8 = 83
    case sload = 84
    case sstore = 85
    case jump = 86
    case jumpi = 87
    case pc = 88
    case msize = 89
    case gas = 90
    case jumpdest = 91
    case push1 = 96
    case push2 = 97
    case push3 = 98
    case push4 = 99
    case push5 = 100
    case push6 = 101
    case push7 = 102
    case push8 = 103
    case push9 = 104
    case push10 = 105
    case push11 = 106
    case push12 = 107
    case push13 = 108
    case push14 = 109
    case push15 = 110
    case push16 = 111
    case push17 = 112
    case push18 = 113
    case push19 = 114
    case push20 = 115
    case push21 = 116
    case push22 = 117
    case push23 = 118
    case push24 = 119
    case push25 = 120
    case push26 = 121
    case push27 = 122
    case push28 = 123
    case push29 = 124
    case push30 = 125
    case push31 = 126
    case push32 = 127
    case dup1 = 128
    case dup2 = 129
    case dup3 = 130
    case dup4 = 131
    case dup5 = 132
    case dup6 = 133
    case dup7 = 134
    case dup8 = 135
    case dup9 = 136
    case dup10 = 137
    case dup11 = 138
    case dup12 = 139
    case dup13 = 140
    case dup14 = 141
    case dup15 = 142
    case dup16 = 143
    case swap1 = 144
    case swap2 = 145
    case swap3 = 146
    case swap4 = 147
    case swap5 = 148
    case swap6 = 149
    case swap7 = 150
    case swap8 = 151
    case swap9 = 152
    case swap10 = 153
    case swap11 = 154
    case swap12 = 155
    case swap13 = 156
    case swap14 = 157
    case swap15 = 158
    case swap16 = 159
    case log0 = 160
    case log1 = 161
    case log2 = 162
    case log3 = 163
    case log4 = 164
    case create = 240
    case call = 241
    case callcode = 242
    case `return` = 243
    case delegatecall = 244
    case callblackbox = 245
    case staticcall = 250
    case revert = 253
    case suicide = 255
    case invalid = 512
    case ending = 513

}

/// Group of EVM instructions
public enum EvmGrp: UInt8 {
    /// = CS_GRP_INVALID
    case invalid = 0
    /// all jump instructions
    case jump = 1
    /// math instructions
    case math = 8
    /// instructions write to stack
    case stackWrite = 9
    /// instructions read from stack
    case stackRead = 10
    /// instructions write to memory
    case memWrite = 11
    /// instructions read from memory
    case memRead = 12
    /// instructions write to storage
    case storeWrite = 13
    /// instructions read from storage
    case storeRead = 14
    /// instructions halt execution
    case halt = 15
    /// <-- mark the end of the list of groups
    case ending = 16
}

