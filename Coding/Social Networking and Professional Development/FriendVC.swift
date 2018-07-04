//
//  FriendVC.swift
//  Social Networking and Professional Development
//
//  Created by Syed ShahRukh Haider on 04/07/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class FriendVC: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var Friend_Table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Friend_Table.delegate = self
        Friend_Table.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
       cell.selectionStyle = .none
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 97
    }

}
