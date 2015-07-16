//
//  ImageTableViewCell.swift
//  SmashTag
//
//  Created by Patrick Pan on 6/29/15.
//  Copyright (c) 2015 Patrick Pan. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    var imageURL : NSURL? {
        didSet{
            updateUI()
        }
    }

    func updateUI(){
        if let url = imageURL {
            let qos = Int(QOS_CLASS_USER_INITIATED.value)
            dispatch_async(dispatch_get_global_queue(qos, 0)){ () -> Void in
                let imageData = NSData(contentsOfURL: url)
                dispatch_async(dispatch_get_main_queue()){ () -> Void in
                    if imageData != nil {
                        self.imageOutlet?.image = UIImage(data: imageData!)
                    } else {
                        println("Image data nil!")
                    }
                }
            }
        }
    }
    
    @IBOutlet weak var imageOutlet: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
