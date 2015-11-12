//
//  APIConnector.swift
//  TestTask
//
//  Created by Shahnawaz Alam on 11/11/2015.
//  Copyright © 2015 Shahnawaz Alam. All rights reserved.
//

import UIKit

protocol UpdateiTunesDataDelegate{
    func updateData(albums: [Album])
}

class APIConnector: NSObject {
    
    //MARK: Properties
    var albums = [Album]()
    var delegate:UpdateiTunesDataDelegate?
    
    //MARK: Constructor
    override init() {
        
    }
    
    //MARK: Call API
    func searchiTunes(delegate: UpdateiTunesDataDelegate)
    {
        self.delegate = delegate
        
        let postEndpoint: String = "https://itunes.apple.com/lookup?id=909253&entity=album"
        guard let url = NSURL(string: postEndpoint) else {
            print("Error: cannot create URL")
            //return albums
            return
        }
        let urlRequest = NSURLRequest(URL: url)
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let task = session.dataTaskWithRequest(urlRequest, completionHandler: {
            (data, response, error) in
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            guard error == nil else {
                print("error calling GET on iTunes artist ID")
                print(error)
                return
            }
            // parse the result as JSON, since that's what the API provides
            let post: NSDictionary
            do {
                post = try NSJSONSerialization.JSONObjectWithData(responseData,
                    options: []) as! NSDictionary
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
            
            // testing posts for data
            //print("Test data: \(post)")
            
            if let items = post["results"] as? NSArray {
                
                for (var i = 1; i < items.count; i++)
                {
                    var item = items[i]
                    let artist = item["artistName"] as! String
                    let albumName = item["collectionName"] as! String
                    let genre = item["primaryGenreName"] as! String
                    let imageURL = item["artworkUrl100"] as! String
                    //let collectionPrice = item["collectionPrice"] as! String
                    //print("Checking: \(artist) \(albumName) \(genre)")
                    
                    var album: Album = Album(artist: artist, albumName: albumName, genre: genre, albumImageURL: imageURL)
                    self.albums.append(album)
                }
                print("album count \(self.albums.count)")
                self.delegate?.updateData(self.albums)
            }
        })
        task.resume()
        
    }

}
