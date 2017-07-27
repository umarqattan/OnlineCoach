//
//  FoodDiariesViewController.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 7/18/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import UIKit
import CoreData
class FoodDiariesViewController: UIViewController {

    var foods:[Food] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Food Diary"
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getFoods()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // NSURLRequest
    
    func getFoods() {
        let urlString:String = "https://healthtrackerx.azurewebsites.net/api/Foods"
        let url:URL = URL(string: urlString)!
        let httpMethod:String = "GET"
        let contentType:String = "application/json"
        let cacheControl:String = "no-cache"
        let contentLength = "0"
        
        let allHeaderFields:[String: String]? = [
            "content-type" : contentType,
            "cache-control":cacheControl,
            "content-length": contentLength
        ]
        
        do {
            let request = NSMutableURLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
            
            request.httpMethod = httpMethod
            request.allHTTPHeaderFields = allHeaderFields
            request.httpBody = nil
            
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if error != nil {
                    print(error!)
                } else {
                    let jsonObject = try? JSONSerialization.jsonObject(with: data!, options: .mutableLeaves)
            
                    if let jsonFoods = jsonObject as? [[String:Any]] {
                        
                        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
                        let context = appDelegate.persistentContainer.viewContext
                        
                        let entity = NSEntityDescription.entity(forEntityName: "Food", in: context)
                        
                        for food in jsonFoods {
                            
                            self.foods.append(Food(data: food, entity: entity!, insertInto: context))
                        }
                        appDelegate.saveContext()
                        print("self.theFoods = \(self.foods)")
                    }
                }
            })
            dataTask.resume()
        }
        print(self.foods)
    }
    
    
    // MARK: prepareForSegue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchFoodViewControllerSegue" {
            if let vc = segue.destination as? SearchFoodViewController {
                vc.foods = foods
                
                print("ABOUT TO SEGUE with foods \(vc.foods)")
            }
        }
    }
    
    
}

