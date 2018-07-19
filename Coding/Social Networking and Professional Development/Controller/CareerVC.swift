//
//  CareerVC.swift
//  Social Networking and Professional Development
//
//  Created by Syed ShahRukh Haider on 18/07/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import Firebase

class CareerVC: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var CPD_Table: UITableView!
    
    
    var taskData = [[String:String]]()
    var selectedSugueData = [String : String]()
    
    var dbRef : DatabaseReference!
    var dbHandle : DatabaseHandle!
    
    
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
        
//        dbRef = Database.database().reference()
//        dbHandle = dbRef.child("CPD").child((Auth.auth().currentUser?.uid)!).observe(.childAdded, with: { (taskValue) in
//            
////            print (taskValue.value)
//            
//            let value = taskValue.value as! [String : String]
//            
////            print(value)
//            
//            self.taskData.append(value)
//            
//            print(self.taskData)
//            
//            self.CPD_Table.reloadData()
//        })
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskData.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CPD_CELL", for: indexPath) as! CPD_Cell
        
        tableView.separatorStyle = .none
        
        cell.objective_title.text = self.taskData[indexPath.row]["Title"]
        
        
        if self.taskData[indexPath.row]["Status"] == "Achieved"{
            
            cell.status_label.textColor = UIColor.green
            cell.status_label.text = "Achieved"
        }
        
        else{
            cell.status_label.text = "No Achieved"

        }
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Plan_Segue"{
            
            let dest = segue.destination as! PlanningVC
            
            dest.Segue_resource = "Segue"
            
            print(self.selectedSugueData)
            dest.Segue_Data = self.selectedSugueData
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        print(taskData[indexPath.row])
        
        
        self.selectedSugueData = taskData[indexPath.row]
        
        
        performSegue(withIdentifier: "Plan_Segue", sender: nil)
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        taskData.removeAll()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        taskData.removeAll()
        CPD_Table.reloadData()
        dbRef = Database.database().reference()
        dbHandle = dbRef.child("CPD").child((Auth.auth().currentUser?.uid)!).observe(.childAdded, with: { (taskValue) in
            
            //            print (taskValue.value)
            
            let value = taskValue.value as! [String : String]
            
            //            print(value)
            
            self.taskData.append(value)
            
            print(self.taskData)
            
            self.CPD_Table.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let selectedTitle = self.taskData[indexPath.row]["Title"]
            
            print(selectedTitle)
            
            self.taskData.remove(at: indexPath.row)
            
            print(self.taskData.count)
            
            
             CPD_Table.reloadData()
            self.dbRef.child("CPD").child((Auth.auth().currentUser!.uid)).child(selectedTitle!).removeValue()
           
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
        
    }
}
