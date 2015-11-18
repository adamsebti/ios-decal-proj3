//
//  PhotoViewController.swift
//  Photos
//
//  Created by Adam Sebti on 17/11/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//


import Foundation
import UIKit

class PhotoViewController: UIViewController{
    
    var photo: Photo!
    
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    var likePressed: Bool = false
    override func viewDidLoad(){
        likeBtn.addTarget(self, action: "likePicture", forControlEvents: .TouchUpInside)
        let url = NSURL(string: photo.url)
        if let data = NSData(contentsOfURL: url!) {
            photoView.image = UIImage(data: data)
            username.text = photo.username
            likes.text = "♥ : " + String(photo.likes)
        }

    }
    
    func likePicture(){
        if(likePressed){
            return
        }
        likes.text = "♥ : " + String(photo.likes + 1)
        likePressed = true
    }

    
    
}