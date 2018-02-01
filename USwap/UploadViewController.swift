//
//  UploadViewController.swift
//  USwap
//
//  Created by John M. Schaffer II on 3/10/17.
//  Copyright © 2017 USwap. All rights reserved.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIPickerViewDelegate {
    
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var uploadPhotoButton: UIButton!
    
    @IBOutlet weak var postButton: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var categoryTextField: UITextField!
    
    @IBOutlet weak var styleTextField: UITextField!
    
    @IBOutlet weak var sizeTextField: UITextField!
    
    @IBOutlet weak var colorTextField: UITextField!
    
    @IBOutlet weak var conditionTextField: UITextField!
    
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var rentButton: UIButton!
    var rent = true
    
    @IBOutlet weak var sellButton: UIButton!
    var sell = false
    
    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var categoryPickerMask: UILabel!
    
    @IBOutlet weak var stylePickerView: UIPickerView!
    @IBOutlet weak var stylePickerMask: UILabel!
    
    @IBOutlet weak var sizePickerView: UIPickerView!
    @IBOutlet weak var sizePickerMask: UILabel!
    
    @IBOutlet weak var colorPickerView: UIPickerView!
    @IBOutlet weak var colorPickerMask: UILabel!
    
    @IBOutlet weak var conditionPickerView: UIPickerView!
    @IBOutlet weak var conditionPickerMask: UILabel!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var constants: Constants = Constants()
    
    var imagePicker = UIImagePickerController()
    
    var photoUpload = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(uploadPhoto)))
        
        //validateTextFields
        nameTextField.addTarget(self, action: #selector(self.validateTextFields), for: UIControlEvents.allEditingEvents)
        categoryTextField.addTarget(self, action: #selector(self.validateTextFields), for: UIControlEvents.allEditingEvents)
        styleTextField.addTarget(self, action: #selector(self.validateTextFields), for: UIControlEvents.allEditingEvents)
        colorTextField.addTarget(self, action: #selector(self.validateTextFields), for: UIControlEvents.allEditingEvents)
        conditionTextField.addTarget(self, action: #selector(self.validateTextFields), for: UIControlEvents.allEditingEvents)
        priceTextField.addTarget(self, action: #selector(self.validateTextFields), for: UIControlEvents.allEditingEvents)
        
        
        self.hideKeyboardWhenTappedAround()
        
        //generate alert and ask user to upload from camera roll or take a photo
        uploadPhoto()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        uploadPhoto()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UIPicker Functions
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        if (pickerView == categoryPickerView)
        {
            return constants.itemTypes.count
        }
        if (pickerView == stylePickerView)
        {
            if (categoryTextField.text == "Dress")
            {
                return constants.dressStyle.count
            }
            if (categoryTextField.text == "Bottoms")
            {
                return constants.bottomStyle.count
            }
            if (categoryTextField.text == "Tops")
            {
                return constants.topStyle.count
            }
            if (categoryTextField.text == "Footwear")
            {
                return constants.shoeStyle.count
            }
            if (categoryTextField.text == "Accessories")
            {
                //return constants.shoeStyle.count
            }
            if (categoryTextField.text == "Other")
            {
                //return constants.shoeStyle.count
            }
        }
        if (pickerView == sizePickerView)
        {
            if (categoryTextField.text == "Dress")
            {
                return constants.dressSize.count
            }
            if (categoryTextField.text == "Bottoms")
            {
                return constants.dressSize.count
            }
            if (categoryTextField.text == "Tops")
            {
                return constants.topsSize.count
            }
            if (categoryTextField.text == "Footwear")
            {
                return constants.shoeSize.count
            }
            if (categoryTextField.text == "Accessories")
            {
                //return constants.shoeSize.count
            }
            if (categoryTextField.text == "Other")
            {
                //return constants.shoeSize.count
            }
        }
        if (pickerView == colorPickerView)
        {
            return constants.colors.count
        }
        if (pickerView == conditionPickerView)
        {
            return constants.itemCondition.count
        }
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        self.view.endEditing(true)
        if (pickerView == categoryPickerView)
        {
            self.categoryTextField.endEditing(true)
            return constants.itemTypes[row] as? String
        }
        if (pickerView == stylePickerView)
        {
            self.styleTextField.endEditing(true)
            if (categoryTextField.text == "Dress")
            {
                return constants.dressStyle[row] as? String
            }
            if (categoryTextField.text == "Bottoms")
            {
                return constants.bottomStyle[row] as? String
            }
            if (categoryTextField.text == "Tops")
            {
                return constants.topStyle[row] as? String
            }
            if (categoryTextField.text == "Footwear")
            {
                return constants.shoeStyle[row] as? String
            }
            if (categoryTextField.text == "Accessories")
            {
                //return constants.dressStyle[row] as? String
            }
            if (categoryTextField.text == "Other")
            {
                //return constants.dressStyle[row] as? String
            }
        }
        if (pickerView == sizePickerView)
        {
            self.sizeTextField.endEditing(true)
            if (categoryTextField.text == "Dress")
            {
                return constants.dressSize[row] as? String
            }
            if (categoryTextField.text == "Bottoms")
            {
                return constants.dressSize[row] as? String
            }
            if (categoryTextField.text == "Tops")
            {
                return constants.topsSize[row] as? String
            }
            if (categoryTextField.text == "Footwear")
            {
                return constants.shoeSize[row] as? String
            }
            if (categoryTextField.text == "Accessories")
            {
                //return constants.dressStyle[row] as? String
            }
            if (categoryTextField.text == "Other")
            {
                //return constants.dressStyle[row] as? String
            }
        }
        if (pickerView == colorPickerView)
        {
            self.colorTextField.endEditing(true)
            return constants.colors[row] as? String
        }
        if (pickerView == conditionPickerView)
        {
            self.conditionTextField.endEditing(true)
            return constants.itemCondition[row] as? String
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if (pickerView == categoryPickerView)
        {
        self.categoryTextField.text = constants.itemTypes[row] as? String
        self.categoryPickerView.isHidden = true
        self.categoryPickerMask.isHidden = true;
        }
        if (pickerView == stylePickerView)
        {
            if (categoryTextField.text == "Dress")
            {
                self.styleTextField.text = constants.dressStyle[row] as? String
            }
            if (categoryTextField.text == "Bottoms")
            {
                self.styleTextField.text = constants.bottomStyle[row] as? String
            }
            if (categoryTextField.text == "Tops")
            {
                self.styleTextField.text = constants.topStyle[row] as? String
            }
            if (categoryTextField.text == "Footwear")
            {
                self.styleTextField.text = constants.shoeStyle[row] as? String
            }
            if (categoryTextField.text == "Accessories")
            {
                //self.styleTextField.text = constants.dressStyle[row] as? String
            }
            if (categoryTextField.text == "Other")
            {
                //self.styleTextField.text = constants.dressStyle[row] as? String
            }
            self.stylePickerView.isHidden = true
            self.stylePickerMask.isHidden = true;
        }
        if (pickerView == sizePickerView)
        {
            if (categoryTextField.text == "Dress")
            {
                self.sizeTextField.text = constants.dressSize[row] as? String
            }
            if (categoryTextField.text == "Bottoms")
            {
                self.sizeTextField.text = constants.dressSize[row] as? String
            }
            if (categoryTextField.text == "Tops")
            {
                self.sizeTextField.text = constants.topsSize[row] as? String
            }
            if (categoryTextField.text == "Footwear")
            {
                self.sizeTextField.text = constants.shoeSize[row] as? String
            }
            if (categoryTextField.text == "Accessories")
            {
                //self.sizeTextField.text = constants.dressStyle[row] as? String
            }
            if (categoryTextField.text == "Other")
            {
                //self.sizeTextField.text = constants.dressStyle[row] as? String
            }
            self.sizePickerView.isHidden = true
            self.sizePickerMask.isHidden = true;
        }
        if (pickerView == colorPickerView)
        {
            self.colorTextField.text = constants.colors[row] as? String
            self.colorPickerView.isHidden = true
            self.colorPickerMask.isHidden = true;
        }
        if (pickerView == conditionPickerView)
        {
            self.conditionTextField.text = constants.itemCondition[row] as? String
            self.conditionPickerView.isHidden = true
            self.conditionPickerMask.isHidden = true;
        }
        validateTextFields()
    }
    
    @IBAction func categoryEditingBegan(_ sender: Any) {
        categoryPickerMask.isHidden = false
        self.categoryPickerView.isHidden = false
        postButton.isEnabled = false
        styleTextField.text = ""
        sizeTextField.text = ""
        categoryTextField.endEditing(true)
    }
    
    @IBAction func styleEditingBegan(_ sender: Any) {
        self.stylePickerView.reloadAllComponents();
        stylePickerMask.isHidden = false
        self.stylePickerView.isHidden = false
        styleTextField.endEditing(true)
    }
    
    @IBAction func sizeEditingBegan(_ sender: Any) {
        self.sizePickerView.reloadAllComponents()
        sizePickerMask.isHidden = false
        self.sizePickerView.isHidden = false
        sizeTextField.endEditing(true)
    }
    
    @IBAction func colorEditingBegan(_ sender: Any) {
        colorPickerMask.isHidden = false
        self.colorPickerView.isHidden = false
        colorTextField.endEditing(true)
    }
    
    @IBAction func conditionEditingBegan(_ sender: Any) {
        conditionPickerMask.isHidden = false
        self.conditionPickerView.isHidden = false
        conditionTextField.endEditing(true)
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Choose from Gallary", style: .default, handler: { _ in
                self.openGallary()
            }))
            
            alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: { _ in
                self.showUploadButton()
            }))

            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            itemImage.image = selectedImage
        }
        photoUpload = true;
        uploadPhotoButton.isHidden = true
        validateTextFields()
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func showUploadButton()
    {
        if (!photoUpload)
        {
            uploadPhotoButton.isHidden = false
        }
        else {
            uploadPhotoButton.isHidden = true;
        }
    }
    
    func uploadPhoto()
    {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: { _ in
            self.showUploadButton()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancel picker")
        if (!photoUpload)
        {
            uploadPhotoButton.isHidden = false
        }
        else {
            uploadPhotoButton.isHidden = true;
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func uploadPhotoButtonClicked(_ sender: Any) {
        //generate alert and ask user to upload from camera roll or take a photo
        
        uploadPhoto()
    }
    
    func validateTextFields() {
        
        if (nameTextField.text != "" && priceTextField.text != "" && postButton.isEnabled)
        {
            return
        }
        
        if nameTextField.text != "" && categoryTextField.text != "" {
            styleTextField.isHidden = false
            if (styleTextField.text != "")
            {
                sizeTextField.isHidden = false;
                if (sizeTextField.text != "")
                {
                    colorTextField.isHidden = false
                    if (colorTextField.text != "")
                    {
                        conditionTextField.isHidden = false
                        if (conditionTextField.text != "" && priceTextField.text != "")
                        {
                            if (photoUpload)
                            {
                                
                                postButton.isEnabled = true
                                
                            } else {
                                postButton.isEnabled = false
                            }
                        } else {
                            postButton.isEnabled = false
                        }
                    } else {
                        postButton.isEnabled = false
                    }
                } else {
                    postButton.isEnabled = false
                }
            } else {
                postButton.isEnabled = false
            }
        } else {
            postButton.isEnabled = false
        }
    }
    
    @IBAction func rentButtonPressed(_ sender: Any) {
        rent = true
        sell = false
        sellButton.setImage(UIImage(named: "Disabled Sell Button"), for: UIControlState.normal)
        rentButton.setImage(UIImage(named: "Enabled Rent Button"), for: UIControlState.normal)
    }
    
    @IBAction func sellButtonPressed(_ sender: Any) {
        rent = false
        sell = true
        sellButton.setImage(UIImage(named: "Enabled Sell Button"), for: UIControlState.normal)
        rentButton.setImage(UIImage(named: "Disabled Rent Button"), for: UIControlState.normal)
    }
    
    func uploadItemImageToStorage(item: Item){
        //Upload Data to Storage
        let imageID = NSUUID().uuidString
        let storageRef = FIRStorage.storage().reference().child("item_images").child("\(imageID).png")
        if let uploadData = UIImagePNGRepresentation(self.itemImage.image!){
            
            storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                else {
                    item.photoURL = (metadata?.downloadURL()?.absoluteString)!
                    self.writeItemDatatoDB(item: item)
                }
            })
        }
    }
    
    @IBAction func postItem(_ sender: Any) {
        
        self.view.isUserInteractionEnabled = false
        
        loadingIndicator.alpha = 1
        loadingIndicator.startAnimating()
        loadingIndicator.isHidden = false
        
        
        let uploadItem = Item()
        let firebaseUser = FIRAuth.auth()?.currentUser
        
        uploadItem.itemID = NSUUID().uuidString
        uploadItem.ownerUserUID = (firebaseUser?.uid)!
        uploadItem.ownerName = (firebaseUser?.displayName)!
        uploadItem.name = nameTextField.text!
        uploadItem.category = categoryTextField.text!
        uploadItem.style = styleTextField.text!
        uploadItem.size = sizeTextField.text!
        uploadItem.color = colorTextField.text!
        uploadItem.condition = conditionTextField.text!
        uploadItem.price = priceTextField.text!
        uploadItem.description = descriptionTextField.text!
        uploadItem.rent = rent
        uploadItem.sell = sell
        uploadItem.available = true
        uploadItem.renterUID = ""
        uploadItem.timestamp = "\(NSDate().timeIntervalSince1970 * 1000)"
        uploadItemImageToStorage(item: uploadItem)

    }
    
    func writeItemDatatoDB(item: Item) {
        
        let firebaseUser = FIRAuth.auth()?.currentUser
        
        let itemDatabase = FIRDatabase.database().reference().child("items").child(item.itemID)
        
        itemDatabase.setValue(["owner_userUID": item.ownerUserUID, "owner_name": item.ownerName, "photoURL": item.photoURL, "name": item.name, "category": item.category, "style": item.style, "size": item.size, "color": item.color, "condition": item.condition, "price": item.price, "description": item.description, "rent": item.rent, "sell": item.sell, "available": item.available, "renterUID": item.renterUID, "timestamp": item.timestamp])
        
        let categoryDatabase = FIRDatabase.database().reference().child("category").child(item.category).child(item.itemID)
        
        categoryDatabase.setValue(true)
        
        let styleDatabase = FIRDatabase.database().reference().child("style").child(item.style).child(item.itemID)
        
        styleDatabase.setValue(true)
        
        let sizeDatabase = FIRDatabase.database().reference().child("size").child(item.size).child(item.itemID)
        
        sizeDatabase.setValue(true)
        
        let colorDatabase = FIRDatabase.database().reference().child("color").child(item.color).child(item.itemID)
        
        colorDatabase.setValue(true)
        
        let userListingsDatabase = FIRDatabase.database().reference().child("users").child((firebaseUser?.uid)!).child("listings").child(item.itemID)
        
        userListingsDatabase.setValue(true)
        
        let userListingsCountDatabase = FIRDatabase.database().reference().child("users").child((firebaseUser?.uid)!).child("listings").child("count")
        
        userListingsCountDatabase.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get count value
            let value = (snapshot.value as? Int)! + 1
            
            userListingsCountDatabase.setValue(value)
            
        }) { (error) in
            print(error.localizedDescription)
        }
        

        alertPostSuccess()
        clearAllFields()
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
        loadingIndicator.alpha = 0
        self.view.isUserInteractionEnabled = true
    }
    
    func alertPostSuccess()
    {
        let alert  = UIAlertController(title: "Success", message: "Your item has been successfully listed", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func clearAllFields()
    {
        itemImage.image = UIImage(named: "Image Background")
        photoUpload = false
        showUploadButton()
        
        nameTextField.text = ""
        categoryTextField.text = ""
        
        styleTextField.text = ""
        styleTextField.isHidden = true
        
        sizeTextField.text = ""
        sizeTextField.isHidden = true
        
        colorTextField.text = ""
        colorTextField.isHidden = true
        
        conditionTextField.text = ""
        conditionTextField.isHidden = true
        
        priceTextField.text = ""
        
        descriptionTextField.text = ""
        
        validateTextFields()
        uploadPhoto()
    }
}

