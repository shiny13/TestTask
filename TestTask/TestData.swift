//
//  TestData.swift
//  TestTask
//
//  Created by Shahnawaz Alam on 12/11/2015.
//  Copyright © 2015 Shahnawaz Alam. All rights reserved.
//

import UIKit

class TestData: NSObject {
    
    override init() {
        
    }
    
    
    func generateSampleData() -> [Album]
    {
        var albums:[Album] = [Album]()
        
        var artist = "Michael Jackson"
        var albumName = "Dangerous"
        var genre = "Pop"
        var imageURL = "http://digitalspyuk.cdnds.net/10/04/music_michael_jackson_3_0.jpg"
        var album = Album(artist: artist, albumName: albumName, genre: genre, albumImageURL: imageURL)
        albums.append(album)
        
        artist = "Coldplay"
        albumName = "Ghost Stories"
        genre = "Soft Rock"
        imageURL = "http://www.prlog.org/12024678-coldplay2.jpg"
        album = Album(artist: artist, albumName: albumName, genre: genre, albumImageURL: imageURL)
        albums.append(album)
        
        artist = "Enya"
        albumName = "Amarantine"
        genre = "World"
        imageURL = "http://www.nndb.com/people/120/000023051/enya3-sized.jpg"
        album = Album(artist: artist, albumName: albumName, genre: genre, albumImageURL: imageURL)
        albums.append(album)

        artist = "Jack Jackson"
        albumName = "To The Sea"
        genre = "Country"
        imageURL = "http://img.webthrowdown.com/throwdowns/jack-johnson-449-2.jpg"
        album = Album(artist: artist, albumName: albumName, genre: genre, albumImageURL: imageURL)
        albums.append(album)

        return albums
    }
}
