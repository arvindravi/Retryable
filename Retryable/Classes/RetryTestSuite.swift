//
//  RetryTestSuite.swift
//  Retryable
//
//  Created by Kane Cheshire on 14/06/2019.
//  Copyright © 2019 kane.codes. All rights reserved.
//

import XCTest

/// A test suite designed specifically for re-running failed test cases.
final class RetryTestSuite: XCTestSuite {
	
	/// Creates a new instance configured with failed tests.
	///
	/// - Parameter failures: The failures to configure the test suite with.
	init(_ failures: Set<RetryableTestCase>) {
		let testsString = failures.count == 1 ? "test" : "tests"
		super.init(name: "Retrying \(failures.count) failed \(testsString)")
		failures.sorted(by: { $0.name > $1.name }).forEach { failure in
			guard let selector = failure.invocation?.selector else { fatalError("Tests for \(failure.name) should have a selector") }
			let test = type(of: failure).init(selector) // Creates a new instance of the test case for the selector that failed
			test.retryCount = failure.retryCount + 1 // Bumps the retry count of the new instance using the previously failed instance's count
			addTest(test)
		}
	}
	
}
