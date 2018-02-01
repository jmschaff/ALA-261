//
//  Item.swift
//  USwap
//
//  Created by John M. Schaffer II on 3/29/17.
//  Copyright © 2017 USwap. All rights reserved.
//

import Foundation
import Firebase

class Item {
    
    var itemID: String = "" //firebase itemID
    var ownerUserUID: String = "" //firebase userID
    var ownerName: String = ""
    var name: String = ""
    var category: String = ""
    var style: String = ""
    var color: String = ""
    var size: String = ""
    var price: String = ""
    var photoURL: String = ""
    var condition: String = ""
    var description: String = ""
    var sell: Bool = false
    var rent: Bool = false
    var available: Bool = true
    var renterUID: String = ""
    var timestamp: String = ""
    
    init(){}
    
    init(itemDict: NSDictionary)
    {
        itemID = itemDict["itemID"] as! String
        ownerUserUID = itemDict["owner_userUID"] as! String
        ownerName = itemDict["owner_name"] as! String
        name = itemDict["name"] as! String
        category = itemDict["category"] as! String
        style = itemDict["style"] as! String
        color = itemDict["color"] as! String
        size = itemDict["size"] as! String
        price = itemDict["price"] as! String
        photoURL = itemDict["photoURL"] as! String
        condition = itemDict["condition"] as! String
        sell = itemDict["sell"] as! Bool
        rent = itemDict["rent"] as! Bool
        available = itemDict["available"] as! Bool
        renterUID = itemDict["renterUID"] as! String
        timestamp = itemDict["timestamp"] as! String
    }
    
    init(copyItem: Item)
    {
        itemID = copyItem.itemID
        ownerUserUID = copyItem.ownerUserUID
        ownerName = copyItem.ownerName
        name = copyItem.name
        category = copyItem.category
        style = copyItem.style
        color = copyItem.color
        size = copyItem.size
        price = copyItem.price
        photoURL = copyItem.photoURL
        condition = copyItem.condition
        sell = copyItem.sell
        rent = copyItem.rent
        available = copyItem.available
        renterUID = copyItem.renterUID
        timestamp = copyItem.timestamp
    }
    /*init(in_ownerUserUID: String, in_name: String, in_category: String, in_style: String, in_color: String, in_size: String, in_price: String, in_photo: String, in_description: String, in_sell: Bool, in_rent: Bool){
        
        itemID = ""
        ownerUserUID = in_ownerUserUID
        name = in_name
        category = in_category
        style = in_style
        color = in_color
        size = in_size
        price = in_price
        photo = in_photo
        description = in_description
        sell = in_sell
        rent = in_rent
        available = true;
        
    }*/
}

