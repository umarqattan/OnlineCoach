//
//  CreateUserViewController.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 7/18/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import UIKit

class CreateUserViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var roleSwitch: UISwitch!
    @IBOutlet weak var nextButton: UIButton!
    
    
    
    var switchHasChanged:Bool = false
    var textFieldsHaveBeenModified:[Bool] = [false, false, false, false]
    var index:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeDelegates()
    }
    func removeDelegates() {
        
    }
    
    func setupUI() {
        firstNameField.delegate = self
        lastNameField.delegate = self
        emailAddressField.delegate = self
        phoneNumberField.delegate = self
        nextButton.isEnabled = false
    }
    
    
    
    @IBAction func next(_ sender: UIButton) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let user = User(context: context)
        user.firstName = firstNameField.text
        user.lastName = lastNameField.text
        user.emailAddress = emailAddressField.text
        user.phoneNumber = phoneNumberField.text
        user.isCoach = roleSwitch.isOn ? true : false
        user.isClient = roleSwitch.isOn ? false : true
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        print(user.description)
        
        // TODO: Add delegate to tell the CreateUserPageViewController to 
        //       scroll the UserInformationViewController page to the
        //       BodyInformationViewController page.
    }
    
    @IBAction func roleSwitchChange(_ sender: UISwitch) {
        if switchHasChanged == false {
            switchHasChanged = true
        }
        
    }

    func updateTextfieldsList() {
        if firstNameField.text != "" && lastNameField.text != "" && emailAddressField.text != "" && phoneNumberField.text != "" && switchHasChanged{
            nextButton.isEnabled = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        textField.resignFirstResponder()
        
        return true
        
    }
    

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        
        updateTextfieldsList()
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    
    func checkIfAllTextfieldsHaveBeenChanged() -> Bool {
        for textFieldBool in textFieldsHaveBeenModified {
            if textFieldBool == false {
                return false
            }
        }
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
