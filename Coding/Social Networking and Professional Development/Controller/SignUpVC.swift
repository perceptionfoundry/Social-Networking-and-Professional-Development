//
//  SignUpVC.swift
//  Social Networking and Professional Development
//
//  Created by Syed ShahRukh Haider on 02/07/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class SignUpVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    
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
    var dbRef : DatabaseReference!
    var docRef : DocumentReference!
    let storage = Storage.storage()

    var selectedProfileImage : UIImage?
    var imageMetaData = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(imageUpload))
        profileImage.addGestureRecognizer(imageTap)
    }

    
    
    
    
    @IBAction func SubmitButtonAction(_ sender: Any) {
        
        
        
        
        
        //Create Login credential
        
        if passwordTF.text?.isEmpty != true && confirmPasswordTF.text?.isEmpty != true && emailTF.text?.isEmpty != true && firstNameTF.text?.isEmpty != true && lastNameTF.text?.isEmpty != true && mobileNumberTf.text?.isEmpty != true && displayNameTF.text?.isEmpty != true && placeTF.text?.isEmpty != true && studyTF.text?.isEmpty != true && workTF.text?.isEmpty != true{
            
            var userInfo = ["First-Name":firstNameTF.text!,
                            "Last-Name": lastNameTF.text!,
                            "Email-Address": emailTF.text!,
                            "Mobile-Number": mobileNumberTf.text!,
                            "Display-Name": displayNameTF.text!,
                            "Place":placeTF.text!,
                            "Study":studyTF.text!,
                            "Work":workTF.text!,
                            "Image":imageMetaData,
                            "uID":""
                
            ]
            
            
            // *************** create authentication database *********************
            if passwordTF.text! == confirmPasswordTF.text!{
                
                Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!) { (User, err_email) in
                    
                    
                    
                            var imageData = Data()
                    
                            imageData = UIImageJPEGRepresentation(self.selectedProfileImage!, 0.3)!
                    
                    
                    
                            let storageRef = self.storage.reference().child("User_Profile").child((Auth.auth().currentUser?.uid)!).child("profile_Image")
                    
                            let uploadMetaData = StorageMetadata()
                            uploadMetaData.contentType = "image/jpeg"
                            storageRef.putData(imageData, metadata: uploadMetaData, completion: { (metaData, error) in
                    
                
                    
                                if error != nil{
                    
                                    let alert = UIAlertController(title: "ERROR!", message: error?.localizedDescription, preferredStyle: .alert)
                    
                                    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                    
                                    self.present(alert, animated: true, completion: nil)
                    
                    
                                }
                    
                    
                    
                                else{
                                    
                                    print(metaData?.downloadURL()?.description)
                    
                                    userInfo["uID"] = (Auth.auth().currentUser?.uid)!
                                    userInfo["Image"] = (metaData?.downloadURL()?.description)!
                    
                                    
                                    
                                    if err_email?.localizedDescription ==  nil{
                                        print("Successful!!!")
                                        
                                        print(userInfo)
                                        print((Auth.auth().currentUser?.uid)!)
                                        
                                        
                                        self.dbRef = Database.database().reference()
                                        
                                        self.dbRef.child("User").child((Auth.auth().currentUser?.uid)!).setValue(userInfo)
                                        
                                        
                                        
                                        let AlertVC = UIAlertController(title: "VERIFY EMAIL ADDRESS", message: "Please check your Email inbox to verify given email", preferredStyle: .alert)
                                        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                                                    Auth.auth().currentUser?.sendEmailVerification(completion: { (err_veri  ) in
                                        
                                                        print(err_veri?.localizedDescription)
                                                                    })
                                            self.navigationController?.popViewController(animated: true)
                                                    })
                                                AlertVC.addAction(alertAction)
                                        
                                        self.present(AlertVC, animated: true, completion: nil)
                                        
                                        
                                        
                                        //************************ FireStore **************************
                                        
//                                        let  db = Firestore.firestore()
//                                        db.collection("User").document((Auth.auth().currentUser?.uid)!).setData(userInfo, completion: {
//                                            (err) in
//                                            if err == nil{
//                                                
//                                                let AlertVC = UIAlertController(title: "VERIFY EMAIL ADDRESS", message: "Please check your Email inbox to verify given email", preferredStyle: .alert)
//                                                let alertAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
//                                                    Auth.auth().currentUser?.sendEmailVerification(completion: { (err_veri  ) in
//                                                        
//                                                        print(err_veri?.localizedDescription)
//                                                    })
//                                                    self.navigationController?.popViewController(animated: true)
//                                                })
//                                                AlertVC.addAction(alertAction)
//                                                
//                                                self.present(AlertVC, animated: true, completion: nil)
//                                            }
//                                        })
                                        
                                        // ********************************
                                        
                                    }
                                        
                                        
                                    else{
                                        
                                        
                                        let AlertVC = UIAlertController(title: "Alert", message: err_email?.localizedDescription, preferredStyle: .alert)
                                        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                                        
                                        AlertVC.addAction(alertAction)
                                        
                                        self.present(AlertVC, animated: true, completion: nil)
                                    }
                    
                                }
                            })
                    

                    

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
    
    // ********** Change profile photo *******
    @objc func imageUpload(){
        
        print("************ tap *************")
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        let selectedImage = info["UIImagePickerControllerOriginalImage"] as! UIImage
        
        self.selectedProfileImage = selectedImage
        

        self.profileImage.image = selectedImage

        
        
        dismiss(animated: true, completion: nil)
        
    }
    

}
