//
//  Album.swift
//  TestTask
//
//  Created by Shahnawaz Alam on 10/11/2015.
//  Copyright © 2015 Shahnawaz Alam. All rights reserved.
//

import UIKit

class Album {

    var artist: String = ""
    var albumName: String = ""
    var genre: String = ""
    var albumImageURL: String = ""
    var price: String = ""
    
    init(artist: String, albumName: String, genre: String, albumImageURL: String) {
        
        self.artist = artist
        self.albumName = albumName
        self.genre = genre
        self.albumImageURL = albumImageURL
    }

    
    init(artist: String, albumName: String, genre: String, albumImageURL: String, price: String) {
        
        self.artist = artist
        self.albumName = albumName
        self.genre = genre
        self.albumImageURL = albumImageURL
        self.price = price
        
    }
    
}
