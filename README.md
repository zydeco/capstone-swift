# Capstone

Swift bindings for [Capstone Engine](https://www.capstone-engine.org).

Provides a complete swift-native wrapper for Capstone, without exposing the C API.

You need to have the capstone library and headers installed on your system.

* Swift 5.3
* Use the branch corresponding to your version of Capstone:
    * Version 4.x: `v4` branch:
    
    `.package(name:"Capstone", url: "https://github.com/zydeco/capstone-swift", .branch("v4"))`
    * `next` branch: `next` branch:
    
    `.package(name:"Capstone", url: "https://github.com/zydeco/capstone-swift", .branch("next"))`
* Include "Capstone" as a dependency for your executable target:
    ```swift
    let package = Package(
        // name, platforms, products, etc.
        dependencies: [
            .package(name: "Capstone", url: "https://github.com/zydeco/capstone-swift", .branch("v4")),
            // other dependencies
        ],
        targets: [
            .target(name: "<command-line-tool>", dependencies: [
                "Capstone",
            ]),
            // other targets
        ]
    )
    ```
* On macOS, you can install capstone with Homebrew:
    * `brew install capstone` for stable version (currently 4.0.2)
    * `brew install capstone --head` for `next` branch
* On Linux, build [Capstone 4.0.2](https://github.com/aquynh/capstone/releases/tag/4.0.2) or [next](https://github.com/aquynh/capstone/tree/next) branch from source.

## API Usage
1. Create an instance of `Capstone`, with the desired `Architecture` and `Mode`:
```swift
let capstone = try Capstone(arch: .arm, mode: [Mode.arm.thumb, Mode.arm.mClass])
```
2. Set `Options`s if needed:
```swift
try capstone.set(option: .detail(value: true))
```
3. Disassemble code:
    > Instructions are returned as an architecture-specific instruction class, which descends from `Instruction`
```swift
let code = Data([0xef, 0xf3, 0x02, 0x80])
let instructions: [ArmInstruction] = try capstone.disassemble(code: code, address: 0x1000)
```
4. Examine code:
```swift
for ins in instructions: {
    print("  \(ins.mnemonic) \(ins.operandsString)")
}
```

## Documentation

* [Documentation](https://namedfork.net/capstone-swift) is generated with [swift-doc](https://github.com/SwiftDocOrg/swift-doc).

## Examples

* See `Examples/cstool` for an implementation of [`cstool`](https://github.com/aquynh/capstone/tree/master/cstool) in Swift.

### Small example

```swift
import Capstone
import Foundation

// Code to disassemble
let code = Data([0x8d, 0x4c, 0x32, 0x08, 0x01, 0xd8, 0x81, 0xc6, 0x34, 0x12, 0x00, 0x00, 0x05, 0x23, 0x01, 0x00, 0x00, 0x36, 0x8b, 0x84, 0x91, 0x23, 0x01, 0x00, 0x00, 0x41, 0x8d, 0x84, 0x39, 0x89, 0x67, 0x00, 0x00, 0x8d, 0x87, 0x89, 0x67, 0x00, 0x00, 0xb4, 0xc6, 0xe9, 0xea, 0xbe, 0xad, 0xde, 0xff, 0xa0, 0x23, 0x01, 0x00, 0x00, 0xe8, 0xdf, 0xbe, 0xad, 0xde, 0x74, 0xff])

// Create instance of capstone
let capstone = try Capstone(arch: .x86, mode: Mode.bits.b32)

// Enable detail mode to get instruction groups and operands
try capstone.set(option: .detail(value: true))

// Disassemble instructions
let instructions: [X86Instruction] = try capstone.disassemble(code: code, address: 0x1000)

// Iterate through instructions
var insCountByGroup: [X86Grp: Int] = [:]
var opCountByType: [X86Op: Int] = [:]
print("Disassembly:")
for ins in instructions {
    print("  \(ins.mnemonic) \(ins.operandsString)")

    // Count by instruction groups
    insCountByGroup.merge(ins.groups.map({ ($0, 1) }), uniquingKeysWith: +)

    // Count operands by type
    opCountByType.merge(ins.operands.map({ ($0.type, 1) }), uniquingKeysWith: +)
}

// Print results
print("Instructions by group:")
for (group, count) in insCountByGroup {
    print("  \(group): \(count)")
}

print("Operands by type:")
for (type, count) in opCountByType {
    print("  \(type): \(count)")
}
```
