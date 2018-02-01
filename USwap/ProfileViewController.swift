//
//  ProfileViewController.swift
//  USwap
//
//  Created by John M. Schaffer II on 3/10/17.
//  Copyright © 2017 USwap. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var profilePhoto: UIImageView!
    
    @IBOutlet weak var listingsCollection: UICollectionView!
    
    @IBOutlet weak var displayName: UILabel!
    
    @IBOutlet weak var listingsButton: UIButton!
    
    @IBOutlet weak var likesButton: UIButton!
    
    @IBOutlet weak var cartButton: UIButton!
    
    var viewType: String = "profile"
    
    var showItem: Item = Item()
        
    let firebaseUser = FIRAuth.auth()?.currentUser
    
    let itemsDatabase = FIRDatabase.database().reference().child("items")
    
    var listings: NSMutableArray = []
    var listingsCount: Int = -1
    var listingsItems = [Item]()
    
    var likes: NSMutableArray = []
    var likesItems: NSMutableArray = []
    
    var cart: NSMutableArray = []
    var cartItems: NSMutableArray = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        profilePhoto.setRounded()
        
        let url = firebaseUser?.photoURL
        let data = try? Data(contentsOf: url!)
        profilePhoto.image = UIImage(data: data!)
        
        if let layout = listingsCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
        
        displayName.text = firebaseUser?.displayName
        
        /*let listingsDatabase = FIRDatabase.database().reference().child("users").child((firebaseUser?.uid)!).child("listings")
        
        listingsDatabase.queryOrdered(byChild: "listings").observe(.childAdded, with: { snapshot in
            
                let item = snapshot.key
                if (item == "count")
                {
                    self.listingsCount = snapshot.value as! Int
                    self.populateListings()
                    return
                }
            
                self.listings.add(item)
        })*/
    }
    override func viewWillAppear(_ animated: Bool) {
        reloadListingsData()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadListingsData()
    {
        listings.removeAllObjects()
        listingsCount = -1
        listingsItems.removeAll()
        
        let listingsDatabase = FIRDatabase.database().reference().child("users").child((firebaseUser?.uid)!).child("listings")
        
        listingsDatabase.queryOrdered(byChild: "listings").observe(.childAdded, with: { snapshot in
            
            let item = snapshot.key
            if (item == "count")
            {
                self.listingsCount = snapshot.value as! Int
                self.populateListings()
                return
            }
            
            self.listings.add(item)
        })
    }
    
    func populateListings()
    {
        
        if (listings.count == listingsCount)
        {
            for itemID in listings {
                itemsDatabase.child(itemID as! String).observeSingleEvent(of: .value, with: { (snapshot) in
                    // Get item dictionary
                    let value = snapshot.value as! NSDictionary
                    value.setValue(snapshot.key, forKey: "itemID")
                    self.listingsItems.append(Item(itemDict: value))
                    self.listingsItems.sort{$1.timestamp < $0.timestamp }
                    self.listingsCollection.reloadData()
                    // ...
                }) { (error) in
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func populateLikes()
    {
        
    }
    
    func populateCart()
    {
        
    }
    
    @IBAction func listingsPressed(_ sender: Any) {
        if listingsButton.alpha == 1 {
            return
        }
        
        listingsButton.alpha = 1
        likesButton.alpha = 0.5
        cartButton.alpha = 0.5
        
    }
    
    @IBAction func likesPressed(_ sender: Any) {
        if likesButton.alpha == 1 {
            return
        }
        
        likesButton.alpha = 1
        listingsButton.alpha = 0.5
        cartButton.alpha = 0.5
    }

    @IBAction func cartPressed(_ sender: Any) {
        if cartButton.alpha == 1 {
            return
        }
        
        cartButton.alpha = 1
        likesButton.alpha = 0.5
        listingsButton.alpha = 0.5
    }
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 
        return listingsCount
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath as IndexPath) as! ProfilePhotoCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        //cell.myLabel.text = self.items[indexPath.item]
        if (listingsCount == -1 || listingsItems.count != listingsCount)
        {
            return cell
        }
        let urlString = self.listingsItems[indexPath.row].photoURL
        let url = NSURL(string: urlString)
        let data = try? Data(contentsOf: url as! URL)
        cell.itemImageView.image = UIImage(data: data!)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        showItem = Item(copyItem: listingsItems[indexPath.row])
        
        performSegue(withIdentifier: "showItem", sender: Any?.self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // get a reference to the second view controller
        if (segue.identifier == "showItem")
        {
            let itemViewController = segue.destination as! ItemViewController
            
            itemViewController.previousView = viewType

            itemViewController.item = Item(copyItem: showItem)
        }
    }
    
    
}

