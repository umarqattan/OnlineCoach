//
//  AuthenticationInformationViewController.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 7/27/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import UIKit

class AuthenticationInformationViewController: UIViewController, UITextFieldDelegate {

    var data:[String:Any]?
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var secondPasswordField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupAccessibility()
        setupUI()
        // Do any additional setup after loading the view.
        
        
    }

    // UI Helper functions
    
    func setupUI() {
        nextButton.isEnabled = false
        usernameField.delegate = self
        passwordField.delegate = self
        secondPasswordField.delegate = self
        usernameField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        secondPasswordField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    func setupAccessibility() {
        usernameField.accessibilityIdentifier = "usernameField"
        passwordField.accessibilityIdentifier = "passwordField"
        secondPasswordField.accessibilityIdentifier = "secondPasswordField"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Authentication"
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func next(_ sender: UIButton) {
         print("SUCCESSFULLY FILLED OUT AUTHENTICATION INFORMATION!")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RegisteredViewControllerSegue" {
            let vc = segue.destination as? RegisteredViewController
            
            data?["username"] = usernameField.text
            data?["password"] = passwordField.text
            
            vc?.data = data
        }
        
    }
    
    
    // MARK: UITextFieldDelegate helper protocol methods
    
    func textFieldDidChange(_ textField: UITextField) {
        
        if (usernameField.text?.characters.count)! > 0 && (passwordField.text?.characters.count)! > 0 && secondPasswordField.text == passwordField.text {
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
