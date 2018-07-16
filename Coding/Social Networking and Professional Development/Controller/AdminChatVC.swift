//
//  AdminChatVC.swift
//  Social Networking and Professional Development
//
//  Created by Syed ShahRukh Haider on 16/07/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import Firebase

class AdminChatVC: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var adminTable: UITableView!
   
    var dbRef : DatabaseReference!
    var dbhandle : DatabaseHandle!
    
    var friend_Array = [[String : String]]()
    var selectedFrienduID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adminTable.dataSource = self
        adminTable.delegate = self

        // Do any additional setup after loading the view.
        
        dbRef = Database.database().reference()
        dbhandle = dbRef.child("User").observe(.childAdded, with: { (UserSnap) in
            guard let userData = UserSnap.value else{return}
            
            let Uservalue = userData as! [String : String]
            
                
                self.friend_Array.append(Uservalue)
                
      
            self.adminTable.reloadData()
            
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friend_Array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = friend_Array[indexPath.row]["Display-Name"]
        
        //        print("#######################")
        //        print(self.friend_Array[indexPath.row]["Display-Name"])
        //
        //        print("#######################")
        
        
        
        cell.selectionStyle = .none
        tableView.separatorStyle = .none
        
        
        cell.selectionStyle = .none
        return cell
        
        
        
        
        
        //        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedFrienduID = friend_Array[indexPath.row]["uID"]!
        self.performSegue(withIdentifier: "Live_Segue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Live_Segue"{
            let Nav = segue.destination as! UINavigationController
            
            let dest = Nav.viewControllers.first as! chatViewController
            
           
            
            
            dest.channelName = (Auth.auth().currentUser?.uid)! + "live"
            dest.receiverID = selectedFrienduID
            dest.currentUserId = "Live_Segue"
            dest.DP = UIImage(named: "person")
        }
        
        
    }


}
