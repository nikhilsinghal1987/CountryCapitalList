//
//  CityListViewControllerUITests.swift
//  CityListUITests
//
//  Created by M1071718 on 6/19/22.
//

import XCTest

class CityListViewControllerUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["DZ"]/*[[".cells.staticTexts[\"DZ\"]",".staticTexts[\"DZ\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeDown()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Tirana"]/*[[".cells.staticTexts[\"Tirana\"]",".staticTexts[\"Tirana\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeDown()
        tablesQuery.searchFields["Search"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["American Samoa , OC"]/*[[".cells.staticTexts[\"American Samoa , OC\"]",".staticTexts[\"American Samoa , OC\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Cancel"].tap()
    }

}
