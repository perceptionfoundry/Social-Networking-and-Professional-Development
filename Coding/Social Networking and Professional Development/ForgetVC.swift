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
                print(err?.localizedDescription)
            }
        }
        
        
    }
    

}
