//
//  LoginViewController.swift
//  USwap
//
//  Created by John M. Schaffer II on 3/10/17.
//  Copyright © 2017 USwap. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var labelMask: UILabel!
    
    @IBOutlet weak var iconMask: UIImageView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var emailGroup: UIImageView!
    
    @IBOutlet weak var passwordGroup: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //Default Configuration
        emailTextField.addTarget(self, action: #selector(self.validateTextFields), for: UIControlEvents.editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.validateTextFields), for: UIControlEvents.editingChanged)
        
        self.hideKeyboardWhenTappedAround()
        
        var segueName = ""
        
        //Check is a user is logged in
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            
            if user != nil {
                
                let firebaseUser = FIRAuth.auth()?.currentUser
                
                if (firebaseUser?.photoURL == nil) {
                    segueName = "completeCreation"
                }
                else {
                    segueName = "loginToTab"
                }
                //Print into the console if successfully logged in
                print("You have successfully logged in")
                
                //Go to the HomeViewController if the login is sucessful
                self.performSegue(withIdentifier: segueName, sender: nil)
                
                print("User: {0} is logged in", user!.email!)
            } else {
                print("User is not logged in")
                self.labelMask.alpha = 0
                self.iconMask.alpha = 0
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func validateTextFields() {
        
        if emailTextField.text != "" && passwordTextField.text != ""{
            loginButton.isEnabled = true
            
        } else {
            
            loginButton.isEnabled = false
        }
    }
    
    @IBAction func logInButtonPressed(_ sender: AnyObject) {
        
        if self.emailTextField.text == "" || self.passwordTextField.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            FIRAuth.auth()?.signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                
                var segueName = ""
                
                if error == nil {
                    
                    let firebaseUser = FIRAuth.auth()?.currentUser
                    
                    if (firebaseUser?.photoURL == nil) {
                        segueName = "completeCreation"
                    }
                    else {
                        segueName = "loginToTab"
                    }
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    //Go to the HomeViewController if the login is sucessful
                    self.performSegue(withIdentifier: segueName, sender: nil)
                    
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func emailBeganEditing(_ sender: Any) {
        emailGroup.alpha = 0;
    }
    
    @IBAction func emailEndEditing(_ sender: Any) {
        if emailTextField.text == "" {
        emailGroup.alpha = 1;
        }
    }
    
    @IBAction func passwordBeganEditing(_ sender: Any) {
        passwordGroup.alpha = 0;
    }
    
    @IBAction func passwordEndEditing(_ sender: Any) {
        if passwordTextField.text == "" {
            passwordGroup.alpha = 1
        }
    }
    
    
    @IBAction func needHelpButtonPressed(_ sender: Any) {
        //do nothing
    }
    
}
