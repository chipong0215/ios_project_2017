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
    static var titleName : String = ""
    let category = MainPageViewController.btnName
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = category
        
        var ref : DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("Request").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value1 = snapshot.value as? NSDictionary
            let category = value1?["Category"] as? String
            //let user = User.init(username: username)
            print(category)
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }

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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if category == "清潔"  {
            return 2
        }
        else {
            return 4
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)

        let label = cell.viewWithTag(1) as! UILabel
        label.text = category
        PostListViewController.titleName = category
        //titleList.title = label.text
        
        return cell
    }
    
       //Write Data Trial
    
//    @IBAction func addButton(_ sender: AnyObject) {
//        var ref : DatabaseReference!
//        ref = Database.database().reference(withPath: "Request")
//        
//        let alert = UIAlertController(title: "Add New Request",
//                                      message: "Add an Item",
//                                      preferredStyle: .alert)
//        
//        let saveAction = UIAlertAction(title: "Save",
//                                       style: .default) { _ in
//                                        // 1 Get text from alert
//                                        guard let textField = alert.textFields?.first,
//                                            let text = textField.text else { return }
//                                        let status = "open"
//                                        
//                                        // 2 Create new Object (Request)
//                                        let groceryItem = RequestItem(name: text,
//                                                                      status: status)
//                                        // 3 Create reference
//                                        let groceryItemRef = ref.child(text.lowercased())
//                                        
//                                        // 4 Save data to firebase (setValue)
//                                        groceryItemRef.setValue(groceryItem.toAnyObject())
//        }
//        
//        let cancelAction = UIAlertAction(title: "Cancel",
//                                         style: .default)
//        
//        alert.addTextField()
//        
//        alert.addAction(saveAction)
//        alert.addAction(cancelAction)
//        
//        present(alert, animated: true, completion: nil)
//    }
    @IBAction func undiwndToHomeScreen(segue:UIStoryboardSegue){
        
    }

}
