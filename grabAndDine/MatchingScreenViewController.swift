//
//  MatchingScreenViewController.swift
//  grabAndDine
//
//  Created by Kevin Thaw on 4/23/19.
//  Copyright © 2019 Sheng Liu. All rights reserved.
//

import UIKit
import FLAnimatedImage

class MatchingScreenViewController: UIViewController {

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
                print(self.matchData)
                let status = self.matchData["status"] as! Int
                let labelText = self.matchData["message"] as! String
                self.requestID = self.matchData["request_id"] as! String
                
                if(status == 0 || status == 2){
                    print("Needs to check request table again")
                    DispatchQueue.main.async {
                        self.matchStatusLabel.text = labelText
                    }
                    
                }else{
                    DispatchQueue.main.async {
                        self.profileButton.isHidden = false;
                        self.matchStatusLabel.text = labelText
                    }
                }
            }
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
            }
            
        }
        task.resume()
        
    
    }
    
//    @IBAction func goToProfile(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let view = storyboard.instantiateViewController(withIdentifier: "BestMatch")
//        self.present(view, animated: true, completion: nil)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//            let vc = segue.destination as! HomeViewController
//            vc.nameLabel.text = "Hermoine"
            print("Prepare !!!!!")
        
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


}
