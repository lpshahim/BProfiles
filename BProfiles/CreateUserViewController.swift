//
//  CreateUserViewController.swift
//  BProfiles
//
//  Created by Louis-Philip Shahim on 2016/06/27.
//  Copyright © 2016 Louis-Philip Shahim. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CreateUserViewController: UIViewController {
    
    @IBOutlet weak var newEmailField: UITextField!
    @IBOutlet weak var newPasswordField: UITextField!
    @IBOutlet weak var rPasswordField: UITextField!
    @IBOutlet weak var categoryField: UITextField!
    
    
    //animation constraints
    @IBOutlet weak var emailConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var passwordConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rpasswordConstraint: NSLayoutConstraint!

    @IBOutlet weak var categoryConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var createConstraint: NSLayoutConstraint!
    
    //animation engine
    var animEngine: AnimationEngine!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*self.animEngine = AnimationEngine(constraints: [emailConstraint, passwordConstraint, rpasswordConstraint, categoryConstraint, createConstraint])*/
    }
    
    override func viewDidAppear(animated: Bool) {
        //self.animEngine.animateOnScreen(1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func usersAdd(){
        
        let email = newEmailField.text!
        let category = categoryField.text!
        
        let user : [String : AnyObject] = ["Email" : email , "Category" : category]
        
        let databaseRef = FIRDatabase.database().reference()
        
        databaseRef.child("users").childByAutoId().setValue(user)
        
    }
    
    @IBAction func createBTapped(sender: AnyObject) {
        
        
        let nEmail = newEmailField.text
        let nPass = newPasswordField.text
        let rPass = rPasswordField.text
        
        if (nEmail != nil) || (nPass != nil) && (nPass == rPass) {
            
            FIRAuth.auth()?.createUserWithEmail(nEmail!, password: nPass!) { (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                    
                }else{
                    print("Successfully created")
                    self.dismissViewControllerAnimated(true, completion: nil)
                    self.usersAdd()
                }
            }}else
            {
            print("Missing fields or passwords dont match")
        }
    }
    @IBAction func cancelBTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
