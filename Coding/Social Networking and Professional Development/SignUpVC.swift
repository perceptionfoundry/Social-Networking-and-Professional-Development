//
//  SignUpVC.swift
//  Social Networking and Professional Development
//
//  Created by Syed ShahRukh Haider on 02/07/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import Firebase


class SignUpVC: UIViewController {

    
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var mobileNumberTf: UITextField!
    @IBOutlet weak var displayNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var placeTF: UITextField!
    @IBOutlet weak var studyTF: UITextField!
    @IBOutlet weak var workTF: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    // Firebase Variable
    
    var db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func SubmitButtonAction(_ sender: Any) {
        
        //Create Login credential
        
        if passwordTF.text?.isEmpty != true && confirmPasswordTF.text?.isEmpty != true && emailTF.text?.isEmpty != true && firstNameTF.text?.isEmpty != true && lastNameTF.text?.isEmpty != true && mobileNumberTf.text?.isEmpty != true && displayNameTF.text?.isEmpty != true && placeTF.text?.isEmpty != true && studyTF.text?.isEmpty != true && workTF.text?.isEmpty != true{
            
            let userInfo = ["First-Name":firstNameTF.text!,
                            "Last-Name": lastNameTF.text!,
                            "Email-Address": emailTF.text!,
                            "Mobile-Number": mobileNumberTf.text!,
                            "Display-Name": displayNameTF.text!,
                            "Place":placeTF.text!,
                            "Study":studyTF.text!,
                            "Work":workTF.text!
            ]
            
            
            // *************** create authentication database *********************
            if passwordTF.text! == confirmPasswordTF.text!{
                
                Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!) { (User, err) in
                    
                    
                    if err?.localizedDescription ==  nil{
                        print("Successful!!!")
                        
                        
                        var ref : DocumentReference? = nil
                        
                        ref = self.db.collection("User").addDocument(data: userInfo, completion: { (err) in
                            if err == nil{
                                
                                print("Database Created")
                            }
                        })
                    }
                    
                    
                    else{
                        
                        
                        let AlertVC = UIAlertController(title: "Alert", message: err?.localizedDescription, preferredStyle: .alert)
                        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        
                        AlertVC.addAction(alertAction)
                        
                        self.present(AlertVC, animated: true, completion: nil)
                    }
                }
            }
            
            else{
                let AlertVC = UIAlertController(title: "Password Doesnot Mismatch", message: "Re-enter Password as password is not mismatching", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                AlertVC.addAction(alertAction)
                
                self.present(AlertVC, animated: true, completion: nil)
                
            }
           
        }
            
          // ************* alert will pop up if ant textfield is empty **************
        else{
            
            let AlertVC = UIAlertController(title: "Text Field Empty", message: "One or more fields are empty", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            AlertVC.addAction(alertAction)
            
            self.present(AlertVC, animated: true, completion: nil)
            
        }
        
    }
    

}
