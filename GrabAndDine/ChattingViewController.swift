//
//  ChattingViewController.swift
//  GrabAndDine
//
//  Created by Sheng Liu on 4/29/19.
//  Copyright © 2019 rachelchen0418. All rights reserved.
//

import UIKit
import SocketIO

class ChattingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var userTextField: UITextField!
    var messageArray = [NSDictionary]()
    var userID : String!
    
    @IBOutlet weak var navigatorItem: UINavigationItem!
    @IBOutlet weak var chatStatus: UILabel!
    @IBOutlet weak var chatTable: UITableView!
    let manager = SocketManager(socketURL: URL(string: "http://localhost:5000/channel")!, config: [.log(true), .compress])
    var socket:SocketIOClient!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatTable.dataSource = self
        chatTable.delegate = self
        
        self.socket = manager.defaultSocket
        
        let userObject = UserDefaults.standard.object(forKey: "userObject") as! [String: Any]
        let userID = (userObject["user_id"] as! String)
        self.userID = userID

        setSocketEvents()
        
        establishConnection()

    }
    
    
    @IBAction func onTap(_ sender: Any) {
        
        if  UserDefaults.standard.bool(forKey: "userLoggedIn") == true {
            let userMessage = userTextField.text!            
        
            self.sendMessageTo(destinationId: "sheng", sourceId: self.userID, messageContent: userMessage)
            
        }
    }
    @IBAction func messageFieldChanged(_ sender: UITextField) {
        
        self.updateStatus()
    }
    
    
    private func setSocketEvents()
    {
        self.socket.on(clientEvent: .connect) {data, ack in
            print("socket connected");
            self.socket.emit("new user", self.userID)
        }
        

        self.socket.on("privateMsgTo\(self.userID!)") { data, ack in
            let receivedData = data[0] as! [String: Any]
            let from = receivedData["from"]
            let msg = receivedData["msg"]
            let data = ["from" : from, "msg" : msg]
            self.messageArray.append(data as! NSDictionary)
            self.chatTable.reloadData()
            
            
        }
        
        self.socket.on("typingUpdateTo\(self.userID!)") {
            data, ack in
            print(data)
            let receivedData = data[0] as! [String: Any]
            self.navigatorItem.title = "\(receivedData["from"]!) \(receivedData["status"]!)"
        }
    }
    
    func updateStatus(){
        let sourceId = self.userID!
        let destinationId = "sheng"
        
        if userTextField.text! == "" {
            self.socket.emit("updateTypingStatus", sourceId, destinationId, "")
        } else {
            self.socket.emit("updateTypingStatus", sourceId, destinationId, " is typing")
        }
    }
    
    func establishConnection() {
        self.socket.connect()
        
    }
    
    func closeConnection() {
        self.socket.disconnect()
    }
    

    
    func sendMessageTo(destinationId: String, sourceId: String, messageContent: String){
        
        self.socket.emit("chat message", sourceId, destinationId, messageContent)
        
        let from = sourceId
        let msg = messageContent
        let data = ["from" : from, "msg" : msg]
        self.messageArray.append(data as! NSDictionary)
        self.updateStatus()
        self.userTextField.text = ""
        self.chatTable.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        let user = messageArray[indexPath.row] as! NSDictionary
        let currentUserId = user["from"] as? String

        
        if (currentUserId! == self.userID!){
            cell.selfMessageLabel.text = user["msg"] as? String
            cell.selfMessageLabel.isHidden = false;
            cell.selfMessageImage.isHidden = false;
            cell.userMessageLabel.isHidden = true;
            cell.userMessageImage.isHidden = true;
            
        } else {
            cell.userMessageLabel.text = user["msg"] as? String
            cell.selfMessageLabel.isHidden = true;
            cell.selfMessageImage.isHidden = true;
            cell.userMessageLabel.isHidden = false;
            cell.userMessageImage.isHidden = false;
        }
        
        

        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messageArray.count
    }

}
