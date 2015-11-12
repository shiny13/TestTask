//
//  RetrieveImage.swift
//  TestTask
//
//  Created by Shahnawaz Alam on 11/11/2015.
//  Copyright © 2015 Shahnawaz Alam. All rights reserved.
//

import UIKit

//MARK: Delegates
protocol UpdateDetailedVCImageDelegate{
    func updateImage(image: UIImage)
}

protocol DownloadAlbumImagesDelegate {
    func updateImageArray(image: UIImage, total: Int)
}

class RetrieveImage: NSObject {
    
    //MARK: Properties
    var image: UIImage
    var detaledVCDelegate:UpdateDetailedVCImageDelegate?
    var dlImageDelegate:DownloadAlbumImagesDelegate?
    
    //MARK: Constructor
    override init() {
        self.image = UIImage(named: "na.jpg")!
    }
    
    //MARK: Data Retrieval methods
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
    
    func downloadImages(urls: [NSURL]){
        for url in urls {
            print("Started downloading \"\(url.URLByDeletingPathExtension!.lastPathComponent!)\".")
            getDataFromUrl(url) { (data, response, error)  in
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    guard let data = data where error == nil else { return }
                    print("Finished downloading \"\(url.URLByDeletingPathExtension!.lastPathComponent!)\".")
                    var image:UIImage = UIImage(data: data)!
                    self.dlImageDelegate?.updateImageArray(image, total: urls.count)
                }
            }
        }
    }
    
    //MARK: Single image
    func retrieveImage(urlString: String, detailedVC: DetailedController)
    {
        self.detaledVCDelegate = detailedVC
        let url:NSURL = NSURL(string: urlString)!
        downloadImage(url)
    }
    
    //MARK: Multiple images
    func retrieveAlbumImages(urls: [NSURL], dlImageDelegate: DownloadAlbumImagesDelegate)
    {
        self.dlImageDelegate = dlImageDelegate
        downloadImages(urls)
    }

}
