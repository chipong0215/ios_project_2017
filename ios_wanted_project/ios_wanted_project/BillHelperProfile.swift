//
//  BillHelperProfile.swift
//  ios_wanted_project
//
//  Created by valerie's mac on 2017/6/20.
//  Copyright © 2017年 Pong. All rights reserved.
//

import UIKit

class BillHelperProfile: UITableViewController {

    
    
    @IBOutlet weak var ProfileImage: UIImageView!
    
    @IBOutlet weak var NameText: UILabel!
    
    @IBOutlet weak var EmailText: UILabel!
    
    @IBOutlet weak var PhoneText: UILabel!
    
    @IBOutlet weak var DetailText: UITextView!
    
    
    @IBAction func AcceptButton(_ sender: Any) {
    }
    
    @IBAction func RejectButton(_ sender: Any) {
    }
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

   

}
