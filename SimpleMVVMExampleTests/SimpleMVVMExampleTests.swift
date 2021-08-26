//
//  SimpleMVVMExampleTests.swift
//  SimpleMVVMExampleTests
//
//  Created by Shinu Mohan on 17/08/21.

import XCTest

@testable import SimpleMVVMExample

class MockDataSource: NSObject, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

class SimpleMVVMExampleTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testControllerHasTableView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PhotoListViewController") as! PhotoListViewController
        controller.loadViewIfNeeded()
        XCTAssertNotNil(controller.tableView,
                        "Controller should have a tableview")
    }
    
    func testNumberOfRows() {
        let sut = MockDataSource()
        let tableView = UITableView()
        tableView.dataSource = sut
        let numberOfRows = tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(numberOfRows, 10,
                       "Number of rows in table should match number of mocks")
    }
    
    func testNumberOfSections() {
        let sut = MockDataSource()
        let tableView = UITableView()
        tableView.dataSource = sut
        let numberOfSections = tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 2,
                       "Number of sections in table should match number of mocks")
    }
    
    func testTableViewHasCells() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PhotoListViewController") as! PhotoListViewController
        controller.loadViewIfNeeded()
        let cell = controller.tableView.dequeueReusableCell(withIdentifier: "imageCell")
        XCTAssertNotNil(cell,
                        "TableView should be able to dequeue cell with identifier: 'imageCell'")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
