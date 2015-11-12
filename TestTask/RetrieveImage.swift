//
//  RetrieveImage.swift
//  TestTask
//
//  Created by Shahnawaz Alam on 11/11/2015.
//  Copyright © 2015 Shahnawaz Alam. All rights reserved.
//

import UIKit

protocol UpdateDetailedVCImageDelegate{
    func updateImage(image: UIImage)
}

class RetrieveImage: NSObject {
    
    var image: UIImage
    var detaledVCDelegate:UpdateDetailedVCImageDelegate?
    
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
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    func downloadImage(url: NSURL){
        print("Started downloading \"\(url.URLByDeletingPathExtension!.lastPathComponent!)\".")
        getDataFromUrl(url) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                print("Finished downloading \"\(url.URLByDeletingPathExtension!.lastPathComponent!)\".")
                self.image = UIImage(data: data)!
                self.detaledVCDelegate?.updateImage(UIImage(data: data)!)
            }
        }
    }
    
    func retrieveImage(urlString: String, detailedVC: DetailedController)
    {
        self.detaledVCDelegate = detailedVC
        print("URL: \(urlString)")
        let url:NSURL = NSURL(string: urlString)!
        downloadImage(url)
    }

}
