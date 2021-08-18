//
//  BreachesViewControllerSnapshotTests.swift
//  BreachesViewControllerSnapshotTests
//
//  Created by Shinu Mohan on 18/08/21.

import XCTest
import SnapshotTesting

//@testable import SimpleMVVMExampleSnapshotTests

class BreachesViewControllerSnapshotTests: XCTestCase {

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

    func test_breachesViewControllerDefaultState() {
            let viewController = UINavigationController(rootViewController: BreachesViewController())
            let result = verifySnapshot(matching: viewController,
                                        as: .image(on: .iPhoneX),
                                        named: "Default",
                                        testName: "LoginViewController")
            XCTAssertNil(result)
        }

}
