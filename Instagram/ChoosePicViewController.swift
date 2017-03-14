//
//  ChoosePicViewController.swift
//  Instagram
//
//  Created by Akhil  Kemburu on 8/20/16.
//  Copyright © 2016 Akhil  Kemburu. All rights reserved.
//

import UIKit

class ChoosePicViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var selectedImg: UIImageView!
    @IBOutlet weak var chooseImage: UIButton!
    @IBOutlet weak var captionTextField: UITextField!
    
    
    @IBAction func PostImage(sender: AnyObject) {
        if selectedImg.image  != nil {
            let image = selectedImg.image
            let caption = captionTextField.text as String!
            Post.postUserImage(image!, withCaption: caption, withCompletion: nil)
            self.performSegueWithIdentifier("newPictureSegue", sender: nil)
    }
        
    }
    
    @IBAction func TaptoLoad(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    

    
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        selectedImg.image = editedImage
        // Do something with the images (based on your use case)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismissViewControllerAnimated(true, completion: nil)
        if selectedImg.image != nil {
            chooseImage.hidden = true
            captionTextField.hidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captionTextField.hidden = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
