//
//  UserInformationViewController.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 7/18/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import UIKit
import CoreData

class UserInformationViewController: UIViewController, UITextFieldDelegate {

    
    
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    
    
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var roleSwitch: UISwitch!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var cancel: UIBarButtonItem!
    
    var data:[String:Any]?
    var foods:[[String:Any]]?
    var theFoods:[Food] = []
    var roleSwitchHasChanged:Bool = false

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAccessibility()
        
        
        setupUI()
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "User"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    
    // UI Helper Functions
    func setupUI() {
        firstNameField.delegate = self
        lastNameField.delegate = self
        
        phoneNumberField.delegate = self
        nextButton.isEnabled = false
    
    }
    
    func setupAccessibility() {
        firstNameField.accessibilityIdentifier = "firstNameField"
        lastNameField.accessibilityIdentifier = "lastNameField"
        
        phoneNumberField.accessibilityIdentifier = "phoneNumberField"
        roleSwitch.accessibilityIdentifier = "roleSwitch"
        nextButton.accessibilityIdentifier = "nextButton"
        
    }
    
    func enableNextButton() {
        if firstNameField.text != nil && lastNameField != nil && phoneNumberField.text != nil {
            nextButton.isEnabled = true
        }
    }
    
    // UITextFieldDelegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        enableNextButton()
        return true
        
    }
    
   
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        textField.resignFirstResponder()
        
        enableNextButton()
        
        return
    }
    
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        enableNextButton()
        
        return true
    }

    
    
    // Pragma: IBActions
    @IBAction func next(_ sender: UIButton) {
        print("SUCCESSFULLY FILLED OUT USER INFORMATION!")
        
    }
    
    @IBAction func roleSwitchChange(_ sender: UISwitch) {
        if roleSwitchHasChanged == false {
            roleSwitchHasChanged = true
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "BodyInformationViewControllerSegue" {
            let vc = segue.destination as? BodyInformationViewController
            data = [
                "firstName" : firstNameField.text ?? "",
                "lastName" : lastNameField.text ?? "",
                "birthdate" : "",
                "emailAddress" : "",
                "phoneNumber" : phoneNumberField.text ?? "",
                "isCoach" : roleSwitch.isOn ? true : false,
                "height" : 0,
                "isMetric" : false,
                "intensity" : 0,
                "myUserId" : ""
            ]
            
            vc?.data = data
            
        }
    }
    
    
}





