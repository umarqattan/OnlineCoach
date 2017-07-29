//
//  LoginViewController.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 7/24/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerHereButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loginButton.accessibilityIdentifier = "loginButton"
        registerHereButton.accessibilityIdentifier = "registerHereButton"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupUI() {
        
        
        loginButton.isEnabled = false
        usernameField.delegate = self
        passwordField.delegate = self
        usernameField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    
    
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
        HealthTrackerX().login(username: usernameField.text!, password: passwordField.text!)
        
        print("LOGGED IN!")
        
        print(usernameField.text!)
        print(passwordField.text!)
        
        let diaryTabBarController = storyboard?.instantiateViewController(withIdentifier: "DiaryTabBarController") as! DiaryTabBarController
        // TODO: SET THE USER HERE
        
        present(diaryTabBarController, animated: true, completion: nil)
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
