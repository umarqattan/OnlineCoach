//
//  BodyInformationViewController.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 7/18/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import UIKit

class BodyInformationViewController: UIViewController, UITextFieldDelegate {

  
    let index = 1
    
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var unitSwitch: UISwitch!
    @IBOutlet weak var nextButton: UIButton!
    
    
    var unitSwitchHasChanged:Bool = false

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        navigationItem.title = "Body Information"
        // Do any additional setup after loading the view.
    }

    
    
    

    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UI Helper functions
    func setupUI() {
        weightField.delegate = self
        heightField.delegate = self
        nextButton.isEnabled = false
    }
    
    func enableNextButton() {
        if weightField.text != nil && heightField.text != nil && unitSwitchHasChanged {
            nextButton.isEnabled = true
        }
    }
    
    
    // UITextFieldDelegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        enableNextButton()
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        enableNextButton()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        
        enableNextButton()
        

    }
    
    // Pragma: IBActions
    
    @IBAction func unitSwitchChange(_ sender: UISwitch) {
        if unitSwitchHasChanged == false {
            unitSwitchHasChanged = true
        }
    }
    
    @IBAction func next(_ sender: UIButton) {
        
        print("SUCCESSFULLY FILLED OUT BODY INFORMATION!")
        
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
