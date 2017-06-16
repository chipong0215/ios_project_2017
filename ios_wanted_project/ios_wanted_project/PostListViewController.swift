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
    
    var openItems: [RequestItem] = []
    static var category: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        var ref: DatabaseReference!
        ref = Database.database().reference(withPath: "Request").child(PostListViewController.category!)
        
        // Observe any change in Firebase
        ref.observe(.value, with: { snapshot in
            
            // Create a storage for latest data
            var newItems: [RequestItem] = []
            
            // Adding item to the storage
            for item in snapshot.children {
                let requestItem = RequestItem(snapshot: item as! DataSnapshot)
                if requestItem.status != "open" {
                    continue
                } else {
                    newItems.append(requestItem)
                }
            }
            // Reassign new data and reload view
            self.openItems = newItems
            self.tableView.reloadData()
        })
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return openItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.navigationItem.title = MainPageViewController.btnName
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        
        let requestItem = openItems[indexPath.row]
        
        cell.textLabel?.text = requestItem.name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem     // This will show in the next view controller being pushed
        
        if segue.identifier == "ViewPostSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! PostShownViewController
                let tmp = openItems[indexPath.row]
                
                destinationController.titletmp = tmp.name
                destinationController.rewardtmp = tmp.price
                destinationController.regiontmp = tmp.region
                destinationController.detailtmp = tmp.detail
                destinationController.keytmp = tmp.key
                destinationController.requestertmp = tmp.requester
                destinationController.timetmp = tmp.time
                

            }
        }
    }
    
//    override func didMove(toParentViewController parent: UIViewController?) {
//        if (!(parent?.isEqual(self.parent) ?? false)) {
//            print("Parent view loaded")
//        }
//    }
    
    @IBAction func undiwndToPostList(segue:UIStoryboardSegue){
        
    }

}
