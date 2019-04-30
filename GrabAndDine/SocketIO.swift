//// 
////  SocketIO.swift
////  GrabAndDine
////
////  Created by Sheng Liu on 4/29/19.
////  Copyright © 2019 rachelchen0418. All rights reserved.
////
//
//import UIKit
//import SocketIO
//
//class SocketIO: NSObject {
//    static let sharedInstance = SocketIO()
//    // https://grabanddine.herokuapp.com/channel
//    
//    let manager = SocketManager(socketURL: URL(string: "http://localhost:5000/channel")!, config: [.log(true), .compress])
//    var socket:SocketIOClient!
//    
//    override init() {
//        super.init()
//
//
//        self.socket = manager.defaultSocket
//    }
//    
//
//    func establishConnection() {
//        socket.connect()
//        
//    }
//    
//    func closeConnection() {
//        socket.disconnect()
//    }
//    
//    
//    func connectToServerWithNickname(nickname: String) {
//        //socket.emit('new user',from);
//        //socket.emit('chat message',from,to,msg);
//        socket.emit("new user", nickname) // register current user to the database.
//    }
//    
//    func sendMessageTo(destinationId: String, sourceId: String, messageContent: String){
//        
//        socket.emit("chat message", sourceId, destinationId, messageContent)
//    }
//    
//    func listenToPrivateChannel(currentUserID: String , success: @escaping ([String: Any]) -> (), failure: @escaping (Error) -> ()){
//        
//        //, success: @escaping ([String: Any]) -> (), failure: @escaping (Error) -> ()
//        socket.on("privateMsgTo\(currentUserID)") { data, ack in
//            let receivedData = data[0] as! [String: Any]
//            let from = receivedData["from"]
//            let message = receivedData["msg"]
//            print("\(from) SAID - \(message)  ")
//            success(receivedData)
//        
//        }
//        
//    }
//    
//    
//    
//    func getDictionariesRequest(currentUserID: String, success: @escaping ([String: Any]) -> (), failure: @escaping (Error) -> ()){
//        
//        socket.on("privateMsgTo\(currentUserID)") { data, ack in
//            
//            let receivedData = data[0] as! [String: Any]
////            let from = receivedData["from"]
////            let message = receivedData["msg"]
//            success(receivedData)
//        }
//        
//
//    }
//    
//    
//    
//}
