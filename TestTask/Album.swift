//
//  Album.swift
//  TestTask
//
//  Created by Shahnawaz Alam on 10/11/2015.
//  Copyright © 2015 Shahnawaz Alam. All rights reserved.
//

import UIKit

class Album  {
    
    //MARK: Properties
    var artist: String
    var albumName: String
    var genre: String
    var albumImageURL: String
    
    //MARK: Constructor
    init ()
    {
        self.artist = ""
        self.albumName = ""
        self.genre = ""
        self.albumImageURL = ""
    }
    
    init(artist: String, albumName: String, genre: String, albumImageURL: String) {
        
        self.artist = artist
        self.albumName = albumName
        self.genre = genre
        self.albumImageURL = albumImageURL
    }
    
}
