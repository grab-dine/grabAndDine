//
//  ChattingViewController.swift
//  GrabAndDine
//
//  Created by Sheng Liu on 4/29/19.
//  Copyright © 2019 rachelchen0418. All rights reserved.
//

import UIKit
import SocketIO

class ChattingViewController: UIViewController {

    let socketIO = SocketIO.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        socketIO.listenToPrivateChannel(currentUserID: "T#")
    }
    @IBAction func onTap(_ sender: Any) {
        
        if  UserDefaults.standard.bool(forKey: "userLoggedIn") == true{
            socketIO.connectToServerWithNickname(nickname: "T#")
            
            socketIO.sendMessageTo(destinationId: "sheng", sourceId: "T#", messageContent: "Testing!!!!!")
        }
    }
    
    
    

}
