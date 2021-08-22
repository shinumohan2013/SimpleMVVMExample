//
//  SimpleMVVMExampleTests.swift
//  SimpleMVVMExampleTests
//
//  Created by Shinu Mohan on 17/08/21.

import XCTest

@testable import SimpleMVVMExample

class SimpleMVVMExampleTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testControllerHasTableView() {
        guard let controller = UIStoryboard(name: "Main", bundle: Bundle(for: PhotoListViewController.self)).instantiateInitialViewController() as? PhotoListViewController else {
            return XCTFail("Could not instantiate ViewController from main storyboard")
        }

        controller.loadViewIfNeeded()

        XCTAssertNotNil(controller.tableView,
                        "Controller should have a tableview")
    }
    
    func testNumberOfRows() {
        let tableView = UITableView()
        let dataSource = tableView.dataSource
        let numberOfRows = dataSource?.tableView(tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 20,
                       "Number of rows in table should match number of kittens")
    }
    
    func testCellForRow() {
        let tableView = UITableView()
        let dataSource = tableView.dataSource
        let cell = dataSource?.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell?.textLabel?.text, "0",
                       "The first cell should display name of first index")
    }
    
    func testTableViewHasCells() {
        guard let controller = UIStoryboard(name: "Main", bundle: Bundle(for: PhotoListViewController.self)).instantiateInitialViewController() as? PhotoListViewController else {
            return XCTFail("Could not instantiate ViewController from main storyboard")
        }

        controller.loadViewIfNeeded()
        let cell = controller.tableView.dequeueReusableCell(withIdentifier: "cell")

        XCTAssertNotNil(cell,
                        "TableView should be able to dequeue cell with identifier: 'cell'")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
