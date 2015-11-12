//
//  ViewController.swift
//  TestTask
//
//  Created by Shahnawaz Alam on 9/11/2015.
//  Copyright © 2015 Shahnawaz Alam. All rights reserved.
//

import UIKit

protocol UpdateDetailsDelegate {
    func updateAllElements (album: Album?)
}


class ViewController: UIViewController, UIScrollViewDelegate, UpdateiTunesDataDelegate {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    var pageImages: [UIImage] = []
    var pageViews: [UIImageView?] = []
    var albums: [Album] = []
    var currentAlbum: Album?
    
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    var delegate:UpdateDetailsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData()
        //initView()
    }
    
    func initData()
    {
        //Populate with test data
        /*let test = TestData()
        self.albums = test.generateSampleData()*/
        
        //Populate from iTunes API
        let api = APIConnector()
        //To search by artist ID in itunes
        albums = api.searchiTunes()
        
        //searchiTunes()
        print("album count \(albums.count)")
        
        //Test with 1st index of albums
        //self.currentAlbum = self.albums[0]
    }
    
    func initView()
    {
        // Set up the image you want to scroll & zoom and add it to the scroll view
        /*pageImages = [UIImage(named: "photo1.png")!,
        UIImage(named: "photo2.png")!,
        UIImage(named: "photo3.png")!,
        UIImage(named: "photo4.png")!,
        UIImage(named: "photo5.png")!]*/
        
        let pageCount = pageImages.count
        
        // Set up the page control
        pageControl.currentPage = 0
        pageControl.numberOfPages = pageCount
        
        // Set up the array to hold the views for each page
        for _ in 0..<pageCount {
            pageViews.append(nil)
        }
        
        // Set up the content size of the scroll view
        let pagesScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * CGFloat(pageImages.count), pagesScrollViewSize.height)
        
        // Load the initial set of pages that are on screen
        loadVisiblePages()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateData(albums: [Album])
    {
        self.albums = albums
        initView()
        
        //Test with 1st index of albums
        self.currentAlbum = self.albums[0]
    }
    
    func populateLabels()
    {
        self.artistLabel.text = self.currentAlbum!.artist
        self.albumLabel.text = self.currentAlbum!.albumName
        self.genreLabel.text = self.currentAlbum!.genre
    }
    
    func loadVisiblePages() {
        // First, determine which page is currently visible
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        
        // Update the page control
        pageControl.currentPage = page
        
        //Update current album
        self.currentAlbum? = albums[page]
        
        // Work out which pages you want to load
        let firstPage = page - 1
        let lastPage = page + 1
        
        // Purge anything before the first page
        for var index = 0; index < firstPage; ++index {
            purgePage(index)
        }
        
        // Load pages in our range
        for index in firstPage...lastPage {
            loadPage(index)
        }
        
        // Purge anything after the last page
        for var index = lastPage+1; index < pageImages.count; ++index {
            purgePage(index)
        }
        
        //Load Labels with text
        populateLabels()
    }
    
    func loadPage(page: Int) {
        if page < 0 || page >= pageImages.count {
            // If it's outside the range of what you have to display, then do nothing
            return
        }
        
        // Load an individual page, first checking if you've already loaded it
        if let pageView = pageViews[page] {
            // Do nothing. The view is already loaded.
        } else {
            var frame = scrollView.bounds
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0.0
            frame = CGRectInset(frame, 10.0, 0.0)
            
            let newPageView = UIImageView(image: pageImages[page])
            newPageView.contentMode = .ScaleAspectFit
            newPageView.frame = frame
            scrollView.addSubview(newPageView)
            pageViews[page] = newPageView
        }
    }
    
    func purgePage(page: Int) {
        if page < 0 || page >= pageImages.count {
            // If it's outside the range of what you have to display, then do nothing
            return
        }
        
        // Remove a page from the scroll view and reset the container array
        if let pageView = pageViews[page] {
            pageView.removeFromSuperview()
            pageViews[page] = nil
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // Load the pages that are now on screen
        loadVisiblePages()
    }
    
    @IBAction func nextClicked(sender: AnyObject) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showDetailsVC"
        {
            let detailsVC:DetailedController = segue.destinationViewController as! DetailedController
            self.delegate = detailsVC
            print("Check value - \(self.currentAlbum!.artist) ")
            self.delegate?.updateAllElements(self.currentAlbum!)
            
        }
        
    }
    
    //Testing this method -- will be deleted later
    func searchiTunes()
    {
        let postEndpoint: String = "https://itunes.apple.com/lookup?id=909253&entity=album"
        guard let url = NSURL(string: postEndpoint) else {
            print("Error: cannot create URL")
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
                    print("\(item)")
                    let artist = item["artistName"] as! String
                    let albumName = item["collectionName"] as! String
                    let genre = item["primaryGenreName"] as! String
                    let imageURL = item["artworkUrl100"] as! String
                    //let collectionPrice = item["collectionPrice"] as! String
                    //print("Checking: \(artist) \(albumName) \(genre)")
                    
                    var album: Album = Album(artist: artist, albumName: albumName, genre: genre, albumImageURL: imageURL)
                    self.albums.append(album)
                }
                
            }
        })
        task.resume()
        
        print("album count \(self.albums.count)")
    }


}

