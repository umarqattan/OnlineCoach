//
//  FoodDiaryViewController.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 7/18/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import UIKit
import CoreData
class FoodDiaryViewController: UIViewController {

    var foods:[Food] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Food Diary"
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        foods = appDelegate.foods
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: prepareForSegue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchFoodViewControllerSegue" {
            if let vc = segue.destination as? SearchFoodViewController {
                vc.foods = foods
                
                print("ABOUT TO SEGUE TO SEARCHFOODVIEWCONTROLLER")
            }
        }
    }
    
    
}

