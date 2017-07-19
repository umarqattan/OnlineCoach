//
//  BodyInformationViewController.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 7/18/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import UIKit

class BodyInformationViewController: CreateUserViewController {

    
    @IBOutlet weak var heightField: UITextField!
    
    @IBOutlet weak var weightField: UITextField!
    
    @IBOutlet weak var unitSwitch: UISwitch!
    
    @IBOutlet weak var bodyNextButton: UIButton!
    
    var unitSwitchHasChanged:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        index = 1
        setupUI()
        navigationItem.title = "Body Information"
        // Do any additional setup after loading the view.
    }

    override func setupUI() {
        heightField.delegate = self
        weightField.delegate = self
        bodyNextButton.isEnabled = false
    }
    
    override func updateTextfieldsList() {
        if heightField.text != "" && weightField.text != "" &&  unitSwitchHasChanged {
            bodyNextButton.isEnabled = true
        }
    }
    
    @IBAction func unitChange(_ sender: UISwitch) {
        if unitSwitchHasChanged == false {
            unitSwitchHasChanged = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction override func next(_ sender: UIButton) {
        // TODO: 
        
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
