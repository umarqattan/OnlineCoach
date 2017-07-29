//
//  DiaryTabBarController.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 7/28/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import UIKit
import CoreData

class DiaryTabBarController: UITabBarController {

    
    var user:User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let pc = presentingViewController as? RegisteredViewController {
            print(pc.user)
            print("We came from the RegisteredViewController!")
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
