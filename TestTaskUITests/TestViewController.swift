//
//  TestViewController.swift
//  TestTask
//
//  Created by Shahnawaz Alam on 13/11/2015.
//  Copyright © 2015 Shahnawaz Alam. All rights reserved.
//

import XCTest

class TestViewController: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUIViewController () {
        let vc = ViewController()
        
        vc.viewDidLoad()
        vc.initData()
        vc.initView()
    }
    
    func testUITestDataViewController () {
        let vc = ViewController()
        
        vc.viewDidLoad()
        
        let testData = TestData()
        let albums = testData.generateSampleData()
        
        vc.sortAndAssignAlbums(albums)
        vc.initView()
    }
    
    func testUINilDataViewController () {
        let vc = ViewController()
        
        vc.viewDidLoad()
        
        let nilData = [Album]()
        
        vc.sortAndAssignAlbums(nilData)
        vc.initView()
    }

    
}
