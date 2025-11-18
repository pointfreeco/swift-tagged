import XCTest
import Tagged

final class TaggedArithmeticTests: XCTestCase {
  func test_binaryOperators() {
    let l = 27
    let r = 42

    typealias TaggedInt = Tagged<Tag, Int>

    let taggedL = TaggedInt(rawValue: l)
    let taggedR = TaggedInt(rawValue: r)

    XCTAssertEqual(Int.isSigned, TaggedInt.isSigned)

    XCTAssertEqual(l.trailingZeroBitCount, taggedL.trailingZeroBitCount)
    XCTAssertEqual(l.bitWidth, taggedL.bitWidth)
    XCTAssertEqual(l.nonzeroBitCount, taggedL.nonzeroBitCount)

    XCTAssertEqual(l + r, (taggedL + taggedR).rawValue)
    XCTAssertEqual(l - r, (taggedL - taggedR).rawValue)
    XCTAssertEqual(l * r, (taggedL * taggedR).rawValue)
    XCTAssertEqual(l / r, (taggedL / taggedR).rawValue)
    XCTAssertEqual(l % r, (taggedL % taggedR).rawValue)
    XCTAssertEqual(~l, ~taggedL.rawValue)
    XCTAssertEqual(l & r, (taggedL & taggedR).rawValue)
    XCTAssertEqual(l | r, (taggedL | taggedR).rawValue)
    XCTAssertEqual(l ^ r, (taggedL ^ taggedR).rawValue)
    XCTAssertEqual(l >> r, (taggedL >> taggedR).rawValue)
    XCTAssertEqual(l << r, (taggedL << taggedR).rawValue)

    XCTAssertEqual(l.quotientAndRemainder(dividingBy: r).quotient, taggedL.quotientAndRemainder(dividingBy: taggedR).quotient.rawValue)
    XCTAssertEqual(l.quotientAndRemainder(dividingBy: r).remainder, taggedL.quotientAndRemainder(dividingBy: taggedR).remainder.rawValue)
    XCTAssertEqual(l.isMultiple(of: r), taggedL.isMultiple(of: taggedR))
//    XCTAssertEqual(l.signum(), taggedL.signum())


    do {
      var (l, taggedL) = (l, taggedL)
      l += r
      taggedL += taggedR
      XCTAssertEqual(l, taggedL.rawValue)
    }

    do {
      var (l, taggedL) = (l, taggedL)
      l -= r
      taggedL -= taggedR
      XCTAssertEqual(l, taggedL.rawValue)
    }

    do {
      var (l, taggedL) = (l, taggedL)
      l *= r
      taggedL *= taggedR
      XCTAssertEqual(l, taggedL.rawValue)
    }

    do {
      var (l, taggedL) = (l, taggedL)
      l /= r
      taggedL /= taggedR
      XCTAssertEqual(l, taggedL.rawValue)
    }

    do {
      var (l, taggedL) = (l, taggedL)
      l %= r
      taggedL %= taggedR
      XCTAssertEqual(l, taggedL.rawValue)
    }

    do {
      var (l, taggedL) = (l, taggedL)
      l &= r
      taggedL &= taggedR
      XCTAssertEqual(l, taggedL.rawValue)
    }

    do {
      var (l, taggedL) = (l, taggedL)
      l |= r
      taggedL |= taggedR
      XCTAssertEqual(l, taggedL.rawValue)
    }

    do {
      var (l, taggedL) = (l, taggedL)
      l ^= r
      taggedL ^= taggedR
      XCTAssertEqual(l, taggedL.rawValue)
    }

    do {
      var (l, taggedL) = (l, taggedL)
      l >>= r
      taggedL >>= taggedR
      XCTAssertEqual(l, taggedL.rawValue)
    }

    do {
      var (l, taggedL) = (l, taggedL)
      l <<= r
      taggedL <<= taggedR
      XCTAssertEqual(l, taggedL.rawValue)
    }

  }

}

