//
//  TestDataLoad.swift
//  TestTask
//
//  Created by Shahnawaz Alam on 13/11/2015.
//  Copyright © 2015 Shahnawaz Alam. All rights reserved.
//

import XCTest

class TestDataLoad: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDataInViewController () {
        let vc = ViewController()
        let testData = TestData()
        
        vc.updateData(testData.generateSampleData())
    }
    
    func testDataSortInViewController () {
        let vc = ViewController()
        let testData = TestData()
        
        vc.sortAndAssignAlbums(testData.generateSampleData())

    }
}
