//
//  IGFeedViewController.swift
//  Instagram
//
//  Created by Akhil  Kemburu on 8/19/16.
//  Copyright © 2016 Akhil  Kemburu. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class IGFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let HeaderViewIdentifier = "TableViewHeaderView"
    var isMoreDataLoading = false
    let queryLimit = 20
    
    var postObjects:  [PFObject] = []

    
        override func viewDidLoad() {
        super.viewDidLoad()
            
            tableView.dataSource = self
            
            //initial load
            tableView.delegate = self
            getQuery(queryLimit)
            self.tableView.reloadData()
            tableView.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HeaderViewIdentifier)
  
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func LogOut(sender: AnyObject) {
        PFUser.logOutInBackgroundWithBlock() { (error: NSError?) -> Void in
            if error != nil {
                print("logout fail")
                print(error)
            } else {
                print("logout success")
            }
        }
        self.performSegueWithIdentifier("LogOutSegue", sender: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return postObjects.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath) as! IGTableViewCell
        let image = postObjects[indexPath.section]
        let caption = postObjects[indexPath.section]["caption"]
        cell.captionLabel.text = caption as? String
        print(postObjects[indexPath.section])
        
             
        var instagramPost: PFObject! {
            didSet {
                cell.imageInFeed.file = instagramPost["media"] as? PFFile
                cell.imageInFeed.loadInBackground()
            }
        }
        instagramPost = image

        
        
        
        return cell
    }

    
    func stringToDate(date:String) -> NSDate {
        let formatter = NSDateFormatter()
        
        // Format 1
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let parsedDate = formatter.dateFromString(date)
        return parsedDate!
        
    }
    
    func getQuery(limit: Int) {
        let query = PFQuery(className:"Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.includeKey("createdAt")
        query.limit = limit
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) messages.")
                // Do something with the found objects
                if let objects = objects {
                    self.postObjects = objects
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
            self.tableView.reloadData()
        }
        self.isMoreDataLoading = false
    }

    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(HeaderViewIdentifier)! as UITableViewHeaderFooterView
        header.textLabel!.text = postObjects[section]["author"].username
        
        let profileView = PFImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15;
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
        profileView.layer.borderWidth = 1;
        
        let user = postObjects[section]["author"] as! PFUser
        
        var instagramProFileInFeed: PFObject! {
            didSet {
                print(postObjects[section]["author"])
                profileView.file = instagramProFileInFeed["ProfilePic"] as? PFFile
                profileView.loadInBackground()
            }
        }
        
        instagramProFileInFeed = user
        
        
        
        
        header.addSubview(profileView)
        
        
        
        return header
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.00
        
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "AvenirNext-Regular", size: 18.0)
        header.textLabel?.textAlignment = NSTextAlignment.Right
        
    }
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
