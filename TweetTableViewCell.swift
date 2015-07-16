//
//  TweetTableViewCell.swift
//  SmashTag
//
//  Created by Patrick Pan on 6/24/15.
//  Copyright (c) 2015 Patrick Pan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    
    var tweet: Tweet? {
        didSet{
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    struct hightlightColors{
        static let userMentionColor = UIColor.blueColor()
        static let urlMentionColor = UIColor.brownColor()
        static let hashMentionColor = UIColor.yellowColor()
    }
    
    func updateUI(){
        titleLabel?.attributedText = nil
        bodyLabel?.attributedText = nil
        tweetImage?.image = nil
        
        if let tweet = self.tweet {
            let text = tweet.text
            //myLabel.backgroundColor = UIColor.grayColor()
            bodyLabel?.attributedText = highlightText(tweet)
            
            titleLabel?.text = "\(tweet.user)"
            
            if let profileImageURL = tweet.user.profileImageURL {
                if let imageData = NSData(contentsOfURL: profileImageURL){ //blocks main thread!
                    tweetImage?.image = UIImage(data: imageData)
                }
            }
            
        }
        
    }
    
    func highlightText(tweet: Tweet) -> NSAttributedString{
        let attributedText = NSMutableAttributedString(string: tweet.text)
        
        //hightlight urls..
        for keywords in tweet.urls{
            attributedText.addAttribute(NSBackgroundColorAttributeName, value: hightlightColors.urlMentionColor, range: keywords.nsrange)
        }
        
        //hightlight hashtags..
        for keywords in tweet.userMentions{
            attributedText.addAttribute(NSBackgroundColorAttributeName, value: hightlightColors.userMentionColor, range: keywords.nsrange)
        }
        
        //hightlight usermentions...
        for keywords in tweet.hashtags{
            attributedText.addAttribute(NSBackgroundColorAttributeName, value: hightlightColors.hashMentionColor, range: keywords.nsrange)
        }
        
        return attributedText
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
