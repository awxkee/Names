import XCTest
@testable import NamesGenerator

final class NamesGeneratorTests: XCTestCase {
    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct
//        // results.
        let string = try NamesGenerator.generate()
        XCTAssertTrue(string.count > 0)
    }
}
