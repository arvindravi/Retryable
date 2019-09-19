import XCTest

import RetryableTests

var tests = [XCTestCaseEntry]()
tests += RetryableTests.allTests()
XCTMain(tests)
