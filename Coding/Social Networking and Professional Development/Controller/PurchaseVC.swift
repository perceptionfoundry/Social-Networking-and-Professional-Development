//
//  PurchaseVC.swift
//  Social Networking and Professional Development
//
//  Created by Syed ShahRukh Haider on 04/07/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class PurchaseVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var SelectedCourseTitle : String!

    
    @IBOutlet weak var purchase_table: UITableView!
    
    //    let db = Firestore.firestore()
    var dbRef : DatabaseReference!
    var dbHandle : DatabaseHandle!
    
    var purchase_array = [[String : String]]()
    
    
    var loop = 0
    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        purchase_table.dataSource = self
        purchase_table.delegate = self
        
        
        
        dbRef = Database.database().reference()
        
        self.dbRef.child("Purchase").child((Auth.auth().currentUser?.uid)!).observe(.childAdded) { (CourseSnap) in
            
            guard let Course_Data = CourseSnap.value else {return}
            
            print(Course_Data)
            
            
            self.purchase_array.append(Course_Data as! [String : String])
            print(self.purchase_array)

            self.purchase_table.reloadData()
        }
        
        
        
        
        // *********** FireStore *******************
        //        db.collection("Course")
        //            .addSnapshotListener { querySnapshot, error in
        //                if let error = error {
        //                    print("Error retreiving collection: \(error)")
        //                }else {
        //                    for doc in  (querySnapshot?.documents)!{
        ////                        print(doc.data())
        //
        //
        //                        self.course_Array.append(doc.data() as! [String : String])
        //
        //
        //                        print("#######################")
        //                        print(self.course_Array)
        //
        //                        print("#######################")
        ////                        self.course_Array[self.loop].Title = doc.data()["Title"] as! String
        //
        //                    }
        //                    self.Course_Table.reloadData()
        //
        //                }
        //        }
        
        //******************************
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchase_array.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PurchaseCell", for: indexPath) as! purchaseCell
        cell.Purchase_description.text = purchase_array[indexPath.row]["Course"]
        let string_url = URL(string: purchase_array[indexPath.row]["Image_URL"]!)

        cell.Purchase_Image.sd_setImage(with: string_url, placeholderImage: UIImage(named: "no image"), options: .progressiveDownload, completed: nil)

        cell.selectionStyle = .none
        tableView.separatorStyle = .none
        
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(purchase_array[indexPath.row])
        
        
        self.SelectedCourseTitle = (purchase_array[indexPath.row]["Course"])!
        
        
        performSegue(withIdentifier: "Detail_Segue", sender: nil)
    }
    
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }

    @IBAction func liveChat_button(_ sender: Any) {
        
        performSegue(withIdentifier: "Live_Segue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Live_Segue"{
            let Nav = segue.destination as! UINavigationController
            
            let dest = Nav.viewControllers.first as! chatViewController
            
            
            dbRef = Database.database().reference()
            dbHandle = dbRef.child("User").observe(.childAdded, with: { (UserSnap) in
                guard let userData = UserSnap.value else{return}
                
                let Uservalue = userData as! [String : String]
                
                if Auth.auth().currentUser?.uid == Uservalue["uID"]{
                    
                    
                    let fileUrl = Uservalue["Image"] as! String
                    let url = URL(string: fileUrl)
                    let data = NSData(contentsOf: url!)
                    let picture = UIImage(data: data as! Data)
                    dest.DP = picture!
                    
                }
                
            })
            
            
            
            
            dest.channelName = (Auth.auth().currentUser?.uid)! + "live"
            dest.receiverID = "dsjkhvasd982fbh"
            dest.currentUserId = (Auth.auth().currentUser?.uid)!

        }
        else{
            let dest = segue.destination as! DetailVC
            
            dest.selected_Course = SelectedCourseTitle
        }
        
    }
 

}
