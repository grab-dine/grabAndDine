//
//  SignUpViewController.swift
//  GrabAndDine
//
//  Created by Sheng Liu on 5/4/19.
//  Copyright © 2019 rachelchen0418. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signUpOnTap(_ sender: Any) {
        let username = self.userNameField.text
        let password = self.passwordField.text
        let email = self.emailField.text
        let gender = self.genderField.text
        let age = self.ageField.text
        
        if(username == "" || password == "" || email == ""){
            let alertController = UIAlertController(title: "Error", message:
                "Please fill out * highlighted requirements before moving on!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
        } else{
            
            let headers = [
                "Content-Type": "application/x-www-form-urlencoded",
                "cache-control": "no-cache",
            ]
            
            
            let postData = NSMutableData(data: "email=\(email as! String)".data(using: String.Encoding.utf8)!)
            postData.append("&username=\(username as! String)".data(using: String.Encoding.utf8)!)
            postData.append("&password=\(password as! String)".data(using: String.Encoding.utf8)!)
            postData.append("&dietary_options[0]=restaurants".data(using: String.Encoding.utf8)!)
            postData.append("&authKey=2a10dz1gX7p5YH7fBvyhl1JCqYeNZrMEKMEwPHJZZX2au94F".data(using: String.Encoding.utf8)!)
            if(gender != ""){
                postData.append("&gender=\(gender as! String)".data(using: String.Encoding.utf8)!)
                print("in")
            }
            if(age != ""){
                postData.append("&age=\(age as! String)".data(using: String.Encoding.utf8)!)
                 print("in 2")
            }

            //"https://grabanddine.herokuapp.com/auth/login"
            //"http://localhost:5000/auth/signup"
            let request = NSMutableURLRequest(url: NSURL(string: "http://localhost:5000/auth/signup")! as URL,
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
                    
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any]
                        let statusCode = httpResponse?.statusCode;
                        if statusCode == 200{
                            DispatchQueue.main.async {
                                let alertController = UIAlertController(title: "Success", message:
                                    "\(username as! String) has been created.", preferredStyle: .alert)
                                alertController.addAction(UIAlertAction(title: "Ok", style: .default))
                                self.present(alertController, animated: true, completion: nil)
                            }
                        } else{
                            let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any]

                            //let message = httpResponse["message"] as! NSArray
                            DispatchQueue.main.async {
                                let alertController = UIAlertController(title: "Error", message:
                                    json["message"] as! String, preferredStyle: .alert)
                                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                                self.present(alertController, animated: true, completion: nil)
                            }
                        }
                    } catch{
                        print(error)
                    }
                    
                }
            })
            
            dataTask.resume()
        }

    }
    


}
