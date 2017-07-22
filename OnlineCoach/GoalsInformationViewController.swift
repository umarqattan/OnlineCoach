//
//  GoalsInformationViewController.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 7/18/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import UIKit

class GoalsInformationViewController: UIViewController, UITextFieldDelegate {
    
    

    var data:[String:Any]?
   

    @IBOutlet weak var goalControl: UISegmentedControl!
    
    var goalsSegmentedControlHasChanged:Bool = false
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Goals"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UI Helper functions
    func setupUI() {
        
        
    }
    
    func enableNextButton() {
        if goalsSegmentedControlHasChanged {
            
        }
       
    }
    
    
    // UITextFieldDelegate Methods
    
    
   
    
    // Pragma: IBActions
    
    
    @IBAction func goalControlChange(_ sender: UISegmentedControl) {
        if goalsSegmentedControlHasChanged == false {
            goalsSegmentedControlHasChanged = true
            enableNextButton()
        }
    
    }
    
    
    @IBAction func next(_ sender: UIButton) {
        print("YOU REGISTERED!")

    }
   
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RegisteredViewControllerSegue" {
            let vc = segue.destination as? RegisteredViewController
            
            data?["goal"] = goalControl.titleForSegment(at: goalControl.selectedSegmentIndex)
            vc?.data = data
        }
        
    }
    
}
