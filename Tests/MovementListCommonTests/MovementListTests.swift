import XCTest
@testable import MovementList

final class MovementListTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(MovementList().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
