//
//  CityListViewControllerTests.swift
//  CityListTests
//
//  Created by Nikhil Singhal on 6/19/22.
//

import XCTest
import Combine
@testable import CityList

class CityListViewControllerTests: XCTestCase {


    var controller: CityListViewController?
    private var subscriptions: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        _ = CityListViewModal(networkManager: MockNetworkManager.shared)
        controller = CityListViewController()
    }

    func testElementsUpdate() throws {
        controller?.viewDidLoad()

        controller?.viewWillAppear(true)

        controller?.viewModel.$finishedLoading.sink(receiveValue: { [weak self] isfinished in
            guard let finished = isfinished,
                  let controller = self?.controller
            else {
                return
            }
            XCTAssertTrue(finished)
            XCTAssertEqual(controller.viewModel.cities.count, 249)
        }).store(in: &subscriptions)
    }

}
