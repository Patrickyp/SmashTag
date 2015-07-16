//
//  ImageDetailViewController.swift
//  SmashTag
//
//  Created by Patrick Pan on 7/2/15.
//  Copyright (c) 2015 Patrick Pan. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.contentSize = imageOutlet.frame.size
            scrollView.setZoomScale(5, animated: false)
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.5
            scrollView.maximumZoomScale = 3
        }
    }

    @IBOutlet weak var imageOutlet: UIImageView!
    var imageUrl : NSURL?
    //var imageAspectRatio: Double?
    
    func fetchImage(){
        if let url = imageUrl{
            let imageData = NSData(contentsOfURL: url)
            if imageData != nil {
                self.imageOutlet.contentMode = UIViewContentMode.ScaleAspectFill
                imageOutlet.image = UIImage(data: imageData!)
                //imageOutlet.sizeToFit()
                
            } else {
                imageOutlet = nil
            }
        }
    }


    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageOutlet
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let controllerStack = self.navigationController?.viewControllers.count
        println("Number of viewControllers in imageDetailview = \(controllerStack)")
        fetchImage()
    }


}
