//
//  TweetTableViewController.swift
//  SmashTag
//
//  Created by Patrick Pan on 6/21/15.
//  Copyright (c) 2015 Patrick Pan. All rights reserved.
//

import UIKit

class TweetTableViewController: UITableViewController,UITextFieldDelegate {
    
    var tweets = [[Tweet]]()
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
    @IBOutlet weak var searchTextField: UITextField!{
        didSet{
            searchTextField.delegate = self
        }
    }
    
    @IBAction func refreshControl(sender: UIRefreshControl?) {
        if searchText != nil {
            if let request = nextRequestToAttempt {
                request.fetchTweets{ (newTweets) -> Void in
                    dispatch_async(dispatch_get_main_queue()) { () -> Void in
                        if newTweets.count > 0 {
                            self.tweets.insert(newTweets, atIndex: 0)
                            self.tableView.reloadData()
                            sender?.endRefreshing()
                        }
                    }
                }
            }
        } else {
            sender?.endRefreshing()
        }
    }
    
    @IBAction func goBack (segue: UIStoryboardSegue) {
        //dont need to do anything since searchText's didSet will fire
    }
    
    var searchText: String? = "#bb17" {
        didSet{
            lastSuccessfulRequest = nil
            searchTextField?.text = searchText
            if searchText != nil {
                defaultString = searchText! //add to NSUserDefaults
            }
            //tweets.removeAll()
            tableView.reloadData()
            refresh()
        }
    }
    
    var defaultString : String = ""{
        didSet{
            if let oldDefault = defaults.objectForKey("savedSearch") as? [String]{
                var newDefault = oldDefault
                if !contains(newDefault, defaultString){
                    newDefault.append(defaultString)
                    defaults.setObject(newDefault, forKey: "savedSearch")
                }
            } else {
                defaults.setObject([defaultString], forKey: "savedSearch")
            }
            
        }
    }
    var lastSuccessfulRequest: TwitterRequest?
    
    var nextRequestToAttempt: TwitterRequest? {
        if lastSuccessfulRequest == nil {
            if searchText != nil {
                return TwitterRequest(search: searchText!, count: 200)
            } else {
                return nil
            }
        } else {
            return lastSuccessfulRequest!.requestForNewer
        }
    }
    
    func refresh() {
        if refreshControl != nil {
            refreshControl?.beginRefreshing()
        }
        refreshControl(refreshControl)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let controllerStack = self.navigationController?.viewControllers.count
        println("Number of viewControllers tweettableview = \(controllerStack)")
        refresh()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == searchTextField {
            textField.resignFirstResponder()
            searchText = textField.text
            
        }
        return true
    }
    // MARK: - UITableViewDataSource
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return tweets.count
    }
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return tweets[section].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Tweets", forIndexPath: indexPath) as TweetTableViewCell
        cell.tweet = tweets[indexPath.section][indexPath.row]
        
        // Configure the cell...
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("tweetDetail", sender: tableView)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "tweetDetail" {
            if let destination = segue.destinationViewController as? DetailTableViewController{
                if let section = tableView.indexPathForSelectedRow()?.section{
                    if let row = tableView.indexPathForSelectedRow()?.row{
                        destination.tweet = tweets[section][row]
                    }
                }
            }
        }
        
        if segue.identifier == "imageCollection" {
            if let destination = segue.destinationViewController as? ImageCollectionViewController {
                destination.tweets = self.tweets
            }
        }
    }
    
    
}
