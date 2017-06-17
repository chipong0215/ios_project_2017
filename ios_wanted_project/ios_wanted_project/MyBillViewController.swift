//
//  MyBillViewController.swift
//  ios_wanted_project
//
//  Created by Pong on 2017/5/23.
//  Copyright © 2017年 Pong. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class MyBillViewController: UITableViewController {
    
    let categoryArray = ["Cleaning", "Fixing", "Childcare", "Pets", "Cooking", "Tutoring"]
    var myItems: [RequestItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsetsMake(80,0,0,0);
        
        var ref: DatabaseReference!
        let uid: String = (Auth.auth().currentUser?.uid)!
        
        // For loop (items in ALL category)
        for category in categoryArray {
            print(category)
            ref = Database.database().reference(withPath: "Request").child(category)
        
            ref.observe(.value, with: { snapshot in
                // For loop (items in EACH category)
                var tmpEachItems: [RequestItem] = []
                for item in snapshot.children {
                    let requestItem = RequestItem(snapshot: item as! DataSnapshot)
                    if requestItem.requester == uid {
                        tmpEachItems.append(requestItem)
                    }
                }
                print(tmpEachItems)
                self.myItems += tmpEachItems
                self.tableView.reloadData()
            })
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myItems.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BillCell", for: indexPath)
        let requestItem = myItems[indexPath.row]
        cell.textLabel?.text = requestItem.name
        
        return cell
    }
    
    
}
