//
//  PostListViewController.swift
//  ios_wanted_project
//
//  Created by Pong on 2017/5/22.
//  Copyright © 2017年 Pong. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PostListViewController: UITableViewController {
    var items:[RequestItem] = []
    
    static var titleName : String = ""
    let category = MainPageViewController.btnName
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = category
        
        // database access test
        var ref : DatabaseReference!
        ref = Database.database().reference(withPath: "Request")
        
        ref.observe(.value, with: { snapshot in
            var newItems: [RequestItem] = []
            
            for item in snapshot.children {
                let requestItem = RequestItem(snapshot: item as! DataSnapshot)
                newItems.append(requestItem)
            }
            
            self.items = newItems
            self.tableView.reloadData()
        })


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        let requestItem = items[indexPath.row]
        
        cell.textLabel?.text = requestItem.name
        
        return cell
    }
    
           @IBAction func undiwndToHomeScreen(segue:UIStoryboardSegue){
        
    }

}
