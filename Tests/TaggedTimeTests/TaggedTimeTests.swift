import XCTest
import TaggedTime

final class TaggedTimeTests: XCTestCase {
  func testMinutesToSeconds() {
    let minutes: Minutes<Int> = 12
    XCTAssertEqual(720, minutes.seconds)
  }
    
  func testSecondsToMilliseconds() {
    let seconds: Seconds<Int> = 12
    XCTAssertEqual(12000, seconds.milliseconds)
  }
    
  func testSecondsToMinutes() {
    let seconds: Seconds<Int> = 120
    XCTAssertEqual(2, seconds.minutes)
  }

  func testMillisecondsToSeconds() {
    let milliseconds: Milliseconds<Double> = 12000
    XCTAssertEqual(12.0, milliseconds.seconds)
  }
    
  func testMillisecondsToMinutes() {
    let milliseconds: Milliseconds<Double> = 120000
    XCTAssertEqual(2, milliseconds.minutes)
  }
    
  func testMillisecondsToTimeInterval() {
    let milliseconds: Milliseconds<Int> = 12000
    XCTAssertEqual(12.0, milliseconds.timeInterval)
  }
      
  func testSecondsToTimeInterval() {
    let seconds: Seconds<Int> = 120
    XCTAssertEqual(120, seconds.timeInterval)
  }
    
  func testMinutesToTimeInterval() {
    let minutes: Minutes<Int> = 12
    XCTAssertEqual(720, minutes.timeInterval)
  }
    
  func testMillisecondsToDate() {
    let milliseconds: Milliseconds<Int> = 12000
    XCTAssertEqual(Date(timeIntervalSince1970: 12), milliseconds.date)
  }
    
  func testSecondsToDate() {
    let seconds: Seconds<Int> = 120
    XCTAssertEqual(Date(timeIntervalSince1970: 120), seconds.date)
  }
    
  func testMinutesToDate() {
    let minutes: Minutes<Int> = 12
    XCTAssertEqual(Date(timeIntervalSince1970: 720), minutes.date)
  }
    
  func testMinutesSince() {
    let date1 = Date(timeIntervalSince1970: 5)
    let date2 = Date(timeIntervalSince1970: 125)
    XCTAssertEqual(2, date2.minutesSince(date1))
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
    let minutes: Minutes<Int> = 2
    XCTAssertEqual(Date(timeIntervalSince1970: 120), minutes.date)

    let seconds: Seconds<Int> = 12
    XCTAssertEqual(Date(timeIntervalSince1970: 12), seconds.date)

    let milliseconds: Milliseconds<Double> = 12000
    XCTAssertEqual(Date(timeIntervalSince1970: 12), milliseconds.date)
  }

  func testLossyMillisecondsToSeconds() {
    let milliseconds: Milliseconds<Int> = 120500
    let seconds = milliseconds.map(Double.init).seconds.map(Int.init)
    let minutes = milliseconds.map(Double.init).minutes.map(Int.init)

    XCTAssertEqual(120, seconds)
    XCTAssertEqual(2, minutes)
  }
}
