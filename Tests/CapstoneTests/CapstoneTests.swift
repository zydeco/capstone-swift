import XCTest
/*@testable */import Capstone
import Ccapstone

final class CapstoneTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let version = Capstone.version
        print("Capstone version \(version)")
        
        let capstone = try Capstone(arch: .arm, mode: [Mode.endian.little, Mode.arm.thumb])
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
