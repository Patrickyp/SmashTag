//
//  ImageCollectionViewController.swift
//  SmashTag
//
//  Created by Patrick Pan on 7/8/15.
//  Copyright (c) 2015 Patrick Pan. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class ImageCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var tweets = [[Tweet]]()
    var filteredTweets = [Tweet]()

    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredTweets = removeNonImageTweets()
        let controllerStack = self.navigationController?.viewControllers.count
        println("Number of viewControllers in imageCollectionview = \(controllerStack)")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    private func removeNonImageTweets() -> [Tweet] {
        var tempTweets = [Tweet]()//(count tweets.count, repeatedValue: [Tweet])
        
        let sectionCount = tweets.count
        //println("\(tweets[0].count) tweets originally..., \(sectionCount) sections")
        
        for var x = 0; x < sectionCount; ++x{
            let rowCount = tweets[x].count
            for var y = 0; y < rowCount; ++y{
                let count = tweets[x][y].media.count
                if count > 0{
                    let currentTweet = tweets[x][y]
                    tempTweets.append(currentTweet)
                }
            }
        }
        //println("\(tempTweets.count) tweets have image...")
        return tempTweets
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        var destination = segue.destinationViewController as? UIViewController
        if let navcon = destination as? UINavigationController {
            destination = navcon.visibleViewController
        }
        
        if let DTVC = destination as? DetailTableViewController{
            if let indexPath = collectionView?.indexPathForCell(sender as UICollectionViewCell) {
                let tweet = filteredTweets[indexPath.row]
                DTVC.tweet = tweet
                
            }
        }
        
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return filteredTweets.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCollectionCell", forIndexPath: indexPath) as ImageCollectionViewCell
        cell.backgroundColor = UIColor.blackColor()
        cell.imageUrl = filteredTweets[indexPath.row].media[0].url
        // Configure the cell
    
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        //let width = filteredTweets[indexPath.row].media TODO
        return CGSize(width: 100, height: 100)
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //println("Selected \(indexPath.row)")
    }
    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
