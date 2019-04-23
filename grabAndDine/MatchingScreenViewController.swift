//
//  MatchingScreenViewController.swift
//  grabAndDine
//
//  Created by Kevin Thaw on 4/23/19.
//  Copyright © 2019 Sheng Liu. All rights reserved.
//

import UIKit

class MatchingScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = URL(string: "http://localhost:5000/request/")!
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        request.httpMethod = "POST"

//        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let session = URLSession.shared
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let json = [
            "request_user" : "da425400-5d69-11e9-9387-9f42abd57978",
            "location" : "10007"
        ]
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        let task = session.uploadTask(with: request, from: jsonData) { data, response, error in
            if let data = data, let dataString = String(data: data, encoding: .utf8){
                print(dataString)
            }
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
            }
            
        }
        task.resume()
        
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
