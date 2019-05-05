//
//  MatchingScreenViewController.swift
//  grabAndDine
//
//  Created by Kevin Thaw on 4/23/19.
//  Copyright © 2019 Sheng Liu. All rights reserved.
//

import UIKit
import Alamofire
import FLAnimatedImage

class MatchingScreenViewController: UIViewController {
    
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var matchStatusLabel: UILabel!
    @IBOutlet weak var gif: FLAnimatedImageView!
    @IBOutlet weak var profileButton: UIButton!
    var success = false
    var requestID: String? = nil
    var matchData = [String: Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path1 : String = Bundle.main.path(forResource: "load", ofType: "gif")!
        let imageData1 = try? FLAnimatedImage(animatedGIFData: Data(contentsOf: URL(fileURLWithPath: path1)))
        gif.animatedImage = imageData1 as! FLAnimatedImage      // Do any additional setup after loading the view.
        
        // Do any additional setup after loading the view.
        let url = URL(string: "http://localhost:5000/request/")!
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        request.httpMethod = "POST"
        
        //        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let session = URLSession.shared
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let json = [
            "request_user_id" :(UserDefaults.standard.object(forKey: "userObject")as! [String: Any])["user_id"] as! String,
            "location" : "10007"
        ]
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        let task = session.uploadTask(with: request, from: jsonData) { data, response, error in
            if let data = data, let dataString = String(data: data, encoding: .utf8){
                self.success = true;
                self.matchData = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//                print(self.matchData)
                let status = self.matchData["status"] as! Int
                let labelText = self.matchData["message"] as! String
                self.requestID = self.matchData["request_id"] as! String
                
                if(status == 0 || status == 2){
                    DispatchQueue.main.async {
                        self.matchStatusLabel.text = labelText
                        self.retryButton.isHidden = false;
                    }
                    
                }else{
                    DispatchQueue.main.async {
                        self.retryButton.isHidden = true;
                        self.profileButton.isHidden = false;
                        self.matchStatusLabel.text = labelText
                    }
                    let matchedUserObj = self.matchData["userMatched"] as! [String:Any]
                    UserDefaults.standard.set( matchedUserObj,forKey: "matchedUser");
                }
            }

            
        }
        task.resume()
        
        
    }
    
    @IBAction func onTapRetry(_ sender: Any) {
        let url = URL(string: "http://localhost:5000/request/check/" + self.requestID!)!
        
        
        //        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let session = URLSession.shared
        
        var queryItems = [URLQueryItem]()
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = queryItems
        var request = URLRequest(url: (urlComponents?.url)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            if let data = data, let dataString = String(data: data, encoding: .utf8){
                self.success = true;
                self.matchData = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                //print(self.matchData)
                let status = self.matchData["status"] as! Int
                let labelText = self.matchData["message"] as! String
                self.requestID = self.matchData["request_id"] as! String
                
                if(status == 0 || status == 2){
//                    print("Needs to check request table again")
                    DispatchQueue.main.async {
                        self.matchStatusLabel.text = labelText
                        self.retryButton.isHidden = false;
                    }
                    
                    
                }else{
                    DispatchQueue.main.async {
                        self.retryButton.isHidden = true;
                        self.profileButton.isHidden = false;
                        self.matchStatusLabel.text = labelText
                    }
                    let matchedUserObj = self.matchData["userMatched"] as! [String:Any]
                    UserDefaults.standard.set( matchedUserObj,forKey: "matchedUser");
//                    print(UserDefaults.standard.object(forKey: "matchedUser"))
                }
            }
//            if let httpResponse = response as? HTTPURLResponse {
//                print(httpResponse.statusCode)
//            }
            
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //            let vc = segue.destination as! HomeViewController
        //            vc.nameLabel.text = "Hermoine"
        
        if segue.destination is HomeViewController
        {
            let vc = segue.destination as? HomeViewController
            if vc != nil{
                vc!.nameText = "Hermoine"
                vc!.matchID = matchData["match_id"] as! String
            }
            // UserDefaults.standard.set(json, forKey: "userObject") <- for kev where json is the matchedUserObject return from server.
        }
        
        
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
