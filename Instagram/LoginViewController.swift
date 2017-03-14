//
//  LoginViewController.swift
//  Instagram
//
//  Created by Akhil  Kemburu on 8/18/16.
//  Copyright © 2016 Akhil  Kemburu. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    
    @IBAction func SignIn(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(userName.text!, password: passWord.text!) { (user: PFUser?, error: NSError?) in
            if user != nil {
                print("you are logged in")
                self.performSegueWithIdentifier("LoginSegue", sender: nil)
            }
        }
    }
    
    @IBAction func SignUp(sender: AnyObject) {
        let newUser = PFUser()
        newUser.username = userName.text
        newUser.password = passWord.text
        
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                print("Yay")
                self.performSegueWithIdentifier("LoginSegue", sender: nil)

            }
            else {
                print(error?.localizedDescription)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "background")
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
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
