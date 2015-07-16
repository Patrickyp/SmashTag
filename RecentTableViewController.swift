//
//  RecentTableViewController.swift
//  SmashTag
//
//  Created by Patrick Pan on 7/5/15.
//  Copyright (c) 2015 Patrick Pan. All rights reserved.
//

import UIKit

class RecentTableViewController: UITableViewController {

    var recentSearch:[String] = [String]()
    
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
    @IBOutlet var recentTableView: UITableView!
    
    @IBAction func clearHistory(sender: UIBarButtonItem) {
        defaults.setObject([String](), forKey: "savedSearch")
        recentSearch = [String]()
        self.recentTableView.reloadData()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        if let saved = defaults.objectForKey("savedSearch") as? [String]{
            recentSearch = saved
            recentTableView.reloadData()
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedSearch = defaults.objectForKey("savedSearch") as? [String] {
            recentSearch = defaults.objectForKey("savedSearch") as [String]
            //println("\(recentSearch)")
        } else {
            println("No search found!")
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return recentSearch.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("recent search cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = recentSearch[indexPath.row]
        // Configure the cell...
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("cell selected")
        let mvc = self.tabBarController?.viewControllers?.first?.visibleViewController as TweetTableViewController
        mvc.searchText = recentSearch[indexPath.row]
        self.tabBarController?.selectedIndex = 0 // go back to tab 1
        
        //self.tabBarController?.viewControllers[0]
        //self.performSegueWithIdentifier("recent to search", sender: tableView)
    }
    
    //delete cell
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            if let array = defaults.objectForKey("savedSearch") as? [String]{
                var newArray = array
                newArray.removeAtIndex(indexPath.row)
                defaults.setObject(newArray, forKey: "savedSearch")
                recentSearch = newArray
                recentTableView.reloadData()
            }
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }


}
