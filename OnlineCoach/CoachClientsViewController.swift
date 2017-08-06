//
//  CoachClientsViewController.swift
//  OnlineCoach
//
//  Created by Umar Qattan on 8/5/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import UIKit
import CoreData

class CoachClientsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var clients:[User] = []
    
    
    
    @IBOutlet weak var tableView: UITableView!
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
    
    func setupUI() {
        tableView.delegate = self
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientCell") as! ClientCell
        
        cell.configure(client: clients[indexPath.row])
        
        return cell
    }

}
