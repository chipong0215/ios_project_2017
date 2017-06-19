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
    var acceptorTmp: String?
    var fileUploadDic: [String:Any]?
    var itemTmp: [User]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsetsMake(80,0,0,0);
        
        let databaseRef = Database.database().reference()
        databaseRef.child("ProfileUpload").observe(.value, with: { [weak self] (snapshot) in
            if let uploadDataDic = snapshot.value as? [String:Any] {
                self?.fileUploadDic = uploadDataDic
            }
        })
        
        databaseRef.child("User").observe(.value, with: { snapshot in
            // Create a storage for latest data
            var newItems: [User] = []
            // Adding item to the storage
            for item in snapshot.children {
                let userItem = User(snapshot: item as! DataSnapshot)
                newItems.append(userItem)
//                if userItem.uid  == self.acceptorTmp {
//                    newItems = userItem
//                }
            }
            // Reassign new data and reload view
            self.itemTmp = newItems
            //print(newItems)
        })
        
        var ref: DatabaseReference!
        let uid: String = (Auth.auth().currentUser?.uid)!
        
        // For loop (items in ALL category)
        for category in categoryArray {
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
               // print(tmpEachItems)
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
        if requestItem.status == "open"{
            //let statTmp = requestItem.status
            cell.detailTextLabel?.textColor = UIColor.red
            cell.detailTextLabel?.text = requestItem.status.uppercased()
        }
        else{
            cell.detailTextLabel?.textColor = UIColor.green
            cell.detailTextLabel?.text = requestItem.status.uppercased()
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! BillDetailViewController
                let tmp = myItems[indexPath.row]
                var accepterTmp: User?
                
                for index in 0 ..< (itemTmp?.count)! {
                    if tmp.accepter == itemTmp?[index].uid {
                        accepterTmp = itemTmp?[index]
                    }
                }
                
                if let dataDic = fileUploadDic {
                    if let imageUrlString = dataDic[(accepterTmp?.image)!] as? String {
                        if let imageUrl = URL(string: imageUrlString) {
                            URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, response, error) in
                                if error != nil {
                                    print("Download Image Task Fail: \(error!.localizedDescription)")
                                }
                                else if let imageData = data {
                                    DispatchQueue.main.async {
                                        destinationController.BillDetailPic.image = UIImage(data: imageData)
                                    }
                                }
                            }).resume()
                        }
                    }
                }

                destinationController.helpername = (accepterTmp?.name)!
            }
        }
    }

    
}
