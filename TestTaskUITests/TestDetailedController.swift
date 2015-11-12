//
//  TestDetailedController.swift
//  TestTask
//
//  Created by Shahnawaz Alam on 13/11/2015.
//  Copyright © 2015 Shahnawaz Alam. All rights reserved.
//

import XCTest

class TestDetailedController: XCTestCase {
        
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
    
    func testUIDetailedController () {
        let fakeCoder = NSCoder()
        let dc = DetailedController(coder: fakeCoder)
        
        dc!.viewDidLoad()
    }
    
    func testUIElementsDetailedController () {
        
        let fakeCoder = NSCoder()
        let dc = DetailedController(coder: fakeCoder)
        
        dc!.viewDidLoad()
        
        let album = Album(artist: "Lil Jon", albumName: "Top Hits", genre: "Hip Hop", albumImageURL: "http://static4.bornrichimages.com/cdn2/683/384/91/c/wp-content/uploads/2014/10/feat6.jpg")
        
        dc!.updateAllElements(album)
        
    }
    
    func testNilElementsDetailedController () {
        let fakeCoder = NSCoder()
        let dc = DetailedController(coder: fakeCoder)
        
        dc!.viewDidLoad()
        
        let album = Album()
        
        dc!.updateAllElements(album)
    }
    
    func testUpdateImageDetailedController () {
        let fakeCoder = NSCoder()
        let dc = DetailedController(coder: fakeCoder)
        
        dc!.viewDidLoad()
        
        let image = UIImage (named: "na.jpg")
        
        dc!.updateImage(image!)
    }
    
    func testNilImageDetailedController () {
        let fakeCoder = NSCoder()
        let dc = DetailedController(coder: fakeCoder)
        
        dc!.viewDidLoad()
        
        let image = UIImage()
        
        dc!.updateImage(image)
    }

}
