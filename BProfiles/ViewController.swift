//
//  ViewController.swift
//  BProfiles
//
//  Created by Louis-Philip Shahim on 2016/06/27.
//  Copyright © 2016 Louis-Philip Shahim. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    //password strength indicator
    let myPassword = PasswordStrengthIndicatorView()
    
    
    //animation constraints
    @IBOutlet weak var emailConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var passwordConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var loginConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var signupConstraint: NSLayoutConstraint!
    //*********************
    
    //animation engine
    var animEngine: AnimationEngine!

    
    //drawer container
    var drawerContainer : MMDrawerController?


    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.animEngine = AnimationEngine(constraints: [emailConstraint, passwordConstraint, loginConstraint])
    }
    
    override func viewDidAppear(animated: Bool) {
        self.animEngine.animateOnScreen(1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginBTapped(sender: AnyObject) {
        //progress
        let spinningActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        spinningActivity.labelText = "Logging in..."
        spinningActivity.detailsLabelText = "Please wait"
        
        let email = emailField.text
        let password = passwordField.text
        FIRAuth.auth()?.signInWithEmail(email!, password: password!, completion: {
            user, error in
            
            if (error != nil){
                print("error")
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            }else{
                print("user logged in")
                //stop progress
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                
                //Navigate to protected page
                let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                
                appDelegate.buildUserInterface()
                
            }
        })
    }
    
    @IBAction func resetBTapped(sender: AnyObject) {
        let prompt = UIAlertController.init(title: nil, message: "Email:", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.Default) { (action) in
            let userInput = prompt.textFields![0].text
            if (userInput!.isEmpty) {
                return
            }
            FIRAuth.auth()?.sendPasswordResetWithEmail(userInput!) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
        }
        prompt.addTextFieldWithConfigurationHandler(nil)
        prompt.addAction(okAction)
        presentViewController(prompt, animated: true, completion: nil);
    }
    
    
    @IBAction func signUpBTapped(sender: AnyObject) {
        
    }
    
    

}

