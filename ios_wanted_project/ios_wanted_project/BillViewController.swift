//
//  BillViewController.swift
//  ios_wanted_project
//
//  Created by valerie's mac on 2017/6/19.
//  Copyright © 2017年 Pong. All rights reserved.
//

import UIKit
import Firebase

class BillViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var privatelist1 = ["11","22"]
    var privatelist2 = ["111","222"]
    var privatelist3 = ["1111","2222"]
    
    let categoryArray = ["Cleaning", "Fixing", "Childcare", "Pets", "Cooking", "Tutoring"]
    var myItems: [RequestItem] = []
    var acceptorTmp: String?
    var fileUploadDic: [String:Any]?
    var itemTmp: [User]?
    
    @IBOutlet weak var Control: UISegmentedControl!
    
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            }
            // Reassign new data and reload view
            self.itemTmp = newItems
            //print(newItems)
        })

        var ref: DatabaseReference!
        let uid: String = (Auth.auth().currentUser?.uid)!
        
        for category in categoryArray {
            ref = Database.database().reference(withPath: "Request").child(category)
            ref.observe(.value, with: { snapshot in
                // For loop (items in EACH category)
                var tmpEachItems: [RequestItem] = []
                for item in snapshot.children {
                    var requestItem = RequestItem(snapshot: item as! DataSnapshot)
                    if requestItem.requester == uid {
                        requestItem.category = category
                        tmpEachItems.append(requestItem)
                    }
                }
                self.myItems += tmpEachItems
                self.TableView.reloadData()
            })
        }
        
//        for index in 0 ..< myItems.count {
//            if myItems[index].status == "accept" {
//                acCount += 1
//            }
//        }
        
    }

    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BillCell1", for: indexPath)
        
        switch(Control.selectedSegmentIndex)
        {
        case 0:
            let requestItem = myItems[indexPath.row]
            cell.textLabel?.text = requestItem.name
            if requestItem.status == "open"{
                cell.detailTextLabel?.textColor = UIColor.red
                cell.detailTextLabel?.text = requestItem.status.uppercased()
            }
            else{
                cell.detailTextLabel?.textColor = UIColor.green
                cell.detailTextLabel?.text = requestItem.status.uppercased()
            }
            break
        case 1:
            cell.textLabel?.text = privatelist2[indexPath.row]
            break
        case 2:
            cell.textLabel?.text = privatelist3[indexPath.row]
            break
        default :
            break
        }
        
        
        return cell
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var returnValue = 0
       switch(Control.selectedSegmentIndex)
       {
       case 0:
        returnValue = self.myItems.count
        
        break
       case 1:
        returnValue = privatelist2.count
        break
       case 2:
        returnValue = privatelist3.count
        break
       default :
        break
        }
        
    return returnValue
        
    }
    
    
    @IBAction func ControlAction(_ sender: Any) {
        TableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailSegue" {
            if let indexPath = TableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! BillDetailViewController
                let tmp = myItems[indexPath.row]
                var accepterTmp: User?
                
                destinationController.requestertmp = tmp.requester
                destinationController.keytmp = tmp.key
                destinationController.categorytmp = tmp.category
                
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
