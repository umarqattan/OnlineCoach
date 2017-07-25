//
//  UserInformationViewController.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 7/18/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import UIKit

class UserInformationViewController: UIViewController, UITextFieldDelegate {

    
    
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var roleSwitch: UISwitch!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var cancel: UIBarButtonItem!
    
    var data:[String:Any]?
    
    
    
    
    
    
    var roleSwitchHasChanged:Bool = false

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAccessibility()
        
        
        setupUI()
        
        
        
        //makeHTTPCall()
        
        
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

    
    // TODO: Fix GET method
//    func makeHTTPCall() {
//        
//        
//        let headers = [
//            "content-type": "application/json",
//            "cache-control": "no-cache",
//            "postman-token": "91003c5e-b2f4-ad33-e060-fbcda80f9070"
//        ]
//        
//        
//        do {
//            
//            
//            let request = NSMutableURLRequest(url: NSURL(string: "https://healthtrackerx.azurewebsites.net/api/Foods")! as URL,
//                                              cachePolicy: .useProtocolCachePolicy,
//                                              timeoutInterval: 10.0)
//            request.httpMethod = "GET"
//            request.allHTTPHeaderFields = headers
//            request.httpBody = nil
//            request.addValue("0", forHTTPHeaderField: "Content-Length")
//            
//            let session = URLSession.shared
//            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//                if (error != nil) {
//                    print(error)
//                } else {
//                    let httpResponse = response as? HTTPURLResponse
//                    print(httpResponse)
//                    
//                    let string1 = String(data: data!, encoding: String.Encoding.utf8) ?? "Data could not be printed"
//                    print(string1)
//                    
//                }
//            })
//            
//            dataTask.resume()
//
//        }
//        
//    }
    
    
    // UI Helper Functions
    func setupUI() {
        firstNameField.delegate = self
        lastNameField.delegate = self
        emailAddressField.delegate = self
        phoneNumberField.delegate = self
        nextButton.isEnabled = false
    
    }
    
    func setupAccessibility() {
        firstNameField.accessibilityIdentifier = "firstNameField"
        lastNameField.accessibilityIdentifier = "lastNameField"
        emailAddressField.accessibilityIdentifier = "emailAddressField"
        phoneNumberField.accessibilityIdentifier = "phoneNumberField"
        roleSwitch.accessibilityIdentifier = "roleSwitch"
        nextButton.accessibilityIdentifier = "nextButton"
        
    }
    
    func enableNextButton() {
        if firstNameField.text != nil && lastNameField != nil && emailAddressField.text != nil && phoneNumberField.text != nil {
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
                "age" : Int16(0),
                "birthDate" : "",
                "emailAddress" : emailAddressField.text ?? "",
                "phoneNumber" : phoneNumberField.text ?? "",
                "isCoach" : roleSwitch.isOn ? true : false,
                "isClient" : roleSwitch.isOn ? false : true,
                "weight" : Float(0),
                "height" : "",
                "unit" : "Metric",
                "goal" : "Shred"
            ]
            
            vc?.data = data
            
        }
    }
    
    
}





