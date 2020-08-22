import XCTest
import Tagged

final class ZipTaggedTests: XCTestCase {
  func testZip() {
    let a: Tagged<Tag, Int> = 1
    let b: Tagged<Tag, Int> = 2
    XCTAssertEqual(3, zip(a, b).map { $0 + $1 })
  }
  
  func testZipTransform() {
    let a: Tagged<Tag, Int> = 1
    let b: Tagged<Tag, Int> = 2
    XCTAssertEqual(3, zip(with: +, a, b))
  }
  
  func testZip3() {
    let a: Tagged<Tag, Int> = 1
    let b: Tagged<Tag, Int> = 2
    let c: Tagged<Tag, Int> = 3
    XCTAssertEqual(6, zip(a, b, c).map { $0 + $1 + $2 })
  }
  
  func testZip3Transform() {
    let a: Tagged<Tag, Int> = 1
    let b: Tagged<Tag, Int> = 2
    let c: Tagged<Tag, Int> = 3
    XCTAssertEqual(6, zip(with: { $0 + $1 + $2 }, a, b, c))
  }
  
  func testZip4() {
    let a: Tagged<Tag, Int> = 1
    let b: Tagged<Tag, Int> = 2
    let c: Tagged<Tag, Int> = 3
    let d: Tagged<Tag, Int> = 4
    XCTAssertEqual(10, zip(a, b, c, d).map { $0 + $1 + $2 + $3 })
  }
  
  func testZip4Transform() {
    let a: Tagged<Tag, Int> = 1
    let b: Tagged<Tag, Int> = 2
    let c: Tagged<Tag, Int> = 3
    let d: Tagged<Tag, Int> = 4
    XCTAssertEqual(10, zip(with: { $0 + $1 + $2 + $3 }, a, b, c, d))
  }
  
  func testZip5() {
    let a: Tagged<Tag, Int> = 1
    let b: Tagged<Tag, Int> = 2
    let c: Tagged<Tag, Int> = 3
    let d: Tagged<Tag, Int> = 4
    let e: Tagged<Tag, Int> = 5
    XCTAssertEqual(15, zip(a, b, c, d, e).map { $0 + $1 + $2 + $3 + $4 })
  }
  
  func testZip5Transform() {
    let a: Tagged<Tag, Int> = 1
    let b: Tagged<Tag, Int> = 2
    let c: Tagged<Tag, Int> = 3
    let d: Tagged<Tag, Int> = 4
    let e: Tagged<Tag, Int> = 5
    XCTAssertEqual(15, zip(with: { $0 + $1 + $2 + $3 + $4 }, a, b, c, d, e))
  }
  
  func testZip6() {
    let a: Tagged<Tag, Int> = 1
    let b: Tagged<Tag, Int> = 2
    let c: Tagged<Tag, Int> = 3
    let d: Tagged<Tag, Int> = 4
    let e: Tagged<Tag, Int> = 5
    let f: Tagged<Tag, Int> = 6
    XCTAssertEqual(21, zip(a, b, c, d, e, f).map { $0 + $1 + $2 + $3 + $4 + $5 })
  }
  
  func testZip6Transform() {
    let a: Tagged<Tag, Int> = 1
    let b: Tagged<Tag, Int> = 2
    let c: Tagged<Tag, Int> = 3
    let d: Tagged<Tag, Int> = 4
    let e: Tagged<Tag, Int> = 5
    let f: Tagged<Tag, Int> = 6
    XCTAssertEqual(21, zip(with: { $0 + $1 + $2 + $3 + $4 + $5 }, a, b, c, d, e, f))
  }
  
  func testZip7() {
    let a: Tagged<Tag, Int> = 1
    let b: Tagged<Tag, Int> = 2
    let c: Tagged<Tag, Int> = 3
    let d: Tagged<Tag, Int> = 4
    let e: Tagged<Tag, Int> = 5
    let f: Tagged<Tag, Int> = 6
    let g: Tagged<Tag, Int> = 7
    XCTAssertEqual(28, zip(a, b, c, d, e, f, g).map { $0 + $1 + $2 + $3 + $4 + $5 + $6 })
  }
  
  func testZip7Transform() {
    let a: Tagged<Tag, Int> = 1
    let b: Tagged<Tag, Int> = 2
    let c: Tagged<Tag, Int> = 3
    let d: Tagged<Tag, Int> = 4
    let e: Tagged<Tag, Int> = 5
    let f: Tagged<Tag, Int> = 6
    let g: Tagged<Tag, Int> = 7
    XCTAssertEqual(28, zip(with: { $0 + $1 + $2 + $3 + $4 + $5 + $6 }, a, b, c, d, e, f, g))
  }
  
  func testZip8() {
    let a: Tagged<Tag, Int> = 1
    let b: Tagged<Tag, Int> = 2
    let c: Tagged<Tag, Int> = 3
    let d: Tagged<Tag, Int> = 4
    let e: Tagged<Tag, Int> = 5
    let f: Tagged<Tag, Int> = 6
    let g: Tagged<Tag, Int> = 7
    let h: Tagged<Tag, Int> = 8
    XCTAssertEqual(36, zip(a, b, c, d, e, f, g, h).map { $0 + $1 + $2 + $3 + $4 + $5 + $6 + $7 })
  }
  
  func testZip8Transform() {
    let a: Tagged<Tag, Int> = 1
    let b: Tagged<Tag, Int> = 2
    let c: Tagged<Tag, Int> = 3
    let d: Tagged<Tag, Int> = 4
    let e: Tagged<Tag, Int> = 5
    let f: Tagged<Tag, Int> = 6
    let g: Tagged<Tag, Int> = 7
    let h: Tagged<Tag, Int> = 8
    XCTAssertEqual(36, zip(with: { $0 + $1 + $2 + $3 + $4 + $5 + $6 + $7 }, a, b, c, d, e, f, g, h))
  }
  
  func testZip9() {
    let a: Tagged<Tag, Int> = 1
    let b: Tagged<Tag, Int> = 2
    let c: Tagged<Tag, Int> = 3
    let d: Tagged<Tag, Int> = 4
    let e: Tagged<Tag, Int> = 5
    let f: Tagged<Tag, Int> = 6
    let g: Tagged<Tag, Int> = 7
    let h: Tagged<Tag, Int> = 8
    let i: Tagged<Tag, Int> = 9
    XCTAssertEqual(45, zip(a, b, c, d, e, f, g, h, i).map { $0 + $1 + $2 + $3 + $4 + $5 + $6 + $7 + $8 })
  }
  
  func testZip9Transform() {
    let a: Tagged<Tag, Int> = 1
    let b: Tagged<Tag, Int> = 2
    let c: Tagged<Tag, Int> = 3
    let d: Tagged<Tag, Int> = 4
    let e: Tagged<Tag, Int> = 5
    let f: Tagged<Tag, Int> = 6
    let g: Tagged<Tag, Int> = 7
    let h: Tagged<Tag, Int> = 8
    let i: Tagged<Tag, Int> = 9
    XCTAssertEqual(45, zip(with: { $0 + $1 + $2 + $3 + $4 + $5 + $6 + $7 + $8 }, a, b, c, d, e, f, g, h, i))
  }
  
  func testZip10() {
    let a: Tagged<Tag, Int> = 1
    let b: Tagged<Tag, Int> = 2
    let c: Tagged<Tag, Int> = 3
    let d: Tagged<Tag, Int> = 4
    let e: Tagged<Tag, Int> = 5
    let f: Tagged<Tag, Int> = 6
    let g: Tagged<Tag, Int> = 7
    let h: Tagged<Tag, Int> = 8
    let i: Tagged<Tag, Int> = 9
    let j: Tagged<Tag, Int> = 10
    XCTAssertEqual(55, zip(a, b, c, d, e, f, g, h, i, j).map { $0 + $1 + $2 + $3 + $4 + $5 + $6 + $7 + $8 + $9 })
  }
  
  func testZip10Transform() {
    let a: Tagged<Tag, Int> = 1
    let b: Tagged<Tag, Int> = 2
    let c: Tagged<Tag, Int> = 3
    let d: Tagged<Tag, Int> = 4
    let e: Tagged<Tag, Int> = 5
    let f: Tagged<Tag, Int> = 6
    let g: Tagged<Tag, Int> = 7
    let h: Tagged<Tag, Int> = 8
    let i: Tagged<Tag, Int> = 9
    let j: Tagged<Tag, Int> = 10
    XCTAssertEqual(55, zip(with: { $0 + $1 + $2 + $3 + $4 + $5 + $6 + $7 + $8 + $9 }, a, b, c, d, e, f, g, h, i, j))
  }
}
