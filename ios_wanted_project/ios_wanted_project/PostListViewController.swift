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
import FirebaseAuth

class PostListViewController: UITableViewController {
    
    var items: [RequestItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var ref: DatabaseReference!
        ref = Database.database().reference(withPath: "Request")
        
        // Observe any change in Firebase
        ref.observe(.value, with: { snapshot in
            
            // Create a storage for latest data
            var newItems: [RequestItem] = []
            
            // Adding item to the storage
            for item in snapshot.children {
                let requestItem = RequestItem(snapshot: item as! DataSnapshot)
                newItems.append(requestItem)
            }
            // Reassign new data and reload view
            self.items = newItems
            self.tableView.reloadData()
        })
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
            //return items.count
        //self.postList()
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.navigationItem.title = MainPageViewController.btnName
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        
        let requestItem = items[indexPath.row]
        
        cell.textLabel?.text = requestItem.name
        //print(requestItem.key)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem     // This will show in the next view controller being pushed
        
        if segue.identifier == "ViewPostSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! PostShownViewController
                let tmp = items[indexPath.row]
                
                destinationController.titletmp = tmp.name
                destinationController.rewardtmp = tmp.price
                destinationController.regiontmp = tmp.region
                destinationController.detailtmp = tmp.detail

            }
        }
    }
    
    @IBAction func undiwndToHomeScreen(segue:UIStoryboardSegue){
        
    }

}
