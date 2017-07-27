//
//  LoginViewController.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 7/24/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerHereButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        loginButton.accessibilityIdentifier = "loginButton"
        registerHereButton.accessibilityIdentifier = "registerHereButton"
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
