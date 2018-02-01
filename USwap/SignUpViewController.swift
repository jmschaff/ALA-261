//
//  SignUpViewController.swift
//  USwap
//
//  Created by John M. Schaffer II on 3/13/17.
//  Copyright © 2017 USwap. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var emailGroup: UIImageView!
    @IBOutlet weak var passwordGroup: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        emailTextField.addTarget(self, action: #selector(self.validateTextFields), for: UIControlEvents.editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.validateTextFields), for: UIControlEvents.editingChanged)
        
        self.hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerAccount(_ sender: Any) {
        
        if emailTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            
            if (!checkEDU(email: emailTextField)) {
                
                emailErrorAlert()
                
                emailTextField.text = ""
                passwordTextField.text = ""
                registerButton.isEnabled = false;
                
                return;
            }
            
            FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                
                if error == nil {
                    print("You have successfully signed up")
                    //Goes to the Setup page which lets the user take a photo for their profile picture and also chose a username
                    
                    //Go to the HomeViewController if the login is sucessful
                    self.performSegue(withIdentifier: "continueSignUp", sender: nil)
                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    func checkEDU(email: UITextField) -> Bool {
        
        let index = email.text!.endIndex
        let indexBefore = email.text!.index(before: index)
        let indexBefore2 = email.text!.index(before: indexBefore)
        
        let e = email.text![email.text!.index(before: indexBefore2)]
        let d = email.text![email.text!.index(before: indexBefore)]
        let u = email.text![email.text!.index(before: index)]
        
        if (e == "e") {
            if (d == "d") {
                if (u == "u") {
                    return true;
                }
                else {
                    return false
                }
            }
            else {
                return false
            }
        }
        else {
            return false
        }
    }
    
    func emailErrorAlert() {
        
        let alertController = UIAlertController(title: "Error", message: "Please enter a valid university or college email with a .edu domain (Ex. John.Smith@umich.edu).", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
        
        return
    }
    
    func validateTextFields() {
        
        if emailTextField.text != "" && passwordTextField.text != ""{
            registerButton.isEnabled = true
            
        } else {
            registerButton.isEnabled = false
        }
    }
    
    /*@IBAction func nameBeganEdit(_ sender: Any) {
        nameGroup.alpha = 0;
    }
    
    @IBAction func nameEditingEnd(_ sender: Any) {
        if nameTextField.text == "" {
            nameGroup.alpha = 1;
        }
    }*/
    
    @IBAction func emailBeganEdit(_ sender: Any) {
        emailGroup.alpha = 0;
    }
    
    @IBAction func emailEditingEnd(_ sender: Any) {
        if emailTextField.text == "" {
            emailGroup.alpha = 1;
        }
    }

    @IBAction func passwordBeganEdit(_ sender: Any) {
        passwordGroup.alpha = 0;
    }
    @IBAction func passwordEditingEnd(_ sender: Any) {
        if passwordTextField.text == "" {
            passwordGroup.alpha = 1;
        }
    }
    
}
