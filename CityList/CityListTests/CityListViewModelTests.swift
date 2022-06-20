//
//  CityListViewModelTests.swift
//  CityListTests
//
//  Created by Nikhil Singhal on 6/19/22.
//

import XCTest
import Combine
@testable import CityList

class CityListViewModelTests: XCTestCase {
    private var subscriptions = Set<AnyCancellable>()

    var viewModel: CityListViewModal?

    override func setUpWithError() throws {
        viewModel = CityListViewModal()
    }

    func testCitiesLisy() {
        let expectation = expectation(description: "fetch expectation")
        viewModel?.$finishedLoading.sink(receiveValue: { [weak self] isFinished in
            guard isFinished != nil,
                  let viewModel = self?.viewModel else {
                      return
                  }

            XCTAssertNil(viewModel.fetchCitiesError)
            XCTAssertFalse(viewModel.cities.isEmpty)
            expectation.fulfill()
        }).store(in: &subscriptions)

        viewModel?.fetchCities()

        wait(for: [expectation], timeout: 5)
    }

}
