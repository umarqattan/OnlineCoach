//
//  RegisteredViewController.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 7/20/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import UIKit
import CoreData


class RegisteredViewController: UIViewController {

    
    
    var data:[String:Any]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        
        let user = User(data: data, entity: entity!, insertInto: context)
        
        
        print(user.description)
        
        navigationItem.backBarButtonItem?.title = "Goals"
            
            
        appDelegate.saveContext()
        
        
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
