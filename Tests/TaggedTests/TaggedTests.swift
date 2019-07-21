import XCTest
import Tagged

enum Tag {}
struct Unit: Error {}

final class TaggedTests: XCTestCase {
  func testCustomStringConvertible() {
    XCTAssertEqual("1", Tagged<Tag, Int>(rawValue: 1).description)
  }

  func testComparable() {
    XCTAssertTrue(Tagged<Tag, Int>(rawValue: 1) < Tagged<Tag, Int>(rawValue: 2))
  }

  func testDecodable() {
    XCTAssertEqual(
      [Tagged<Tag, Int>(rawValue: 1)],
      try JSONDecoder().decode([Tagged<Tag, Int>].self, from: Data("[1]".utf8))
    )
  }
  
  func testDecodableCustomDates() {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .custom { decoder in
      let seconds = try decoder.singleValueContainer().decode(Int.self)
      return Date(timeIntervalSince1970: TimeInterval(seconds))
    }
    
    XCTAssertEqual(
      [Date(timeIntervalSince1970: 1)],
      try decoder.decode([Date].self, from: Data("[1]".utf8))
    )
    
    XCTAssertEqual(
      [Tagged<Tag, Date>(rawValue: Date(timeIntervalSince1970: 1))],
      try decoder.decode([Tagged<Tag, Date>].self, from: Data("[1]".utf8))
    )
  }

  func testEncodable() {
    XCTAssertEqual(
      Data("[1]".utf8),
      try JSONEncoder().encode([Tagged<Tag, Int>(rawValue: 1)])
    )
  }
  
  func testEncodableCustomDates() {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .custom { date, encoder in
      var container = encoder.singleValueContainer()
      let seconds = Int(date.timeIntervalSince1970)
      try container.encode(seconds)
    }
    
    XCTAssertEqual(
      Data("[1]".utf8),
      try encoder.encode([Date(timeIntervalSince1970: 1)])
    )
    
    XCTAssertEqual(
      Data("[1]".utf8),
      try encoder.encode([Tagged<Tag, Date>(rawValue: Date(timeIntervalSince1970: 1))])
    )
  }

  func testEquatable() {
    XCTAssertEqual(Tagged<Tag, Int>(rawValue: 1), Tagged<Tag, Int>(rawValue: 1))
  }

  func testExpressibleByBooleanLiteral() {
    XCTAssertEqual(true, Tagged<Tag, Bool>(rawValue: true))
  }

  func testExpressibleByFloatLiteral() {
    XCTAssertEqual(1.0, Tagged<Tag, Double>(rawValue: 1.0))
  }

  func testExpressibleByIntegerLiteral() {
    XCTAssertEqual(1, Tagged<Tag, Int>(rawValue: 1))
  }

  func testExpressibleByStringLiteral() {
    XCTAssertEqual("Hello!", Tagged<Tag, String>(rawValue: "Hello!"))
  }

  func testLosslessStringConvertible() {
    // NB: This explicit `.init` shouldn't be necessary, but there seems to be a bug in Swift 5.
    //     Filed here: https://bugs.swift.org/browse/SR-9752
    XCTAssertEqual(Tagged<Tag, Bool>(rawValue: true), Tagged<Tag, Bool>.init("true"))
  }

  func testNumeric() {
    XCTAssertEqual(
      Tagged<Tag, Int>(rawValue: 2),
      Tagged<Tag, Int>(rawValue: 1) + Tagged<Tag, Int>(rawValue: 1)
    )
  }

  func testHashable() {
    XCTAssertEqual(Tagged<Tag, Int>(rawValue: 1).hashValue, Tagged<Tag, Int>(rawValue: 1).hashValue)
  }

  func testSignedNumeric() {
    XCTAssertEqual(Tagged<Tag, Int>(rawValue: -1), -Tagged<Tag, Int>(rawValue: 1))
  }

  func testMap() {
    let x: Tagged<Tag, Int> = 1
    XCTAssertEqual("1!", x.map { "\($0)!" })
  }

  func testOptionalRawTypeAndNilValueDecodesCorrectly() {
    struct Container: Decodable {
      typealias Identifier = Tagged<Container, String?>
      let id: Identifier
    }

    XCTAssertNoThrow(try {
      let data = "[{\"id\":null}]".data(using: .utf8)!
      let containers = try JSONDecoder().decode([Container].self, from: data)
      XCTAssertEqual(containers.count, 1)
      XCTAssertEqual(containers.first?.id.rawValue, nil)
      }())
  }
  
  func testOptionalRawTypeAndNilValueEncodesCorrectly() {
    struct Container: Encodable {
      typealias Identifier = Tagged<Container, String?>
      let id: Identifier
    }
    
    XCTAssertNoThrow(try {
      let data = try JSONEncoder().encode([Container(id: Tagged<Container, String?>(rawValue: nil))])
      XCTAssertEqual(data, Data("[{\"id\":null}]".utf8))
      }())
  }

  func testCoerce() {
    let x: Tagged<Tag, Int> = 1

    enum Tag2 {}
    let x2: Tagged<Tag2, Int> = x.coerced(to: Tag2.self)

    XCTAssertEqual(1, x2.rawValue)
  }
}
