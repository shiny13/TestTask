//
//  TestRetrieveImage.swift
//  TestTask
//
//  Created by Shahnawaz Alam on 11/11/2015.
//  Copyright © 2015 Shahnawaz Alam. All rights reserved.
//

import XCTest
@testable import TestTask

class TestRetrieveImage: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDownloadEmptyString()
    {
        let retrieveImage = RetrieveImage()
        retrieveImage.download("")
    }
    
    func testDownloadInvalidValue()
    {
        let retrieveImage = RetrieveImage()
        retrieveImage.download("http://natashatherobot.com/swift-2-xcode-7-unit-testing-access/")
    }

    func testDownloadValidValue()
    {
        let retrieveImage = RetrieveImage()
        retrieveImage.download("http://media.mercola.com/assets/images/food-facts/apple.jpg")
    }
    

}
