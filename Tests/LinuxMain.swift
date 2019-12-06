import XCTest

import TaggedMoneyTests
import TaggedTests
import TaggedTimeTests

var tests = [XCTestCaseEntry]()
tests += TaggedMoneyTests.__allTests()
tests += TaggedTests.__allTests()
tests += TaggedTimeTests.__allTests()

XCTMain(tests)
