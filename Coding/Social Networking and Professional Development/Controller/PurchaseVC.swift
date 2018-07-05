//
//  PurchaseVC.swift
//  Social Networking and Professional Development
//
//  Created by Syed ShahRukh Haider on 04/07/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class PurchaseVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var purchase_table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        purchase_table.dataSource = self
        purchase_table.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PurchaseCell", for: indexPath) as! purchaseCell
        cell.selectionStyle = .none
        tableView.separatorStyle = .none
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 131
        
    }

 

}
