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
        
        
//        if Auth.auth().currentUser != nil{
//            
//            self.performSegue(withIdentifier: "Dashboard_Segue", sender: nil)
//
//            
//        }
        
    }


    @IBAction func loginButtonAction(_ sender: Any) {
        
        if (emailTF.text?.isEmpty != true) && (passwordTF.text?.isEmpty != true){
            
           
            
            if (emailTF.text == "admin@admin.com") && (passwordTF.text == "admin123"){
                
                
                 self.performSegue(withIdentifier: "Admin_Segue", sender: nil)
                
            }
                
            else{
                Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) { (user, err) in
                    if err == nil{
                        
                        if Auth.auth().currentUser?.isEmailVerified == true{
                            //
                            
                            self.performSegue(withIdentifier: "Dashboard_Segue", sender: nil)
                            
                            
                        }
                            
                            
                            
                        else{
                            
                            let AlertVC = UIAlertController(title: "VERIFY EMAIL", message: "Email address has not be verified yet, so please check your email inbox", preferredStyle: .alert)
                            let alertAction = UIAlertAction(title: "OK", style:.default, handler: { (action) in
                                Auth.auth().currentUser?.sendEmailVerification(completion: { (err_veri  ) in
                                    
                                    print(err_veri)
                                })
                            })
                            
                            AlertVC.addAction(alertAction)
                            
                            self.present(AlertVC, animated: true, completion: nil)
                        }
                    }
                        
                    else{
                        let AlertVC = UIAlertController(title: "Server Error", message: err?.localizedDescription, preferredStyle: .alert)
                        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        
                        AlertVC.addAction(alertAction)
                        
                        self.present(AlertVC, animated: true, completion: nil)                }
                }
            }
        }
    }
    

}

