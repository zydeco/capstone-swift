import XCTest
import class Foundation.Bundle

final class CSToolTests: XCTestCase {
    private func run(arguments: [String]) throws -> (exitCode: Int32, output: String?) {
        // Some of the APIs that we use below are available in macOS 10.13 and above.
        guard #available(macOS 10.13, *) else {
            return (0, nil)
        }

        let process = Process()
        process.executableURL = productsDirectory.appendingPathComponent("cstool")
        if !arguments.isEmpty {
            process.arguments = arguments
        }

        let pipe = Pipe()
        process.standardOutput = pipe

        try process.run()
        process.waitUntilExit()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)

        return (process.terminationStatus, output)
    }

    func assertRun(arguments: [String], outputs expectedOutput: String, exitCode: Int32) throws {
        let result = try run(arguments: arguments)
        XCTAssertEqual(result.exitCode, exitCode)
        XCTAssertEqual(result.output, expectedOutput)
    }

    func testHexParsing() throws {
        let expectedOutput = """
         0  90           nop\t
         1  91           xchg\tecx, eax\n
        """
        try assertRun(arguments: ["x32", "0x90 0x91"], outputs: expectedOutput, exitCode: 0)
        try assertRun(arguments: ["x32", "\\x90\\x91"], outputs: expectedOutput, exitCode: 0)
        try assertRun(arguments: ["x32", "90,91"], outputs: expectedOutput, exitCode: 0)
        try assertRun(arguments: ["x32", "90;91"], outputs: expectedOutput, exitCode: 0)
        try assertRun(arguments: ["x32", "90+91"], outputs: expectedOutput, exitCode: 0)
        try assertRun(arguments: ["x32", "90:91"], outputs: expectedOutput, exitCode: 0)
    }

    /// Returns path to the built products directory.
    var productsDirectory: URL {
      #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
      #else
        return Bundle.main.bundleURL
      #endif
    }

    static var allTests = [
        ("testHexParsing", testHexParsing)
    ]
}
