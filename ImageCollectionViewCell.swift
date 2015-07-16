//
//  ImageCollectionViewCell.swift
//  SmashTag
//
//  Created by Patrick Pan on 7/9/15.
//  Copyright (c) 2015 Patrick Pan. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var imageUrl : NSURL? {
        didSet{
            fetchImage()
        }
    }
    
    

    func fetchImage(){
        if let url = imageUrl{
            let qos = Int(QOS_CLASS_USER_INITIATED.value)
            dispatch_async(dispatch_get_global_queue(qos, 0)){ () -> Void in
                let imageData = NSData(contentsOfURL: url)
                dispatch_async(dispatch_get_main_queue()){ () -> Void in
                    if imageData != nil {
                        self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
                        self.imageView.image = UIImage(data: imageData!)
                        
                    } else {
                        self.imageView = nil
                    }
                }
            }
        }
    }

    
    
}
