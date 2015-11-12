//
//  TestImageLoad.swift
//  TestTask
//
//  Created by Shahnawaz Alam on 13/11/2015.
//  Copyright © 2015 Shahnawaz Alam. All rights reserved.
//

import XCTest

class TestImageLoad: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testImageInViewController () {
        let ri = RetrieveImage()
        let vc = ViewController()
        
        let urls = [NSURL(string: "http://www.incrediblethings.com/wp-content/uploads/2013/07/rapper-cereal-mascots-1.jpeg.jpg")!,
        NSURL(string: "https://www.billboard.com/files/Best%20Bets%202013/best-bets-albums-eminem-650-430.jpg")!,
        NSURL(string: "http://www.bet.com/content/betcom/shows/106-and-park/photos/2012/05/west-coast-rappers-then-and-now/_jcr_content/leftcol/flipbook/flipbookimage_8.flipfeature.dimg/030612-shows-106-park-west-coast-rappers-young-sam-young-mc.jpg")!]
        
        ri.retrieveAlbumImages(urls, dlImageDelegate: vc)
        
    }
    
    func testNilImageInViewController () {
        let ri = RetrieveImage()
        let vc = ViewController()
        
        let urls = [NSURL]()
        
        ri.retrieveAlbumImages(urls, dlImageDelegate: vc)
        
    }
    
    func testImageInDetailedController ()
    {
        let ri = RetrieveImage()
        let fakeCoder = NSCoder()
        let dc = DetailedController(coder: fakeCoder)
        
        let urlString = "http://www.incrediblethings.com/wp-content/uploads/2013/07/rapper-cereal-mascots-1.jpeg.jpg"
        
        ri.retrieveImage(urlString, detailedVC: dc!)
    }
    
    func testNilImageInDetailedController ()
    {
        let ri = RetrieveImage()
        let fakeCoder = NSCoder()
        let dc = DetailedController(coder: fakeCoder)
        
        let urlString = ""
        
        ri.retrieveImage(urlString, detailedVC: dc!)
    }

}
