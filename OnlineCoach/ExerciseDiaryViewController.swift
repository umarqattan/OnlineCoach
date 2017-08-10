//
//  ExerciseDiaryViewController.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 7/18/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//


import UIKit

class ExerciseDiaryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        (UIApplication.shared.delegate as! AppDelegate).accessToken = nil
        
        view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        
    }
    
}

