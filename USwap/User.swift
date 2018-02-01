//
//  User.swift
//  USwap
//
//  Created by John M. Schaffer II on 3/29/17.
//  Copyright © 2017 USwap. All rights reserved.
//

import Foundation

class User {
    
    var first_name: String = ""
    var last_name: String = ""
    var email: String = ""
    var photo: String = ""
    var phone_number: String = ""
    var school: String = ""
    var userUID: String = ""
    var location: String = ""
    var payment: [String:String] = [
    "card_number": "",
    "security_code": "",
    "expiration": "",
    ]
    var billing: [String:String] = [
    "first_name": "",
    "last_name": "",
    "address": "",
    "city": "",
    "state": "",
    "country": "",
    "phone": ""
    ]
    var listings: NSArray = [""]
    var likes: NSArray = [""]
    var itemCart: NSArray = [""]

    init(){}
    
    init(in_first_name: String, in_last_name: String, in_email: String, in_photo: String, in_phone_number: String, in_school: String, in_userUID: String, in_location: String)
    {
        //initialize profile information
        first_name = in_first_name
        last_name = in_last_name
        email = in_email
        phone_number = in_phone_number
        school = in_school
        userUID = in_userUID
        location = in_location
        
        //initialize payment information
        payment["card_number"] = ""
        payment["security_code"] = ""
        payment["expiration"] = ""
        
        //initialize billing information
        billing["first_name"] = ""
        billing["last_name"] = ""
        billing["address"] = ""
        billing["citiy"] = ""
        billing["state"] = ""
        billing["country"] = ""
        billing["phone"] = ""
    }
}
