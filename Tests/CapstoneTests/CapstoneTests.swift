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
        try Tests.armTests.forEach({ try $0.run(address: 0x80001000 )})
    }

    func testArm64() throws {
        try Tests.arm64Tests.forEach({ try $0.run(address: 0x2c )})
    }
    
    func testPpc() throws {
        try Tests.ppcTests.forEach({ try $0.run(address: 0x1000 )})
    }
    
    func testX86() throws {
        try Tests.x86Tests.forEach({ try $0.run(address: 0x1000 )})
    }
    
    static var allTests = [
        ("testArm", testArm),
        ("testArm64", testArm64),
        ("testPpc", testPpc),
        ("testX86", testX86),
    ]
}
