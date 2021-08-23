//
//  SimpleMVVMExampleSnapshotTests.swift
//  SimpleMVVMExampleSnapshotTests
//
//  Created by Sandeep Kumar on 22/08/21.
//  Copyright © 2021 Steven Curtis. All rights reserved.
//

import XCTest
import SnapshotTesting

@testable import SimpleMVVMExample

class SimpleMVVMExampleSnapshotTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_PhotoListViewControllerDefaultState() {
        let viewController = UINavigationController(rootViewController: PhotoListViewController())
        let result = verifySnapshot(matching: viewController,
                                        as: .image(on: .iPhoneX),
                                        named: "Default",
                                        testName: "PhotoListViewController")
        XCTAssertNil(result)
    }
    
    func test_verify_PhotoListViewControllerDefaultState() {
            let viewController = UINavigationController(rootViewController: PhotoListViewController())
            verifyViewController(viewController, named: "DefaultOne")
    }
    
    private func verifyViewController(_ viewController: UIViewController, named: String) {
            let devices: [String: ViewImageConfig] = ["iPhoneX": .iPhoneX,
                                                      "iPhone8": .iPhone8,
                                                      "iPhoneSe": .iPhoneSe]
            
            let results = devices.map { device in
                verifySnapshot(matching: viewController,
                               as: .image(on: device.value),
                               named: "\(named)-\(device.key)",
                               testName: "PhotoListViewController")
            }
            
            results.forEach { XCTAssertNil($0) }
        }

}
