import XCTest
/*@testable */import Capstone
import Ccapstone

final class CapstoneTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let version = Capstone.version
        print("Capstone version \(version)")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
