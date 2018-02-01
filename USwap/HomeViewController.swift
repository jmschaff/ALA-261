//
//  HomeViewController.swift
//  USwap
//
//  Created by John M. Schaffer II on 3/13/17.
//  Copyright © 2017 USwap. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class HomeViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    
    var viewType: String = "home"
    
    
    @IBOutlet weak var itemCollectionView: UICollectionView!
    
    var initialCollectionSize: Int = 18
    
    var listingItems = [Item]()
    
    var showItem: Item = Item()
    
    let firebaseUser = FIRAuth.auth()?.currentUser
    
    let itemsDatabase = FIRDatabase.database().reference().child("items")
    
    override func viewWillAppear(_ animated: Bool) {
        reloadItemData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return initialCollectionSize
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeItemCell", for: indexPath as IndexPath) as! HomeItemCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        //cell.myLabel.text = self.items[indexPath.item]
        if (listingItems.count < initialCollectionSize)
        {
            return cell
        }
        
        if let url = NSURL(string: self.listingItems[indexPath.row].photoURL) {
            if let data = NSData(contentsOf: url as URL){
                if let itemImage = UIImage(data: data as Data) {
                    cell.homeImageView.image = itemImage
                }
            }
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        showItem = Item(copyItem: listingItems[indexPath.row])
        
        performSegue(withIdentifier: "showItem", sender: Any?.self)
        
    }
    
    func reloadItemData()
    {
    
        listingItems.removeAll()
        
        itemsDatabase.queryOrderedByKey().observe(.childAdded, with: { snapshot in
            
            let item = snapshot.value as! NSDictionary
            
            item.setValue(snapshot.key, forKey: "itemID")
            
            self.listingItems.append(Item(itemDict: item))
            
            self.listingItems.sort{$1.timestamp < $0.timestamp }
            self.itemCollectionView.reloadData()
            
        })
    }
    
    @IBAction func recentButtonPressed(_ sender: Any) {
        return
    }
    
    
}
