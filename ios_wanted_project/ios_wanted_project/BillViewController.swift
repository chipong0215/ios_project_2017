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
    
    //let categoryArray = ["Cleaning", "Fixing", "Childcare", "Pets", "Cooking", "Tutoring"]
    var myItems: [RequestItem] = []
    var acceptItems: [RequestItem] = []
    var finishItems: [RequestItem] = []
    
    var fileUploadDic: [String:Any]?
    var itemTmp: [User]?
    
    @IBOutlet weak var Control: UISegmentedControl!
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        var ref: DatabaseReference!
        ref = Database.database().reference(withPath: "Request")
        let uid: String = (Auth.auth().currentUser?.uid)!
        
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

        // My Request
        // Observe any change in Firebase
        ref.observe(.value, with: { snapshot in
            
            // Create a storage for latest data
            var tmpEachItems: [RequestItem] = []
            //var tmpEachItems2: [RequestItem] = []
            
            // Adding item to the storage
            for item in snapshot.children {
                let requestItem = RequestItem(snapshot: item as! DataSnapshot)
                if requestItem.requester == uid && requestItem.status != "finish"{
                    tmpEachItems.append(requestItem)
                }
                
            }
            // Reassign new data and reload view
            self.myItems = tmpEachItems
            //self.finishItems = tmpEachItems2
            self.TableView.reloadData()
        })
        
        // My Accept
        ref.observe(.value, with: { snapshot in
            
            var tmpEachItems: [RequestItem] = []
            
            // Adding item to the storage
            for item in snapshot.children {
                let requestItem = RequestItem(snapshot: item as! DataSnapshot)
                if requestItem.accepter == uid && requestItem.status != "finish"{
                    tmpEachItems.append(requestItem)
                }
            }
            // Reassign new data and reload view
            self.acceptItems = tmpEachItems
            self.TableView.reloadData()
        })
        
        // My Finish
        ref.observe(.value, with: { snapshot in
            var tmpEachItems: [RequestItem] = []
            
            // Adding item to the storage
            for item in snapshot.children {
                let requestItem = RequestItem(snapshot: item as! DataSnapshot)
                if requestItem.requester == uid && requestItem.status == "finish"{
                    tmpEachItems.append(requestItem)
                }
            }
            // Reassign new data and reload view
            self.finishItems = tmpEachItems
            self.TableView.reloadData()
        })
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
            if requestItem.status == "open"{
                cell.textLabel?.text = requestItem.name

                cell.detailTextLabel?.textColor = UIColor.red
                cell.detailTextLabel?.text = requestItem.status.uppercased()
            }
            else if requestItem.status == "working"{
                cell.textLabel?.text = requestItem.name

                cell.detailTextLabel?.textColor = UIColor.green
                cell.detailTextLabel?.text = requestItem.status.uppercased()
            }
            else if requestItem.status == "accepted"{
                cell.textLabel?.text = requestItem.name

                cell.detailTextLabel?.textColor = UIColor.orange
                cell.detailTextLabel?.text = requestItem.status.uppercased()
            }
            break
        case 1:
            let requestItem = acceptItems[indexPath.row]
            cell.textLabel?.text = requestItem.name
            if requestItem.status == "accepted"{
                cell.detailTextLabel?.textColor = UIColor.orange
                cell.detailTextLabel?.text = requestItem.status.uppercased()
            }
            else{
                cell.detailTextLabel?.textColor = UIColor.green
                cell.detailTextLabel?.text = requestItem.status.uppercased()
            }
            break
        case 2:
            let requestItem = finishItems[indexPath.row]
            cell.textLabel?.text = requestItem.name
            cell.detailTextLabel?.textColor = UIColor.lightGray
            cell.detailTextLabel?.text = requestItem.status.uppercased()
            
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
        returnValue = self.acceptItems.count
        break
       case 2:
        returnValue = self.finishItems.count
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
        
        switch(Control.selectedSegmentIndex)
        {
        case 0:
            if segue.identifier == "DetailSegue" {
                if let indexPath = TableView.indexPathForSelectedRow {
                    let destinationController = segue.destination as! JobDetailViewController
                    let tmp = myItems[indexPath.row]
                    var accepterTmp: User?
                    
                    for index in 0 ..< (itemTmp?.count)! {
                        if tmp.accepter == itemTmp?[index].uid {
                            accepterTmp = itemTmp?[index]
                        }
                    }
                    destinationController.userProfileTmp = accepterTmp
                    destinationController.titletmp = tmp.name
                    destinationController.timetmp = tmp.time
                    destinationController.rewardtmp = tmp.price
                    destinationController.regiontmp = tmp.region
                    destinationController.detailtmp = tmp.detail
                    BillHelperProfileViewController.requestCase = 0
                    
                    if tmp.status == "working" {
                        BillHelperProfileViewController.working_count = 1
                    }
                    else {
                        BillHelperProfileViewController.working_count = 0
                    }
                    
                    BillHelperProfileViewController.requestertmp = tmp.requester
                    BillHelperProfileViewController.keytmp = tmp.key
                    
                    if tmp.status == "open" {
                        destinationController.caseCount = -1
                    }
                    else {
                        destinationController.caseCount = 0
                    }
                }
            }
            break
        case 1:
            if segue.identifier == "DetailSegue" {
                if let indexPath = TableView.indexPathForSelectedRow {
                    let destinationController = segue.destination as! JobDetailViewController
                    let tmp = acceptItems[indexPath.row]
                    var accepterTmp: User?
                    
                    for index in 0 ..< (itemTmp?.count)! {
                        if tmp.accepter == itemTmp?[index].uid {
                            accepterTmp = itemTmp?[index]
                        }
                    }
                    destinationController.userProfileTmp = accepterTmp
                    destinationController.titletmp = tmp.name
                    destinationController.timetmp = tmp.time
                    destinationController.rewardtmp = tmp.price
                    destinationController.regiontmp = tmp.region
                    destinationController.detailtmp = tmp.detail
                    BillHelperProfileViewController.requestCase = 1
                    
                    if tmp.status == "working" || tmp.status == "accepted" {
                        BillHelperProfileViewController.working_count = 2
                    }

                    
                    //destinationController.helpername = (accepterTmp?.name)!
                    BillHelperProfileViewController.requestertmp = tmp.requester
                    //print(BillHelperProfileViewController.requestertmp)
                    BillHelperProfileViewController.keytmp = tmp.key
                    destinationController.caseCount = 1
                    
                    
                }
            }
            break
        case 2:
            if segue.identifier == "DetailSegue" {
                if let indexPath = TableView.indexPathForSelectedRow {
                    let destinationController = segue.destination as! JobDetailViewController
                    let tmp = finishItems[indexPath.row]
                    var accepterTmp: User?
                    
                    for index in 0 ..< (itemTmp?.count)! {
                        if tmp.accepter == itemTmp?[index].uid {
                            accepterTmp = itemTmp?[index]
                        }
                    }
                    destinationController.userProfileTmp = accepterTmp
                    destinationController.titletmp = tmp.name
                    destinationController.timetmp = tmp.time
                    destinationController.rewardtmp = tmp.price
                    destinationController.regiontmp = tmp.region
                    destinationController.detailtmp = tmp.detail
                    BillHelperProfileViewController.requestCase = 0
                    
                    if tmp.status == "finish" {
                        BillHelperProfileViewController.working_count = 2
                    }
                    
                    //destinationController.helpername = (accepterTmp?.name)!
                    BillHelperProfileViewController.requestertmp = tmp.requester
                    BillHelperProfileViewController.keytmp = tmp.key
                    destinationController.caseCount = 0
                }
            }

            break
        default :
            break
        }
        
    }
}
