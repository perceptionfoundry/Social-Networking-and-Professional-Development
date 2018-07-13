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
    
    
    
    var selected_Course: String!
    var courseDetail = [String : String]()
    
    var dbRef : DatabaseReference!
    var dbHandle : DatabaseHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        
        dbRef = Database.database().reference()
        
        dbHandle = dbRef.child("Course").observe(.childAdded, with: { (CourseSnap) in
            guard let Course_Data = CourseSnap.value else {return}
            
            let CourseData = Course_Data as! [String : String]
            
            
            if (CourseData["Title"])! == self.selected_Course!{
                
                self.courseDetail = Course_Data as! [String : String]

                print("*******************************")
                            print(self.courseDetail)
                print("*******************************")
                
                let url = URL(string: CourseData["Image_URL"]!)
                self.Course_Image.sd_setImage(with: url!, placeholderImage: UIImage(named: "no image"), options: .progressiveDownload, completed: nil)
                
                self.Amount.text = CourseData["Price"]!
                self.Title_Label.text = CourseData["Title"]!
                self.Objective_Label.text = CourseData["Objective"]!
                self.Descip_Label.text = CourseData["Description"]!
                self.Whom_Label.text = CourseData["For_Whom"]!
                self.Entry_Label.text = CourseData["Entry_Requirement"]!
                self.Learning_Label.text = CourseData["Learning_Path"]!
                self.Study_Label.text = CourseData["Study_Path"]!
                self.Career_Label.text = CourseData["Career_Path"]!
                self.Outcome_Label.text = CourseData["Outcome"]!
                self.Assessment_Label.text = CourseData["Assessment"]!
            }
            
            
        })
        
        

    }

    @IBAction func Purchase_Button(_ sender: Any) {
    }
    
    @IBAction func Back_Button(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
