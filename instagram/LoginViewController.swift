//
//  LoginViewController.swift
//  instagram
//
//  Created by Vibhu Appalaraju on 9/27/18.
//  Copyright © 2018 Vibhu Appalaraju. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let newUser = PFUser()
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        newUser.signUpInBackground { (success: Bool,error: Error? ) -> Void in
            
            if success{
                print("Yay! Created a new user! ")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                
            }
            else{
                print(error?.localizedDescription as Any)
                if error?._code == 202 {
                    print("Username is taken!")
                    
                }
            }
            
            
        }
       
    }
    

    @IBAction func onSignIn(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) in
            
            if user != nil {
                
                print("you're logged in!")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                
            }
            
        }
        
       
        
    }
    
}
