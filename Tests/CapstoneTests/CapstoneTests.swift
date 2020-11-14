import XCTest
import Capstone

final class CapstoneTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let version = Capstone.version
        print("Capstone version \(version)")
    }
    
    func testArm() throws {
        try Tests.armTests.run(address: 0x80001000)
    }

    func testArm64() throws {
        try Tests.arm64Tests.run(address: 0x2c)
    }
    
    func testPpc() throws {
        try Tests.ppcTests.run(address: 0x1000)
    }
    
    func testX86() throws {
        try Tests.x86Tests.run(address: 0x1000)
    }
    
    func testM68k() throws {
        try Tests.m68kTests.run(address: 0x1000)
    }
    
    func testSparc() throws {
        try Tests.sparcTests.run(address: 0x1000)
    }
    
    func testEvm() throws {
        try Tests.evmTests.run(address: 0x80001000)
    }
    
    func testMips() throws {
        try Tests.mipsTests.run(address: 0x1000)
    }
    
    static var allTests = [
        ("testArm", testArm),
        ("testArm64", testArm64),
        ("testPpc", testPpc),
        ("testX86", testX86),
        ("testM68k", testM68k),
        ("testSparc", testSparc),
        ("testEvm", testEvm),
        ("testMips", testMips),
    ]
}

extension Array where Element == PlatformTest {
    func run(address: UInt64) throws {
        try forEach({ try $0.run(address: address )})
    }
}
