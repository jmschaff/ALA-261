//
//  SettingsViewController.swift
//  USwap
//
//  Created by John M. Schaffer II on 4/16/17.
//  Copyright © 2017 USwap. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        try! FIRAuth.auth()!.signOut()
        performSegue(withIdentifier: "logoutSettings", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "settingsToProfile"){
            if let tabVC = segue.destination as? UITabBarController{
                tabVC.selectedIndex = 4
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "settingsToProfile", sender: nil)
    }
}
