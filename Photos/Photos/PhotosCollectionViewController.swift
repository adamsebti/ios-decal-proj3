//
//  PhotosCollectionViewController.swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    var photos: [Photo] = [Photo]()
    var imageIndex: Int = 0
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()


        let api = InstagramAPI()
        api.loadPhotos(didLoadPhotos)
        // FILL ME IN
    }

    /* 
     * IMPLEMENT ANY COLLECTION VIEW DELEGATE METHODS YOU FIND NECESSARY
     * Examples include cellForItemAtIndexPath, numberOfSections, etc.
     */
    
    /* Creates a session from a photo's url to download data to instantiate a UIImage. 
       It then sets this as the imageView's image. */
    func loadImageForCell(photo: Photo, imageView: UIImageView) {
        let url = NSURL(string: photo.url)
        if let data = NSData(contentsOfURL: url!) {
            imageView.image = UIImage(data: data)
        }
    }

    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        let imageView = UIImageView(frame: CGRectMake(-100, -100, 700, 400))
        if(photos.count > 1){
            loadImageForCell(photos[imageIndex], imageView: imageView)
            imageIndex++
            if(imageIndex >= photos.count){
                imageIndex = 0;
            }
        }
        
        cell.addSubview(imageView)
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.selectedIndex = indexPath.row
        performSegueWithIdentifier("PhotoViewController", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PhotoViewController" {
            let photo:Photo = photos[self.selectedIndex]
            let targetVC = segue.destinationViewController as! PhotoViewController
            targetVC.photo = photo
        }
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    
    /* Completion handler for API call. DO NOT CHANGE */
    func didLoadPhotos(photos: [Photo]) {
        self.photos = photos
        self.collectionView!.reloadData()
    }
    
}

