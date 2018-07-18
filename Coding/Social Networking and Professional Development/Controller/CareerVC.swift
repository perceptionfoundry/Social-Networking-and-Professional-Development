//
//  CareerVC.swift
//  Social Networking and Professional Development
//
//  Created by Syed ShahRukh Haider on 18/07/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class CareerVC: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var CPD_Table: UITableView!

    
    
    var dumpy = [["obj":"task1", "status" : "No Achieved"],
                 ["obj":"task2", "status" : "Achieved"],
                 ["obj":"task3", "status" : "Achieved"],
                 ["obj":"task4", "status" : "No Achieved"],
                 ["obj":"task5", "status" : "Achieved"],
                 ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CPD_Table.delegate = self
        CPD_Table.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dumpy.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CPD_CELL", for: indexPath) as! CPD_Cell
        
        tableView.separatorStyle = .none
        
        cell.objective_title.text = dumpy[indexPath.row]["obj"]
        
        if dumpy[indexPath.row]["status"] == "Achieved"{
            
            cell.status_label.textColor = UIColor.green
            cell.status_label.text = "Achieved"
        }
        
        else{
            cell.status_label.text = "No Achieved"

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Plan_Segue", sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
        
    }
}
