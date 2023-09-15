//
//  DependenciesTestTests.swift
//  DependenciesTestTests
//
//  Created by Jon Duenas on 9/15/23.
//

import Dependencies
import XCTest
@testable import DependenciesTest

final class DependenciesTestTests: XCTestCase {

    func testChildButtonTapped() {
        let viewModel = withDependencies {
            $0.date.now = Date(timeIntervalSince1970: 1234567890)
        } operation: {
            ContentViewModel()
        }

        // If I initialize without `withDependencies`, I get a test failure
        // let viewModel = ContentViewModel()

        viewModel.childButtonTapped()

        XCTAssertNotNil(viewModel.sheetDestination)
    }
}
