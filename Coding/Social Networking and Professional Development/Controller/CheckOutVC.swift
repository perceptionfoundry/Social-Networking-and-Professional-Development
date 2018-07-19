//
//  CheckOutVC.swift
//  Social Networking and Professional Development
//
//  Created by Syed ShahRukh Haider on 13/07/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class CheckOutVC: UIViewController {

    @IBOutlet weak var Course_Image: Custom_ImageView!
    @IBOutlet weak var Price_label: UILabel!
    @IBOutlet weak var Course_Title: UILabel!
    @IBOutlet weak var User_Name: UITextField!
    @IBOutlet weak var CreditCard: UITextField!
    @IBOutlet weak var CVV: UITextField!
    
    var selectedCourse = [String: String]()
    
    
    var dbRef : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("*************************")
        print(selectedCourse)
        print("*******************")
        
        
//        let url = URL(string: self.selectedCourse["Image_URL"]!)
//        self.Course_Image.sd_setImage(with: url!, placeholderImage: UIImage(named: "no image"), options: .progressiveDownload, completed: nil)
        
        self.Course_Image.image = UIImage(named: "logo.png")
        self.Price_label.text = selectedCourse["Price"]
        self.Course_Title.text = selectedCourse["Title"]
        
        
    }

    @IBAction func Confirm_Action(_ sender: Any) {
        print(self.User_Name.text!)
        print(self.CreditCard.text!)
        print(self.CVV.text!)
        
       
        if (self.User_Name.text?.isEmpty == false) && (self.CVV.text?.isEmpty == false) && (self.CreditCard.text?.isEmpty == false) {
        let courseName = selectedCourse["Title"]!
        let CardHolder = self.User_Name.text!
        let CreditCard = self.CreditCard.text!
        let CVV = self.CVV.text!
        let urlLink = selectedCourse["Image_URL"]!
        
        
        dbRef = Database.database().reference()
            
            var cart = ["Course": courseName, "Card_holder" : CardHolder,"Credit_Card" : CreditCard,"CVV": CVV, "Image_URL": urlLink]
        
        dbRef.child("Purchase").child((Auth.auth().currentUser?.uid)!).childByAutoId().setValue(cart)
            self.dismiss(animated: true, completion: nil)
    
    }
    else{
    
    let AlertVC = UIAlertController(title: "Text Field Empty", message: "One or more fields are empty", preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    AlertVC.addAction(alertAction)
    
    self.present(AlertVC, animated: true, completion: nil)
    
    }
        
    }
    
    @IBAction func Cancel_Button(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
