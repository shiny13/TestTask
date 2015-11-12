//
//  GetiTunesData.swift
//  TestTask
//
//  Created by Shahnawaz Alam on 12/11/2015.
//  Copyright © 2015 Shahnawaz Alam. All rights reserved.
//

import UIKit

class GetiTunesData: NSObject {

    override init() {
        
    }
    
    func retrieveiTunesData() -> [Album]
    {
        var albums = [Album]()
        
        //Populate from iTunes API
        let api = APIConnector()
        //To search by artist ID in itunes
        albums = api.searchiTunes()
        
        return albums
    }
    
    
}
