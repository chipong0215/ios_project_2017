//
//  ProfileTableViewController.swift
//  ios_wanted_project
//
//  Created by valerie's mac on 2017/6/8.
//  Copyright © 2017年 Pong. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class ProfileTableViewController: UITableViewController {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var FirstCell: UITableViewCell!
    @IBOutlet weak var SecondCell: UITableViewCell!
    @IBOutlet weak var LogoutCell: UITableViewCell!
    
    @IBOutlet weak var UserName: UILabel!
    var fireUploadDic: [String:Any]?
    var userItem: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsetsMake(44,0,0,0);
        
        let databaseRef = Database.database().reference()
        let userID : String = (Auth.auth().currentUser?.uid)!
        
        databaseRef.child("ProfileUpload").observe(.value, with: { [weak self] (snapshot) in
            
            if let uploadDataDic = snapshot.value as? [String:Any] {
                
                self?.fireUploadDic = uploadDataDic
                self?.tableView!.reloadData()
            }
        })

        // Observe any change in Firebase
        databaseRef.child("User").observe(.value, with: { snapshot in
            
            // Create a storage for latest data
            var newItems: User?
            
            // Adding item to the storage
            for item in snapshot.children {
                let requestItem = User(snapshot: item as! DataSnapshot)
                //print(requestItem.uid)
                if requestItem.uid  == userID {
                    newItems = requestItem
                }
            }
            // Reassign new data and reload view
            self.userItem = newItems
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logoutBtn(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    // #warning Incomplete implementation, return the number of rows
    {
        if (section == 0){
            return 2
        } else if (section == 1){
            return 2}
        else if (section == 2){
            return 2
        }
        else
        {
        return 1
        }
    }
    @IBAction func undiwndToHomeScreen(segue:UIStoryboardSegue){
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        if indexPath == [0,0] {
            
            //set the data here
            let cell = FirstCell
            
            if self.userItem?.image == nil {
                return cell!
            }
            
            if let dataDic = fireUploadDic {
                if let imageUrlString = dataDic[self.userItem!.image] as? String {
                    if let imageUrl = URL(string: imageUrlString) {
                        
                        URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, response, error) in
                            
                            if error != nil {
                                
                                print("Download Image Task Fail: \(error!.localizedDescription)")
                            }
                            else if let imageData = data {
                                
                                DispatchQueue.main.async {
                                    
                                    self.iconView.image = UIImage(data: imageData)
                                }
                            }
                            
                        }).resume()
                    }
                }
            }
            //  iconView.image = UIImage(named: "gear")
            // print("im here")
            
            UserName.text = userItem?.name
            
            return cell!
        }
        else if indexPath == [0,1] {
            let cell = SecondCell
            
            // ...
            return cell!
        }
        else if indexPath == [3,0] {
            let cell = LogoutCell
            
            return cell!
        }
        else  {
        
            
            return LogoutCell!
        }
               // Configure the cell...
        
        //return cell
    }
}



