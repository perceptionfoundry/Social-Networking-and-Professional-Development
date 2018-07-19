//
//  OfferVC.swift
//  Social Networking and Professional Development
//
//  Created by Syed ShahRukh Haider on 13/07/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class OfferVC: UIViewController,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var offerTable: UITableView!
   
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var SelectedCourseTitle : String!
    //    let db = Firestore.firestore()
    var dbRef : DatabaseReference!
    var dbHandle : DatabaseHandle!
    
    var course_Array = [[String : String]]()
    
    
    var loop = 0
    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        offerTable.dataSource = self
        offerTable.delegate = self
        
        
        
        dbRef = Database.database().reference()
        
        self.dbRef.child("Offer").observe(.childAdded) { (CourseSnap) in
            
            guard let Course_Data = CourseSnap.value else {return}
            
            
            
            
            self.course_Array.append(Course_Data as! [String : String])
            print(self.course_Array)
            self.indicator.isHidden = true
            self.offerTable.reloadData()
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
        return course_Array.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        print("#######################")
        print(self.course_Array[indexPath.row]["Title"])
        
        print("#######################")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "offer", for: indexPath) as! OfferCell
        
        cell.selectionStyle = .none
        tableView.separatorStyle = .none
        
         cell.course_title.text = course_Array[indexPath.row]["Title"]
        cell.offer_label.text = course_Array[indexPath.row]["Offer"]
        
        let string_url = URL(string: course_Array[indexPath.row]["Image_URL"]!)
        
        cell.Course_Image.sd_setImage(with: string_url, placeholderImage: UIImage(named: "no image"), options: .progressiveDownload, completed: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.SelectedCourseTitle = (course_Array[indexPath.row]["Title"])!
        
        
        performSegue(withIdentifier: "Detail_Segue", sender: nil)
    }
    
  
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
