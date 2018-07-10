import XCTest
import TaggedTime

final class TaggedTimeTests: XCTestCase {
  func testSecondsToMilliseconds() {
    let seconds: Seconds<Int> = 12
    XCTAssertEqual(12000, seconds.milliseconds)
  }

  func testMillisecondsToSeconds() {
    let seconds: Milliseconds<Double> = 12000
    XCTAssertEqual(12.0, seconds.seconds)
  }
}
