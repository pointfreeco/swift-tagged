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

  func testMillisecondsToTimeInterval() {
    let milliseconds: Milliseconds<Int> = 12000
    XCTAssertEqual(12.0, milliseconds.timeInterval)
  }

  func testMillisecondsToDate() {
    let milliseconds: Milliseconds<Int> = 12000
    XCTAssertEqual(Date(timeIntervalSince1970: 12), milliseconds.date)
  }

  func testSecondsSince() {
    let date1 = Date(timeIntervalSince1970: 12)
    let date2 = Date(timeIntervalSince1970: 15)
    XCTAssertEqual(3, date2.secondsSince(date1))
  }

  func testMillisecondsSince() {
    let date1 = Date(timeIntervalSince1970: 12)
    let date2 = Date(timeIntervalSince1970: 15)
    XCTAssertEqual(3000, date2.millisecondsSince(date1))
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
