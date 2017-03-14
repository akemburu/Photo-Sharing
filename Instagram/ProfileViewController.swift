//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Akhil  Kemburu on 8/20/16.
//  Copyright © 2016 Akhil  Kemburu. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var bioField: UITextField!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var profilePic: PFImageView!
    var postObjects:  [PFObject] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        
        profilePic.clipsToBounds = true
        profilePic.layer.cornerRadius = 37;
        profilePic.layer.masksToBounds = true
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self

        getQuery(20)
        usernameLabel.text = PFUser.currentUser()?["username"] as? String
        usernameLabel?.font = UIFont(name: "AvenirNext-Regular", size: 22.0)
        let myBio = PFUser.currentUser()?["Bio"] as? String
        
            if myBio != nil {
            
            bioLabel.text = myBio
            
            bioLabel?.font = UIFont(name: "AvenirNext-Regular", size: 12.0)
        
        }
            else {
            bioLabel.text = "Hello, I'm using myGram"
            bioLabel?.font = UIFont(name: "AvenirNext-Regular", size: 12.0)
        
        
        }


        
        let user = PFUser.currentUser()
        print("Hello \(user!["ProfilePic"])")
        


        var instagramProFile: PFObject! {
                didSet {
                   profilePic.file = instagramProFile["ProfilePic"] as? PFFile
                    profilePic.loadInBackground()
                }
            }
            
            instagramProFile = PFUser.currentUser()
        
        bioField.hidden = true
        saveButton.hidden = true
        // Do any additional setup after loading the view.
    }

    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postObjects.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PersonalPicsCV", forIndexPath: indexPath) as! IGCollectionViewCell
        let image = postObjects[indexPath.row]
        let caption = postObjects[indexPath.row]["caption"]
        let author = postObjects[indexPath.row]["author"]

        
        var instagramPost: PFObject! {
            didSet {
                print(instagramPost)
                cell.personalPictures.file = instagramPost["media"] as? PFFile
                cell.personalPictures.loadInBackground()
            }
        }
        instagramPost = image
    
        return cell
    }
    
    func getQuery(limit: Int) {
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.whereKey("author", equalTo: PFUser.currentUser()!)
        query.limit = limit
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                print("Successfully retrieved \(objects!.count) messages.")
                
                if let objects = objects {
                    self.postObjects = objects
                }
                else {
                    print("Recieved error: \(error!) \(error!.userInfo)")
                }
            }
            self.collectionView.reloadData()

        }
    }
    
    
    @IBAction func TaptoLoadPF(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func TaptoLoadBio(sender: AnyObject) {
        bioField.hidden = false
        saveButton.hidden = false
        
        
        
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        profilePic.image = editedImage
        let user = PFUser.currentUser()
        let imagePFFile = Post.getPFFileFromImage(editedImage)
        user!["ProfilePic"] = imagePFFile
        user!.saveInBackground()
        // Do something with the images (based on your use case)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismissViewControllerAnimated(true, completion: nil)
        
    }


    @IBAction func saveBio(sender: AnyObject) {
        let bio = bioField.text
        saveButton.hidden = true
        bioField.hidden = true
        let user = PFUser.currentUser()
        user!["Bio"] = bio
        user!.saveInBackground()
        bioLabel.text = bio
        
        
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
