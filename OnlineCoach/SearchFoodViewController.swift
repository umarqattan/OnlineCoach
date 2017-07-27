//
//  SearchFoodViewController.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 7/26/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import UIKit

class SearchFoodViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var addFoodButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var foods:[Food] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func addFood(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
        // TODO: Add UIAlert notifying the user of the food(s) the user 
        //       selected
    }
    
    
    
    
    // MARK: UITableViewDelegate and UITableViewDataSource Protocols
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let foodCellID = "foodCell"
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: foodCellID) as! FoodCell
        cell.configure(food: foods[indexPath.row])
            
        return cell
        
    }

}



