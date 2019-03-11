import XCTest
import TaggedMoney

final class TaggedTimeTests: XCTestCase {
  func testDollarsToCents() {
    let dollars: Dollars<Int> = 12
    XCTAssertEqual(1200, dollars.cents)
  }

  func testCentsToDollars() {
    let cents: Cents<Double> = 1200
    XCTAssertEqual(12.0, cents.dollars)
  }
}
