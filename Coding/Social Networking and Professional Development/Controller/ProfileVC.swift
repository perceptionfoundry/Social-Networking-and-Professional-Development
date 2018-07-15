//
//  ProfileVC.swift
//  Gleepads
//
//  Created by Syed ShahRukh Haider on 23/03/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage


class ProfileVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //*********** STRUCT TO MANAGE DATA IN CELL WILL HOLD *************
    
    struct Cell_info {
        let cell : Int
        let image : UIImage?
        let Title : String?
        let Sub_Title  : String
    }
    
    // ********** VARIABLE ***********

    
    var vcNAme = [String]()

    @IBOutlet weak var profileTableView: UITableView!
    
    var dataArray = [Cell_info]()
    var userValue = ["":""]
    
    var fullName : String!
    var ProfileImage : UIImage!
    
    
    // FIREBASE
    var dbRef : DatabaseReference!
    var dbHandle : DatabaseHandle!
    let storage = Storage.storage()

    
    var profileURL : URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            self.fullName = (Auth.auth().currentUser?.displayName)

     
       
        
 
        // ********** USER VALUE ****************
        dbRef = Database.database().reference()
        
        dbHandle = dbRef.child("User").child((Auth.auth().currentUser?.uid)!).observe(.value, with: { (SnapShot) in
            if  SnapShot != nil {
               
                
                self.userValue = SnapShot.value as! [String : String]
                
                let first = self.userValue["First-Name"]!
                let last = self.userValue["Last-Name"]!
                
                self.fullName = first + " " + last
                print(self.fullName)

                    
                let url = self.userValue["Image"]!
                
                 self.profileURL = URL(string: url)

                
                
                print("********* 1 **************")
                print(self.profileURL)
                

                
                
                
                print("******** USER PROFILE ******")
                print(self.userValue)
                print("***************")
                
            }
          self.profileTableView.reloadData()
        })

        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
       
        
        // ********** DATA FOR TABLEVIEW CELL ***********

        dataArray = [Cell_info(cell: 1, image: self.ProfileImage, Title: self.fullName, Sub_Title: ""),
                     Cell_info(cell: 3, image: #imageLiteral(resourceName: "help.png"), Title: nil, Sub_Title: "About US"),
                     Cell_info(cell: 3, image: #imageLiteral(resourceName: "feedback.png"), Title: nil, Sub_Title: "Give us feedback"),
                     Cell_info(cell: 3, image: #imageLiteral(resourceName: "Sign Out.png"), Title: nil, Sub_Title: "Log Out"),

        ]
        
        
        // *********  NAME OF VIEW-CONTROLLER THAT WILL OPEN SELECTING TABLE CELL *************
        vcNAme = ["AboutUS",
                  "Feedback"]
        
        profileTableView.delegate = self
        profileTableView.dataSource = self
        
        profileTableView.reloadData()
     
    }
    
    
    
    
    
    // HANDLE NUMBER OF CELL
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    
    
    // HANDLE WHAT DATA TO BE SHOWN TO WHICH CELL.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if dataArray[indexPath.row].cell == 1{
            let cell = Bundle.main.loadNibNamed("TopTableViewCell", owner: self, options: nil)?.first as! TopTableViewCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.backgroundColor = UIColor.clear
//            cell.TitleLabel.text = dataArray[indexPath.row].Title
            cell.TitleLabel.text = self.fullName
            cell.subTitleLabel.text = dataArray[indexPath.row].Sub_Title
            
            
             print("********* 2 **************")
            print(profileURL)
            
            cell.imageCell.sd_setImage(with: profileURL, placeholderImage: UIImage(named: "Add-image"), options: .progressiveDownload, completed: nil)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(imageChange))
            cell.imageCell.addGestureRecognizer(tap)
        
            
            return cell

        }
       
        else{
            let cell = Bundle.main.loadNibNamed("ButtonTableViewCell", owner: self, options: nil)?.first as! ButtonTableViewCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.backgroundColor = UIColor.clear
            cell.buttonImage.image = dataArray[indexPath.row].image
            cell.buttonTitle.text = dataArray[indexPath.row].Sub_Title
            return cell
        }

    }
    
    // SETTING HEIGHT OF RESPECTIVE CELL

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if dataArray[indexPath.row].cell == 1{
           return 108
            
        }
        else if dataArray[indexPath.row].cell == 2{
            return 150
            
        }
            
        else{
            return 60
        }
    }
    
    // ENABLE "SELECT CELL" FEATURE
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
//        if indexPath.row >= 2 {
//            let VC = vcNAme[(indexPath.row)-2]
//            let controller = storyboard?.instantiateViewController(withIdentifier: VC)
//            self.navigationController?.pushViewController(controller!, animated: true)
//        }
        if indexPath.row == 1{
            
            UIApplication.shared.open(URL(string: "https://cmls-global.com/about/")!, options: [:], completionHandler: nil)
        }
        
        else if indexPath.row == 2{
            UIApplication.shared.open(URL(string: "https://cmls-global.com/contact/")!, options: [:], completionHandler: nil)
        }
        else if indexPath.row == 3{
            let VC = UIAlertController(title:nil, message: nil, preferredStyle: .actionSheet)
            let logoutAction = UIAlertAction(title: "Log Out", style: .default, handler: { (action) in
                
                
                
                self.present( UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main_Nav") as UIViewController, animated: true, completion: nil)
                
                let firebaseAuth = Auth.auth()
                do {
                    try firebaseAuth.signOut()
                } catch let signOutError as NSError {
                    print ("Error signing out: %@", signOutError)
                }
                
            })
            let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            VC.addAction(logoutAction)
            VC.addAction(CancelAction)
            
            present(VC, animated: true, completion: nil)
            
        }
       
    }
    
    
    // ********** Change profile photo *******
    @objc func imageChange(){
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
    
        present(imagePicker, animated: true, completion: nil)
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        let selectedImage = info["UIImagePickerControllerOriginalImage"] as! UIImage
        
        var imageData = Data()
        
        imageData = UIImageJPEGRepresentation(selectedImage, 0.3)!
        
        
        
        let storageRef = self.storage.reference().child((Auth.auth().currentUser?.uid)!).child("User_Profile").child("profile_Image")
        
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
                
            self.dbRef.child("User_Profile").child((Auth.auth().currentUser?.uid)!).child("ProfileImage_Url").setValue((metaData?.downloadURL()?.description)!)
                
                
            }
        })
        
        
        
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
   
}
