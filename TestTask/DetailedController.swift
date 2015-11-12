//
//  DetailedController.swift
//  TestTask
//
//  Created by Shahnawaz Alam on 12/11/2015.
//  Copyright © 2015 Shahnawaz Alam. All rights reserved.
//

import UIKit

class DetailedController: UIViewController, UpdateDetailsDelegate , UpdateDetailedVCImageDelegate{
    
    //MARK: Properties
    @IBOutlet weak var artistLbl: UILabel!
    @IBOutlet weak var albumLbl: UILabel!
    @IBOutlet weak var genreLbl: UILabel!
    @IBOutlet weak var albumImage: UIImageView!

    var album: Album
    
    //MARK: Constructor
    required init?(coder aDecoder: NSCoder) {
        self.album = Album()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        artistLbl!.text = ""
        albumLbl!.text = ""
        genreLbl!.text = ""
        albumImage.image = UIImage(named: "na.jpg")
    }
    
    override func viewDidAppear(animated: Bool) {
        initializeElements()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Initialize UI
    func initializeElements()
    {
        self.artistLbl.text = self.album.artist
        self.albumLbl.text = self.album.albumName
        self.genreLbl.text = self.album.genre
        
        let retrieveImage = RetrieveImage()
        retrieveImage.retrieveImage(self.album.albumImageURL, detailedVC: self)
    }

    //MARK: Delegate - loading view
    func updateAllElements (album: Album?)
    {
        self.album = album!
        //initializeElements()
        
        print("Check: \(album!.artist)")
    }
    
    //MARK: Delegate - downloading image
    func updateImage(image: UIImage)
    {
        self.albumImage.image = image
    }
}
