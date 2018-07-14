//
//  DetailVC.swift
//  Social Networking and Professional Development
//
//  Created by Syed ShahRukh Haider on 13/07/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class DetailVC: UIViewController {
    
    @IBOutlet weak var Course_Image: Custom_ImageView!
    
    @IBOutlet weak var Amount: UILabel!
    
    @IBOutlet weak var Title_Label: UILabel!
    @IBOutlet weak var Descip_Label: UILabel!
    @IBOutlet weak var Objective_Label: UILabel!
    @IBOutlet weak var Whom_Label: UILabel!
    @IBOutlet weak var Entry_Label: UILabel!
    @IBOutlet weak var Learning_Label: UILabel!
    @IBOutlet weak var Study_Label: UILabel!
    @IBOutlet weak var Career_Label: UILabel!
    @IBOutlet weak var Outcome_Label: UILabel!
    @IBOutlet weak var Assessment_Label: UILabel!
    
    
    var CourseData = [String : String]()
    var selected_Course: String!
    var courseDetail = [String : String]()
    
    var dbRef : DatabaseReference!
    var dbHandle : DatabaseHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        
        dbRef = Database.database().reference()
        
        dbHandle = dbRef.child("Course").observe(.childAdded, with: { (CourseSnap) in
            guard let Course_Data = CourseSnap.value else {return}
            
             self.CourseData = Course_Data as! [String : String]
            
            
            if (self.CourseData["Title"])! == self.selected_Course!{
                
                self.courseDetail = Course_Data as! [String : String]

                print("*******************************")
                            print(self.CourseData)
                print("*******************************")
                
                let url = URL(string: self.CourseData["Image_URL"]!)
                self.Course_Image.sd_setImage(with: url!, placeholderImage: UIImage(named: "no image"), options: .progressiveDownload, completed: nil)
                
                self.Amount.text = self.CourseData["Price"]!
                self.Title_Label.text = self.CourseData["Title"]!
                self.Objective_Label.text = self.CourseData["Objective"]!
                self.Descip_Label.text = self.CourseData["Description"]!
                self.Whom_Label.text = self.CourseData["For_Whom"]!
                self.Entry_Label.text = self.CourseData["Entry_Requirement"]!
                self.Learning_Label.text = self.CourseData["Learning_Path"]!
                self.Study_Label.text = self.CourseData["Study_Path"]!
                self.Career_Label.text = self.CourseData["Career_Path"]!
                self.Outcome_Label.text = self.CourseData["Outcome"]!
                self.Assessment_Label.text = self.CourseData["Assessment"]!
            }
            
            
        })
        
        

    }

    @IBAction func Purchase_Button(_ sender: Any) {
        performSegue(withIdentifier: "Check_Segue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination  as! CheckOutVC
        
        dest.selectedCourse = self.courseDetail
    }
    
    @IBAction func Back_Button(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
