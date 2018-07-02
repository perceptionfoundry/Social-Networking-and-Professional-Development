//
//  SignInVC.swift
//  Social Networking and Professional Development
//
//  Created by Syed ShahRukh Haider on 29/06/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInVC: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        
    }


    @IBAction func loginButtonAction(_ sender: Any) {
        
        if (emailTF.text?.isEmpty != true) && (passwordTF.text?.isEmpty != true){
            
            Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) { (user, err) in
                print(user?.email)
            }
        }
    }
    

}

