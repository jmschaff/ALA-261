//
//  AccountCreationViewController.swift
//  USwap
//
//  Created by John M. Schaffer II on 4/5/17.
//  Copyright © 2017 USwap. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AccountCreationViewController: UIViewController, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameGroup: UIImageView!
    
    @IBOutlet weak var lastNameGroup: UIImageView!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var phoneGroup: UIImageView!
    
    @IBOutlet weak var universityGroup: UIImageView!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var universityTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var universityDropDown: UIPickerView!
    
    @IBOutlet weak var dropDownMask: UILabel!
    
    @IBOutlet weak var profilePhoto: UIImageView!
    
    var constants: Constants = Constants()
    
    var photoUpload: Bool = true;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        firstNameTextField.addTarget(self, action: #selector(self.validateTextFields), for: UIControlEvents.editingDidEnd)
        lastNameTextField.addTarget(self, action: #selector(self.validateTextFields), for: UIControlEvents.editingDidEnd)
        phoneTextField.addTarget(self, action: #selector(self.validateTextFields), for: UIControlEvents.editingDidEnd)
        universityTextField.addTarget(self, action: #selector(self.validateTextFields), for: UIControlEvents.allEditingEvents)
        
        profilePhoto.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(uploadPhoto)))
        
        profilePhoto.setRounded()
        
        self.hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func validateTextFields() {
        
        if firstNameTextField.text != "" && lastNameTextField.text != "" && phoneTextField.text != "" && universityTextField.text != ""  && photoUpload{
            registerButton.isEnabled = true
            
        } else {
            registerButton.isEnabled = false
        }
    }
    
    //UIPicker Functions
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return constants.schools.count;
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        self.view.endEditing(true)
        self.universityTextField.endEditing(true)
        return constants.schools[row] as? String
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.universityTextField.text = constants.schools[row] as? String
        self.universityDropDown.isHidden = true
        self.dropDownMask.isHidden = true;
        validateTextFields()
        
    }
    
    //registering user
    @IBAction func registerUser(_ sender: Any) {
        
        //Upload Data to Storage
        let imageName = NSUUID().uuidString
        let storageRef = FIRStorage.storage().reference().child("profile_images").child("\(imageName).png")
        if let uploadData = UIImagePNGRepresentation(self.profilePhoto.image!){
            
            storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
            
                if error != nil {
                    print(error!)
                    return
                }
            
                if let profileImageURL = metadata?.downloadURL()?.absoluteString {
                    let values = ["first_name": self.firstNameTextField.text!, "last_name": self.lastNameTextField.text!, "profileImageURL": profileImageURL, "phone_number": self.phoneTextField.text!, "university": self.universityTextField.text!]
                    self.updateUser(values: values as [String : AnyObject])
                }
                
            })
            
        }
        
    }
    
    func updateUser(values: [String:AnyObject]) {
        
        let user: User = User()

        let firebaseUser = FIRAuth.auth()?.currentUser
        
        user.first_name = values["first_name"] as! String
        user.last_name = values["last_name"] as! String
        user.userUID = (firebaseUser?.uid)!
        user.email = (firebaseUser?.email)!
        user.photo = values["profileImageURL"] as! String
        user.phone_number = values["phone_number"] as! String
        user.school = values["university"] as! String
        
        let changeRequest = FIRAuth.auth()?.currentUser?.profileChangeRequest()
        changeRequest?.displayName = user.first_name + " " + user.last_name
        changeRequest?.photoURL = NSURL(string: user.photo) as URL?
        changeRequest?.commitChanges() { (error) in
            if error != nil {
                print(error!)
                return
            }
        }
        
        //upload to database
        writeUserDatatoDB(user: user)
        
        self.performSegue(withIdentifier: "homeSegue", sender: nil)

    }
    
    func writeUserDatatoDB(user: User) {
        
        let userDatabase = FIRDatabase.database().reference().child("users")
        userDatabase.child(user.userUID).setValue(["first_name": user.first_name, "last_name": user.last_name, "email": user.email, "profilePhotoURL": user.photo, "phone_number": user.phone_number, "school": user.school])
        userDatabase.child(user.userUID).child("listings").setValue(["count": 0])
        
    }
    //upload photo
    func uploadPhoto() {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true;
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            profilePhoto.image = selectedImage
        }
        photoUpload = true;
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancel picker")
        dismiss(animated: true, completion: nil)
    }
    
    //textbox actions
    
    @IBAction func firstEditBegan(_ sender: Any) {
        
        firstNameGroup.alpha = 0;
    }
    
    @IBAction func firstEditEnd(_ sender: Any) {
        
        if firstNameTextField.text == "" {
            firstNameGroup.alpha = 1
        }
    }
    
    @IBAction func lastEditBegan(_ sender: Any) {
        
        lastNameGroup.alpha = 0
    }
    
    @IBAction func lastEditEnd(_ sender: Any) {
        
        if lastNameTextField.text == "" {
            lastNameGroup.alpha = 1
        }
    }
    
    @IBAction func phoneEditBegan(_ sender: Any) {
        
        phoneGroup.alpha = 0
    }
    
    @IBAction func phoneEditEnd(_ sender: Any) {
        
        if phoneTextField.text == "" {
            phoneGroup.alpha = 1
        }
    }
    
    @IBAction func universityEditBegan(_ sender: Any) {
        
        universityGroup.alpha = 0
        dropDownMask.isHidden = false
        self.universityDropDown.isHidden = false
        universityTextField.endEditing(true)
    }
    
    @IBAction func universityEditEnd(_ sender: Any) {
        
        if universityTextField.text == "" {
            universityGroup.alpha = 1
        }
    }
}

