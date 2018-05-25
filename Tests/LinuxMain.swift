// Generated using Sourcery 0.10.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest

@testable import TaggedTests;
extension TaggedTests {
  static var allTests: [(String, (TaggedTests) -> () throws -> Void)] = [
    ("testCustomStringConvertible", testCustomStringConvertible),
    ("testComparable", testComparable),
    ("testDecodable", testDecodable),
    ("testEncodable", testEncodable),
    ("testEquatable", testEquatable),
    ("testError", testError),
    ("testExpressibleByBooleanLiteral", testExpressibleByBooleanLiteral),
    ("testExpressibleByFloatLiteral", testExpressibleByFloatLiteral),
    ("testExpressibleByIntegerLiteral", testExpressibleByIntegerLiteral),
    ("testExpressibleByStringLiteral", testExpressibleByStringLiteral),
    ("testLosslessStringConvertible", testLosslessStringConvertible),
    ("testNumeric", testNumeric),
    ("testHashable", testHashable),
    ("testSignedNumeric", testSignedNumeric)
  ]
}

// swiftlint:disable trailing_comma
XCTMain([
  testCase(TaggedTests.allTests),
])
// swiftlint:enable trailing_comma
