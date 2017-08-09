//
//  BodyInformationViewController.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 7/18/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import UIKit

class BodyInformationViewController: UIViewController, UITextFieldDelegate {

  
    
    
    
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var unitSwitch: UISwitch!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var heightUnitLabel: UILabel!
    @IBOutlet weak var weightUnitLabel: UILabel!
    
    
    var unitSwitchHasChanged:Bool = false
    var data:[String:Any]!
    let datePickerView:UIDatePicker = UIDatePicker()
    var age:Int16!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAccessiblity()
        setupUI()
        
        
        //parent?.navigationItem.title = "Body Information"
        //navigationItem.title = "Body Information"
        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Body"
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UI Helper functions
    func setupUI() {
        weightField.delegate = self
        heightField.delegate = self
        ageField.delegate    = self
        nextButton.isEnabled = false
        
        datePickerView.datePickerMode = .date
        
        //
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneDatePicker(_ :)))
        doneButton.accessibilityIdentifier = "doneButton"
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker(_ :)))
        cancelButton.accessibilityIdentifier = "cancelButton"
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        datePickerView.accessibilityIdentifier = "datePickerView"
        
        ageField.inputAccessoryView = toolbar
       
        ageField.inputView = datePickerView

    }
    
    func setupAccessiblity() {

        
        heightField.accessibilityIdentifier = "heightField"
        weightField.accessibilityIdentifier = "weightField"
        ageField.accessibilityIdentifier = "ageField"
        unitSwitch.accessibilityIdentifier = "unitSwitch"
        nextButton.accessibilityIdentifier = "nextButton"
        heightUnitLabel.accessibilityIdentifier = "heightUnitLabel"
        weightUnitLabel.accessibilityIdentifier = "weightUnitLabel"
        
        
    }
    
    // MARK: selector methods
    
    @objc func doneDatePicker(_ sender:UIBarButtonItem) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        
        ageField.text = dateFormatter.string(from: datePickerView.date)
        age = datePickerView.date.age
        ageField.endEditing(true)
    }
    
    @objc func cancelDatePicker(_ sender:UIBarButtonItem) {
        ageField.text = ""
        ageField.endEditing(true)
    }
    
    @objc func datePickerValueChanged(_ sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        
        ageField.text = dateFormatter.string(from: sender.date)
        age = sender.date.age
    }
    
    func enableNextButton() {
        
        
        if weightField.text != nil && heightField.text != nil && ageField.text != nil {
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    // Pragma: IBActions
    
    @IBAction func unitSwitchChange(_ sender: UISwitch) {
        if unitSwitchHasChanged == false {
            unitSwitchHasChanged = true
        }
        
        if unitSwitch.isOn {
            heightUnitLabel.text = "in"
            weightUnitLabel.text = "lb"

            
            
        } else {
            heightUnitLabel.text = "cm"
            weightUnitLabel.text = "kg"
        }
    }
    
    
    
    @IBAction func next(_ sender: UIButton) {
        
        print("SUCCESSFULLY FILLED OUT BODY INFORMATION!")
        
        
    
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoalsInformationViewControllerSegue" {
            
            let vc = segue.destination as? GoalsInformationViewController
            
            data["height"] = Int16(heightField.text!)
            data["weight"] = Float(weightField.text!)
            data["isMetric"] = unitSwitch.isOn ? false : true
            data["birthdate"] = ageField.text!
            vc?.data = data
        }
    
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
