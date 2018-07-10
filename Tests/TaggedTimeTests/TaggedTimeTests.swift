import XCTest
import TaggedTime

final class TaggedTimeTests: XCTestCase {
  func testSecondsToMilliseconds() {
    let seconds: Seconds<Int> = 12
    XCTAssertEqual(12000, seconds.milliseconds)
  }

  func testMillisecondsToSeconds() {
    let milliseconds: Milliseconds<Double> = 12000
    XCTAssertEqual(12.0, milliseconds.seconds)
  }

  func testDate() {
    let seconds: Seconds<Int> = 12
    XCTAssertEqual(Date(timeIntervalSince1970: 12), seconds.date)

    let milliseconds: Milliseconds<Double> = 12000
    XCTAssertEqual(Date(timeIntervalSince1970: 12), milliseconds.date)
  }

  func testLossyMillisecondsToSeconds() {
    let milliseconds: Milliseconds<Int> = 12500
    let seconds = milliseconds.map(Double.init).seconds.map(Int.init)
    XCTAssertEqual(12, seconds)
  }
}
