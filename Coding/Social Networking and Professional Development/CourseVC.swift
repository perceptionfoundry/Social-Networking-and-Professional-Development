//
//  CourseVC.swift
//  Social Networking and Professional Development
//
//  Created by Syed ShahRukh Haider on 03/07/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class CourseVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    
    @IBOutlet weak var Course_Table: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Course_Table.dataSource = self
        Course_Table.delegate = self

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Course-Cell", for: indexPath) as! CourseCell
        
        cell.selectionStyle = .none
        tableView.separatorStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
}
