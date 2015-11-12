//
//  ViewController.swift
//  TestTask
//
//  Created by Shahnawaz Alam on 9/11/2015.
//  Copyright © 2015 Shahnawaz Alam. All rights reserved.
//

import UIKit

//MARK: Delegates
protocol UpdateDetailsDelegate {
    func updateAllElements (album: Album?)
}


class ViewController: UIViewController, UIScrollViewDelegate, UpdateiTunesDataDelegate, DownloadAlbumImagesDelegate {
    
    //MARK: Properties
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
    
    //MARK: Constructor
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentAlbum = Album()
        
        initData()
        //initView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Initialization methods
    func initData()
    {
        //Populate with test data
        /*let test = TestData()
        self.albums = test.generateSampleData()*/
        
        //Populate from iTunes API
        let api = APIConnector()
        //To search by artist ID in itunes
        //albums =
        api.searchiTunes(self)
        
        //searchiTunes()
        print("album count \(albums.count)")
    }
    
    func initView()
    {
        // Testing with sample images
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
    
    //MARK: Delegate - update from iTunes
    func updateData(albums: [Album])
    {
        sortAndAssignAlbums(albums)
        
        //Initialize URL array to download album images
        var urls:[NSURL] = [NSURL]()
        for album in self.albums
        {
            self.albums.append(album)
            urls.append(NSURL(string: album.albumImageURL)!)
        }
        
        //Download Images for Album
        let retrieveImage = RetrieveImage()
        retrieveImage.retrieveAlbumImages(urls, dlImageDelegate: self)
        
    }
    
    //MARK: Delegate - download images
    func updateImageArray(image: UIImage, total: Int)
    {
        self.pageImages.append(image)
        
        if pageImages.count == total
        {
            dispatch_async(dispatch_get_main_queue(), {
                // code here
                self.initView()
                
            })
        }
    }
    
    //MARK: Populate labels
    func populateLabels()
    {
        if self.currentAlbum != nil
        {
            self.artistLabel.text = self.currentAlbum!.artist
            self.albumLabel.text = self.currentAlbum!.albumName
            self.genreLabel.text = self.currentAlbum!.genre
        }
    }
    
    //MARK: Lazy loading for scroll view
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
    
    //MARK: ScrollView delegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // Load the pages that are now on screen
        loadVisiblePages()
    }
    
    @IBAction func nextClicked(sender: AnyObject) {
    }
    
    //MARK: Change to next view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showDetailsVC"
        {
            let detailsVC:DetailedController = segue.destinationViewController as! DetailedController
            self.delegate = detailsVC
            print("Check value - \(self.currentAlbum!.artist) ")
            self.delegate?.updateAllElements(self.currentAlbum!)
            
        }
        
    }
    
    //MARK: sort Album array
    func sortAndAssignAlbums(albums: [Album])
    {
        if albums.count == 0 {
            return
        }
        
        let sortedAlbums:[Album] = albums.sort({$0.albumName < $1.albumName})
        
        for album in sortedAlbums
        {
            self.albums.append(album)
        }
    }

}

