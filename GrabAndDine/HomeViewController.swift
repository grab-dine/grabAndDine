//
//  HomeViewController.swift
//  GrabAndDine
//
//  Created by Rachel Chen on 4/15/19.
//  Copyright © 2019 rachelchen0418. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    var nameText: String = "Default"
    var matchID: String = "NONE"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(matchID)
        self.nameLabel.text = nameText
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
