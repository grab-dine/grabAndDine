//
//  LoginViewController.swift
//  GrabAndDine
//
//  Created by Rachel Chen on 4/12/19.
//  Copyright © 2019 rachelchen0418. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //If allow consistance login, then uncomment the following code
    override func viewDidAppear(_ animated: Bool) {

        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true{
            self.performSegue(withIdentifier: "loginToMatching", sender: self)
        }
    }

    @IBAction func onTapLogin(_ sender: Any) {
        //let authUrl = "https://grabanddine.herokuapp.com/auth/login"
        let authUrl = "http://localhost:5000/auth/login"
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]

        let postData = NSMutableData(data: "email=\(emailField.text ?? "")".data(using: String.Encoding.utf8)!)
        postData.append("&password=\(passwordField.text ?? "")".data(using: String.Encoding.utf8)!)
        
        let request = NSMutableURLRequest(url: NSURL(string: authUrl)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                let httpResponse = response as? HTTPURLResponse
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any]
                    // ------>
                    let statusCode = httpResponse?.statusCode;
                    
                    if(statusCode == 200){
                        // if login successfully, then save user information as an object.
                        let response = json["response"] as! [String: Any]
                        
                        //user object stored as global variable
                     
                        UserDefaults.standard.set(response, forKey: "userObject")
                        UserDefaults.standard.set(true, forKey: "userLoggedIn")
                        
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "loginToMatching", sender: self)
                        }
                    } else {
                        // if login is not success, then save the error message array in 'message'
                        let message = json["message"] as! NSArray
                        let title = "Error"
                        // message[0] shows the message
                        
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: title, message: (message[0] as! String), preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }

                } catch {
                    print(error)
                }
                
            }
        })
        
        dataTask.resume()
    }
    

}
