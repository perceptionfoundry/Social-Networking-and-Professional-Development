//
//  PlanningVC.swift
//  Social Networking and Professional Development
//
//  Created by Syed ShahRukh Haider on 18/07/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit


protocol dateFetching {
    func dateValue(Date : String)
}

class PlanningVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, dateFetching {
    
    
    
    

    
    @IBOutlet weak var Plan_Title: UITextField!
    @IBOutlet weak var Want_To_Learn: UITextView!
    @IBOutlet weak var Objective: UITextField!
    @IBOutlet weak var personalORprofessional: UITextField!
    @IBOutlet weak var activity: UITextView!
    @IBOutlet weak var support: UITextView!
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var measure: UITextView!
    @IBOutlet weak var Achievement_Segment: UISegmentedControl!
    
    
    var dateValue : String?

    var PickerView = UIPickerView()
    var Term_option = ["Short term (less than a year)","Long term (more than a year)"]
    var category = ["Personal","Corporate","Job","Business"]

    func dateValue(Date: String) {
        
        print("Date:\(Date)")
        
        self.dateValue = Date
        self.date.text = Date
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        PickerView.dataSource = self
        PickerView.delegate = self
        self.Objective.delegate = self
        self.personalORprofessional.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SettingDate))
        date.addGestureRecognizer(tap)
    }

    @objc func SettingDate(){
        
        performSegue(withIdentifier: "Date_Segue", sender: nil)
        
    }
    
  
    @IBAction func Status_Segment(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
    }
    
    
    
    
    
    @IBAction func Edit(_ sender: Any) {
    }
    
    @IBAction func Cancel_Button(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func Save_button(_ sender: Any) {
    }
    

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.Objective{
            self.PickerView.tag = 0
            self.Objective.inputView = self.PickerView
            self.PickerView.reloadAllComponents()
        }
        else if  textField == self.personalORprofessional{
            self.PickerView.tag = 1
            self.personalORprofessional.inputView = self.PickerView
            self.PickerView.reloadAllComponents()
        }
        
//        else if textField == self.date{
//            performSegue(withIdentifier: "Date_Segue", sender: nil)
//
//        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        print(self.PickerView.tag)
        
        
        if textField == self.Objective {
            self.PickerView.tag = 0
            self.Objective.inputView = nil
            self.PickerView.reloadAllComponents()
        }
        else if  textField == self.personalORprofessional{
            self.PickerView.tag = 1
            self.personalORprofessional.inputView = nil
            self.PickerView.reloadAllComponents()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Date_Segue"
        {
            
            let dest = segue.destination as! DateCheckinVC
            
            dest.dateDelegate = self
            
            
        }
            
     
    }
    
    
    // ******** PICKERVIEW DELEGATE METHODS *********
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if PickerView.tag == 0 {
            return Term_option.count
        }
        else {
            return category.count
        }
        
    }
    
    
    // *******  ASSIGN TITLE TO PICKERVIEW ****************
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if PickerView.tag == 0 {
            return Term_option[row]
        }
        else {
            return category[row]
        }
    }
    
    
    // *********** SELECT DESIRE VALUE  *********
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        if PickerView.tag == 0 {
            self.Objective.text = Term_option[row]
        }
        else {
            self.personalORprofessional.text = category[row]
        }
        
    }


}
