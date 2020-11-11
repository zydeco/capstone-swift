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

    static var allTests = [
        ("testArm", testArm),
    ]
}
