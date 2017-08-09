//
//  AuthenticationInformationViewController.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 7/27/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import UIKit

class AuthenticationInformationViewController: UIViewController, UITextFieldDelegate {

    var data:[String:Any]!
    
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var secondPasswordField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAccessibility()
        setupUI()
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: .UserAlreadyExistsReceivedNotification, object: nil)
    }

    // UI Helper functions
    
    func setupUI() {
        nextButton.isEnabled = false
        emailAddressField.delegate = self
        passwordField.delegate = self
        secondPasswordField.delegate = self
        emailAddressField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        secondPasswordField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        nextButton.isEnabled = false
        
    }
    
    func setupAccessibility() {
        emailAddressField.accessibilityIdentifier = "emailAddressField"
        passwordField.accessibilityIdentifier = "passwordField"
        secondPasswordField.accessibilityIdentifier = "secondPasswordField"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Authentication"
        
        NotificationCenter.default.addObserver(self, selector: #selector(AuthenticationInformationViewController.userAlreadyExistsNotification(_:)), name: .UserAlreadyExistsReceivedNotification, object: nil)
        
        
    }

    @IBAction func Check(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.checkButton.isHidden = true
            self.checkIfUserExists()
        }
        
    }
    

    @IBAction func next(_ sender: UIButton) {
        
        registerUser()
        
    }
    
    
    @objc func userAlreadyExistsNotification(_ notification:NSNotification) {
        let userInfo = notification.userInfo as! [String:Bool]
        
        
        
        if !userInfo["available"]! {
            DispatchQueue.main.async {
                
                // TODO: Add Alert View when user already exists
                self.checkButton.backgroundColor = UIColor.red
            }
        } else {
            DispatchQueue.main.async {
                self.checkButton.isHidden = true
                self.nextButton.isEnabled = true
                self.checkImageView.image = UIImage(named: "icons8-Ok-32")
            }
        }
    }
    
    func checkIfUserExists() {
    
        let headers = [
            "cache-control": "no-cache",
            "postman-token": "aecff94d-798d-78e2-79f9-209dfe5f7c31"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://healthtrackerx.azurewebsites.net/api/Account/UserNameAvailable?un=\(self.data["firstName"]!)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                
            } else {
                let jsonObject = try? JSONSerialization.jsonObject(with: data!, options: .mutableLeaves)
                
                DispatchQueue.main.async {
                    let available = (jsonObject! as! [String:Any])["available"] as! Bool
                    let userInfo:[String:Bool] = ["available": available]
                    
                    self.activityIndicator.stopAnimating()
                    
                    NotificationCenter.default.post(name: .UserAlreadyExistsReceivedNotification, object: nil, userInfo: userInfo)
                }
            }
        })
        
        dataTask.resume()
    }
    
        
        
        
        
        
        
    
    
    func registerUser() {
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache",

            ]



        let postData = try! JSONSerialization.data(withJSONObject: data, options: [])

        let request = NSMutableURLRequest(url: NSURL(string: "https://healthtrackerx.azurewebsites.net/api/Account/CreateUser")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                //print(error)
            } else {
                //let httpResponse = response as? HTTPURLResponse
                //let jsonObject = try? JSONSerialization.jsonObject(with: data!, options: .mutableLeaves)

                DispatchQueue.main.async {
                    
                    
                    
                    
                }
            }
        })

        dataTask.resume()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RegisteredViewControllerSegue" {
            let vc = segue.destination as? RegisteredViewController
            
            data["emailAddress"] = emailAddressField.text!
            data["password"] = passwordField.text!
            
            vc?.data = data
        }
        
    }
    
    
    // MARK: UITextFieldDelegate helper protocol methods
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if (emailAddressField.text?.characters.count)! > 0 && (passwordField.text?.characters.count)! > 0 && secondPasswordField.text == passwordField.text {
            nextButton.isEnabled = true
            print("Text changed")
        } else {
            nextButton.isEnabled = false
        }
    }
    
    // MARK: UITextFieldDelegate Protocol methods
    
    func textFieldDidEndEditing(_ textField: UITextField) {

        textField.resignFirstResponder()

    }
    
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
    
        textField.resignFirstResponder()
        
        return true
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
