//
//  HomeViewController.swift
//  GrabAndDine
//
//  Created by Rachel Chen on 4/15/19.
//  Copyright © 2019 rachelchen0418. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var dietaryOptionLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var nameText: String = "Default"
    var matchID: String = "NONE"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let UserObject = UserDefaults.standard.object(forKey: "matchedUser") as! [String:Any];
        self.nameLabel.text = UserObject["username"] as? String
        if (UserObject["age"] as! Int) == 0{
            self.ageLabel.text = "Undefined Age"
        }else{
            self.ageLabel.text = String(UserObject["age"] as! Int)
        }
        
        self.bioLabel.text = UserObject["bios"] as? String
        self.dietaryOptionLabel.text = (UserObject["dietary_options"] as! NSArray)[0] as? String
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
