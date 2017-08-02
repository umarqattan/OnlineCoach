//
//  LoginViewController.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 7/24/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import UIKit
import CoreData
import Foundation
//import PlaygroundSupport
//PlaygroundPage.current.needsIndefiniteExecution = true



class LoginViewController: UIViewController, UITextFieldDelegate {

    
    
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerHereButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    var accessToken:String!
    var tokenType:String!
    var clientUserId:String!
    
    let Token:String = "Token"
    let API:String = "api"
    let POST:String = "POST"
    let GET:String = "Get"
    let baseURL:String = "https://healthtrackerx.azurewebsites.net/"
    let Client:String = "Client"
    let Diary:String = "Diary"
    let query:String = "?uid="
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.accessibilityIdentifier = "loginButton"
        registerHereButton.accessibilityIdentifier = "registerHereButton"
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        NotificationCenter.default.post(name: .AccessTokenReceivedNotification, object: nil)
        
    }
    
    func setupUI() {
        
        loginButton.isEnabled = false
        usernameField.delegate = self
        passwordField.delegate = self
        usernameField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // Step 3
    func userDiariesReceivedNotification(_ notification: NSNotification) {
        let userInfo = notification.userInfo as! [String:Any]
        
        let clients = userInfo["clients"] as! [CoachClient]
        let firstClient = clients.first!
        
        let foodDiaryEntries = firstClient.diary.foods
        let exerciseDiaryEntries = firstClient.diary.exercises
        DispatchQueue.main.async {
            
            
            var textViewString = ""
            
            for food in foodDiaryEntries {
                textViewString += ("\n" + food.description())
            }
            
            for exercise in exerciseDiaryEntries {
                textViewString += ("\n" + exercise.description())
            }
            
            self.activityIndicator.stopAnimating()
            print(textViewString)
            self.loginButton.backgroundColor = UIColor(red: 0/255.0, green: 128.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            self.loginButton.titleLabel?.text = "   ☑️"
            self.loginButton.isEnabled = false
        }
    }
    
    
    // Step 2
    func userIdReceivedNotification(_ notification: NSNotification) {
        let userInfo = notification.userInfo as! [String : String]
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.userDiariesReceivedNotification(_:)), name: .UserDiariesReceivedNotification, object: nil)
        DispatchQueue.main.async {
            
            self.getClientDiary(from: userInfo["clientUserId"]!, accessToken: self.accessToken, tokenType: self.tokenType)
            
        }
    }
    
    // Step 1
    func accessTokenReceivedNotification(_ notification: NSNotification) {
        
        
        let userInfo = notification.userInfo as! [String: String]
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.userIdReceivedNotification(_ :)), name: .UserIdReceivedNotification, object: nil)
        
        
        
        DispatchQueue.main.async {
            
            self.accessToken = userInfo["access_token"]
            self.tokenType = userInfo["token_type"]
            
            
            
            self.getClient(from: self.accessToken, tokenType: self.tokenType)
            
            
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: .AccessTokenReceivedNotification, object: nil)
    }
    
    
    @IBAction func getToken(_ sender: UIButton) {
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.accessTokenReceivedNotification(_ :)), name: .AccessTokenReceivedNotification, object: nil)
        
        getToken(username: "jj@gmail.com", password: "aa")
        
        //activityIndicator.startAnimating()
    }

    @IBAction func getUserId(_ sender: UIButton) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.userIdReceivedNotification(_ :)), name: .UserIdReceivedNotification, object: nil)
        
        getClient(from: self.accessToken, tokenType: self.tokenType)
        
        //activityIndicator.startAnimating()
    }
    
    @IBAction func getUserDiaries(_ sender: UIButton) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.userDiariesReceivedNotification(_:)), name: .UserDiariesReceivedNotification, object: nil)
        
        getClientDiary(from: self.clientUserId, accessToken: self.accessToken, tokenType: self.tokenType)
        
        //activityIndicator.startAnimating()
        
        
    }
    
    
    func login(username: String, password:String) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.accessTokenReceivedNotification(_ :)), name: .AccessTokenReceivedNotification, object: nil)
        
        activityIndicator.startAnimating()
        getToken(username: username, password: password)
        loginButton.titleLabel?.text = "           "
    }
    
    
    
    
    func getToken(username: String, password:String) {
        
        let tokenHeaders = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache"
        ]
        
        
        
        
        let tokenPostData = NSMutableData(data: "grant_type=password".data(using: .utf8)!)
        tokenPostData.append("&username=\(username)".data(using: .utf8)!)
        tokenPostData.append("&password=\(password)".data(using: .utf8)!)
        
        let tokenURL = NSURL(string: baseURL+Token)! as URL
        var request = NSMutableURLRequest(url: tokenURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0) as URLRequest
        
        request.httpMethod = POST
        request.allHTTPHeaderFields = tokenHeaders
        request.httpBody = tokenPostData as Data
        
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                DispatchQueue.main.async {
                    print(error!)
                }
                
            } else {
                
                let jsonObject = try? JSONSerialization.jsonObject(with: data!, options: .mutableLeaves)
                
                let accessToken = (jsonObject as! [String:Any])["access_token"] as! String
                let tokenType = (jsonObject as! [String:Any])["token_type"] as! String
                DispatchQueue.main.async {
                    
                    
                    let userInfo:[String:String] = ["access_token" : accessToken, "token_type": tokenType]
                    NotificationCenter.default.post(name: .AccessTokenReceivedNotification, object: nil, userInfo: userInfo)
                }
            }
        })
        dataTask.resume()
    }
    

    func getClient(from accessToken:String, tokenType:String) {
        
        
        
        let clientHeaders = [
            "authorization" : "\(tokenType.capitalized) \(accessToken)",
            "cache-control" : "no-cache"
        ]
        
        let clientURL = NSURL(string: baseURL+API+"/"+Client+"/"+GET)! as URL
        
        let request = NSMutableURLRequest(url: clientURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = GET.uppercased()
        request.allHTTPHeaderFields = clientHeaders
        
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                
                let jsonObject = try? JSONSerialization.jsonObject(with: data!, options: .mutableLeaves)
                
                
                DispatchQueue.main.async {
                    let clientUserId = ((jsonObject! as! [Any])[0] as! [String:Any])["clientUserId"] as! String
                    
                    let userInfo = ["clientUserId" : clientUserId]
                    NotificationCenter.default.post(name: .UserIdReceivedNotification, object: nil, userInfo: userInfo)
                    self.clientUserId = clientUserId
                }
            }
        })
        dataTask.resume()
    }
    
    
    func getClientDiary(from clientUserId:String, accessToken:String, tokenType:String) -> Void {
        
        
        let clientDiaryHeaders = [
            
            "authorization" : "\(tokenType.capitalized) \(accessToken)",
            "cache-control" : "no-cache"
        ]
        
        let clientURL = NSURL(string: baseURL+API+"/"+Diary+"/"+GET+"/"+query+clientUserId)! as URL
        
        let request = NSMutableURLRequest(url: clientURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = GET.uppercased()
        request.allHTTPHeaderFields = clientDiaryHeaders
        
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                
                
                let jsonObject = try? JSONSerialization.jsonObject(with: data!, options: .mutableLeaves)
                
                DispatchQueue.main.async {
                    print(jsonObject!)
                    
                    
                    var clients:[CoachClient] = []
                    
                    let clientsDiaries = (jsonObject as! [Any]) as! [[String:Any]]
                    
                    
                    for clientDiary in clientsDiaries {
                        
                        let foods = clientDiary["joinedFoodEntry"] as! [[String:Any]]
                        let exercises = clientDiary["joinedExerciseEntry"] as! [[String:Any]]
                        
                        var foodDiaryEntries:[FoodDiaryEntry] = []
                        var exerciseDiaryEntries:[ExerciseDiaryEntry] = []
                        
                        for food in foods {
                            foodDiaryEntries.append(FoodDiaryEntry(data: food))
                        }
                        for exercise in exercises {
                            exerciseDiaryEntries.append(ExerciseDiaryEntry(data: exercise))
                        }
                        
                        let client:CoachClient = CoachClient(foods: foodDiaryEntries, exercises: exerciseDiaryEntries)
                        
                        clients.append(client)
                        
                    }
                    let userInfo = ["clients": clients]
                    
                    NotificationCenter.default.post(name: .UserDiariesReceivedNotification, object: nil, userInfo: userInfo)
                    print("LOGGED IN!")
                }
                
            }
        })
        
        dataTask.resume()
    }


        // Do any additional setup after loading the view.

   

    
    
    // MARK: UITextFieldDelegate protocol methods
    
    func textFieldDidChange(_ textField: UITextField) {
        
        if (usernameField.text?.characters.count)! > 0 && (passwordField.text?.characters.count)! > 0  {
            loginButton.isEnabled = true
            print("Text changed")
        } else {
            loginButton.isEnabled = false
        }
        
        
    }
    
    // MARK: UITextFieldDelegate protocol methods
    
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        
        
        
    }
    
    @IBAction func login(_ sender: UIButton) {
        self.login(username: usernameField.text!, password: passwordField.text!)
        
        
        
        
        
        //HealthTrackerX().login(username: usernameField.text!, password: passwordField.text!)
        
        //let diaryTabBarController = storyboard?.instantiateViewController(withIdentifier: "DiaryTabBarController") as! DiaryTabBarController
        // TODO: SET THE USER HERE
        
        //present(diaryTabBarController, animated: true, completion: nil)
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


extension Notification.Name {
    static let AccessTokenReceivedNotification = Notification.Name("AccessTokenReceived")
    static let UserIdReceivedNotification = Notification.Name("UserIdReceived")
    static let UserDiariesReceivedNotification = Notification.Name("UserDiariesReceived")
    
    
}
