//
//  RetrieveImage.swift
//  TestTask
//
//  Created by Shahnawaz Alam on 11/11/2015.
//  Copyright © 2015 Shahnawaz Alam. All rights reserved.
//

import UIKit

class RetrieveImage: NSObject {
    
    var image: UIImage
    
    override init() {
        self.image = UIImage(named: "na.jpg")!
    }
    
    /*func downloadImage(urlStr: String) -> UIImage
    {
        //Downloading Synchronously, 
        let url = NSURL(string: urlStr)
        let data = NSData(contentsOfURL: url!)
        self.image = UIImage(data: data!)!
        
        return self.image
    }*/
    
    func getDataFromUrl(url:String, completion: ((data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: url)!) { (data, response, error) in
            completion(data: NSData(data: data!))
            }.resume()
    }
    
    func download(url:String){
        
        getDataFromUrl(url) { data in
            dispatch_async(dispatch_get_main_queue()) {
                var image = UIImage(data: data!)
            }
        }
        
}

}
