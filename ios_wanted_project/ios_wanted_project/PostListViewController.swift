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
        
        // database access test
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
    struct GroceryItem {
        
        let key: String
        let name: String
        let ref: DatabaseReference?
        var completed: Bool
        
        init(name: String, completed: Bool, key: String = "") {
            self.key = key
            self.name = name
            self.completed = completed
            self.ref = nil
        }
        
        init(snapshot: DataSnapshot) {
            key = snapshot.key
            let snapshotValue = snapshot.value as! [String: AnyObject]
            name = snapshotValue["name"] as! String
            completed = snapshotValue["completed"] as! Bool
            ref = snapshot.ref
        }
        
        func toAnyObject() -> Any {
            return [
                "name": name,
                "completed": completed
            ]
        }
        
    }

    @IBAction func addButton(_ sender: AnyObject) {
        var ref : DatabaseReference!
        ref = Database.database().reference()
        
        let alert = UIAlertController(title: "Grocery Item",
                                      message: "Add an Item",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { _ in
                                        // 1
                                        guard let textField = alert.textFields?.first,
                                            let text = textField.text else { return }
                                        
                                        // 2
                                        let groceryItem = GroceryItem(name: text,
                                                                      completed: false)
                                        // 3
                                        let groceryItemRef = ref.child(text.lowercased())
                                        
                                        // 4
                                        groceryItemRef.setValue(groceryItem.toAnyObject())
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    @IBAction func undiwndToHomeScreen(segue:UIStoryboardSegue){
        
    }

}
