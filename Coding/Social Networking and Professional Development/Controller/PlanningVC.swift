//
//  PlanningVC.swift
//  Social Networking and Professional Development
//
//  Created by Syed ShahRukh Haider on 18/07/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class PlanningVC: UIViewController {

    
    @IBOutlet weak var Plan_Title: UITextField!
    @IBOutlet weak var Want_To_Learn: UITextView!
    @IBOutlet weak var Objective: UITextField!
    @IBOutlet weak var personalORprofessional: UITextField!
    @IBOutlet weak var activity: UITextView!
    @IBOutlet weak var support: UITextView!
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var measure: UITextView!
    @IBOutlet weak var Achievement_Segment: UISegmentedControl!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func Edit(_ sender: Any) {
    }
    
    @IBAction func Cancel_Button(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func Save_button(_ sender: Any) {
    }
    



}
