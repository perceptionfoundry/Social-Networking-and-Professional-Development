//
//  ForgetVC.swift
//  Social Networking and Professional Development
//
//  Created by Syed ShahRukh Haider on 02/07/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import FirebaseAuth

class ForgetVC: UIViewController {

    
    
    @IBOutlet weak var emailTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func SubmitButtonAction(_ sender: Any) {
        

        if (emailTF.text?.isEmpty != true){
            
            Auth.auth().sendPasswordReset(withEmail: emailTF.text!) { (err) in

                
                if err == nil{
                    
                    let AlertVC = UIAlertController(title: "Password Reset", message: "Check your Email Inbox to Password reset process ", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                        self.navigationController?.popViewController(animated: true)
                    })
                    
                    AlertVC.addAction(alertAction)
                    
                    self.present(AlertVC, animated: true, completion: nil)
                }
                
                
            }
        }
        
        
    }
    

}
