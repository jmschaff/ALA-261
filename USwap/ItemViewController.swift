//
//  ItemViewController.swift
//  USwap
//
//  Created by John M. Schaffer II on 4/13/17.
//  Copyright © 2017 USwap. All rights reserved.
//

import Foundation
import UIKit

class ItemViewController: UIViewController {
    
    var item: Item = Item()
    
    @IBOutlet weak var listerName: UIButton!
    
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var itemName: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var sizeLabel: UILabel!
    
    @IBOutlet weak var conditionLabel: UILabel!
    
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    var previousView: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        listerName.setTitle(item.ownerName, for: UIControlState())
        itemName.text = item.name
        priceLabel.text = "$" + item.price
        sizeLabel.text = item.size
        conditionLabel.text = item.condition
        if (item.rent)
        {
            stateLabel.text = "Rent"
        }
        else
        {
            stateLabel.text = "Sell"
        }
        descriptionLabel.text = item.description
        
        let urlString = item.photoURL
        let url = NSURL(string: urlString)
        let data = try? Data(contentsOf: url as! URL)
        itemImage.image = UIImage(data: data!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func likeButtonPressed(_ sender: Any) {
        likeButton.setImage(UIImage(named: "Heart Liked"), for: UIControlState.normal)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        if previousView == "home"{
            performSegue(withIdentifier: "itemToHome", sender: nil)
        }
        else if previousView == "category" {
            performSegue(withIdentifier: "itemToCategory", sender: nil)
        }
        else if previousView == "profile" {
            performSegue(withIdentifier: "itemToProfile", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "itemToProfile"){
            if let tabVC = segue.destination as? UITabBarController{
                tabVC.selectedIndex = 4
            }
        }
        if(segue.identifier == "itemToCategory"){
            if let tabVC = segue.destination as? UITabBarController{
                tabVC.selectedIndex = 1
            }
        }
        if(segue.identifier == "itemToHome"){
            if let tabVC = segue.destination as? UITabBarController{
                tabVC.selectedIndex = 0
            }
        }
    }

    
    
}
