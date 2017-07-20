//
//  CreateUserViewController.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 7/18/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import UIKit

class CreateUserViewController: UIViewController, UITextFieldDelegate {

    // UserInformationViewController
    
    // BodyInformationViewController
        
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    var newUser:NewUser!
//    var newUserData:[String:Any]?
    
    
    var index:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
       // setupUIUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUIUser()
        
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeDelegates()
    }
    func removeDelegates() {
        
    }
    
    func setupUIUser() {
        firstNameField.delegate = self
        lastNameField.delegate = self
        emailAddressField.delegate = self
        phoneNumberField.delegate = self
        //nextButton1.isEnabled = false
    }
    
    func setupUIBody() {
        weightField.delegate = self
        heightField.delegate = self
        //nextButton2.isEnabled = false
    }
    
    
    @IBAction func next(_ sender: UIButton) {
        
        if firstNameField.text != "" && lastNameField.text != "" && emailAddressField.text != "" && phoneNumberField.text != "" && roleSwitchHasChanged{
            
                        
            
            

        } else {
            print("ERROR YOU DIDN'T COMPELTE THE USER FORM!")
        }
        
        
        
        // TODO: Add delegate to tell the CreateUserPageViewController to 
        //       scroll the UserInformationViewController page to the
        //       BodyInformationViewController page.
    }
    @IBAction func next2(_ sender: UIButton) {
        guard var newUserData = newUserData else {
            fatalError("Where is the new user data")

        }
        
        if weightField.text != "" && heightField.text != "" && unitSwitchHasChanged {
            
            newUserData["weight"] = weightField.text ?? ""
            newUserData["height"] = heightField.text ?? ""
            newUserData["unit"] = unitSwitch.isOn ? "SI" : "Metric"
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            //var user = User(data: newUserData)
            
            
            //(UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            //print(user.description)
            
        } else {
            print("ERROR YOU DIDN'T COMPELTE THE BODY FORM!")
        }
        
    }
    
    @IBAction func roleSwitchChange(_ sender: UISwitch) {
        if roleSwitchHasChanged == false {
            roleSwitchHasChanged = true
        }
        
    }

    @IBAction func unitSwitchChange(_ sender: UISwitch) {
        if unitSwitchHasChanged == false {
            unitSwitchHasChanged = true
        }
    }
    
//    func updateTextfieldsList() {
//        if firstNameField.text != "" && lastNameField.text != "" && emailAddressField.text != "" && phoneNumberField.text != "" && roleSwitchHasChanged{
//            nextButton1.isEnabled = true
//        }
//    }
//    
//    func updateTextfieldsList2() {
//        if weightField.text != "" && heightField.text != "" && unitSwitchHasChanged {
//            nextButton2.isEnabled = true
//        }
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        textField.resignFirstResponder()
        
        return true
        
    }
    

    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        textField.resignFirstResponder()
        return
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }

    
     
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destinationViewController = segue.destination as? CreateUserViewController {
           destinationViewController.newUserData = newUserData
        }
        
        
    }
 

}
