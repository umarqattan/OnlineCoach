//
//  UserInformationViewController.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 7/18/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import UIKit

class UserInformationViewController: UIViewController, UITextFieldDelegate {

    
    let index = 0
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var roleSwitch: UISwitch!
    @IBOutlet weak var nextButton: UIButton!
    
    var data:[String:Any]?
    
    
    
    
    
    
    var roleSwitchHasChanged:Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupUI()
        //parent?.navigationItem.title = "User Information"
        //navigationItem.title = "User Information"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        parent?.navigationItem.title = "User Information"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // UI Helper Functions
    func setupUI() {
        firstNameField.delegate = self
        lastNameField.delegate = self
        emailAddressField.delegate = self
        phoneNumberField.delegate = self
        nextButton.isEnabled = false
        
        
        
        
        
    }
    
    func enableNextButton() {
        if firstNameField.text != nil && lastNameField != nil && emailAddressField.text != nil && phoneNumberField.text != nil && roleSwitchHasChanged {
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
        
        let parentVC = parent as! CreateUserPageViewController
        
        data = [
        "firstName" : firstNameField.text ?? "",
        "lastName" : lastNameField.text ?? "",
        "age" : 0,
        "emailAddress" : emailAddressField.text ?? "" ,
        "phoneNumber" : phoneNumberField.text ?? "",
        "isCoach" : roleSwitch.isOn ? true : false,
        "isClient" : roleSwitch.isOn ? false : true,
        "weight" : 0.00,
        "height" : "",
        "unit" : "Metric",
        "goal" : "Shred"
        ]

        
        
        
       // parentVC.setViewControllers([parentVC.viewControllerAtIndex(index: 1)!], direction: .forward, animated: true,
             //completion: nil)
        
        
    }
    
    @IBAction func roleSwitchChange(_ sender: UISwitch) {
        if roleSwitchHasChanged == false {
            roleSwitchHasChanged = true
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? BodyInformationViewController {
            
            data = [
                "firstName" : firstNameField.text ?? "",
                "lastName" : lastNameField.text ?? "",
                "age" : 0,
                "emailAddress" : emailAddressField.text ?? "" ,
                "phoneNumber" : phoneNumberField.text ?? "",
                "isCoach" : roleSwitch.isOn ? true : false,
                "isClient" : roleSwitch.isOn ? false : true,
                "weight" : 0.00,
                "height" : "",
                "unit" : "",
                "goal" : ""
            ]
            
            vc.data = data
        }
    }
    
    
}

