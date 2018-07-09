//
//  FriendVC.swift
//  Social Networking and Professional Development
//
//  Created by Syed ShahRukh Haider on 04/07/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import Firebase

class FriendVC: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var Friend_Table: UITableView!
    
    
//    var db = Firestore.firestore()
    
    var dbRef : DatabaseReference!
    var dbhandle : DatabaseHandle!
    
    
    var friend_Array = [[String : String]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Friend_Table.delegate = self
        Friend_Table.dataSource = self
        
        dbRef = Database.database().reference()
        dbhandle = dbRef.child("User").observe(.childAdded, with: { (UserSnap) in
            guard let userData = UserSnap.value else{return}
            
            let Uservalue = userData as! [String : String]
            
            if Auth.auth().currentUser?.uid != Uservalue["uID"]{
                
                self.friend_Array.append(Uservalue)
                
            }
            self.Friend_Table.reloadData()

        })
        
//        db.collection("User")
//            .addSnapshotListener { querySnapshot, error in
//                if let error = error {
//                    print("Error retreiving collection: \(error)")
//                }else {
//                    for doc in  (querySnapshot?.documents)!{
//                        //                        print(doc.data())
//
//
//                        self.friend_Array.append(doc.data() as! [String : String])
//
//
//                        print("#######################")
//                        print(self.friend_Array)
//
//                        print("#######################")
//                        //                        self.course_Array[self.loop].Title = doc.data()["Title"] as! String
//
//                    }
//                    self.Friend_Table.reloadData()
//
//                }
//        }

        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friend_Array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
        
//        print("#######################")
//        print(self.friend_Array[indexPath.row]["Display-Name"])
//
//        print("#######################")
        
     
            
            cell.selectionStyle = .none
            tableView.separatorStyle = .none
            
            cell.Friend_Name.text = friend_Array[indexPath.row]["Display-Name"]
            
            let string_url = URL(string: friend_Array[indexPath.row]["Image"]!)
            
            cell.Friend_Image.sd_setImage(with: string_url, placeholderImage: UIImage(named: "add-image"), options: .progressiveDownload, completed: nil)
            
            cell.selectionStyle = .none
            return cell
       
     
        
       
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }

}
