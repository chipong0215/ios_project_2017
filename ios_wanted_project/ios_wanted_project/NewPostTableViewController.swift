//
//  NewPostTableViewController.swift
//  ios_wanted_project
//
//  Created by valerie's mac on 2017/6/8.
//  Copyright © 2017年 Pong. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class NewPostTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var regionList = ["文山區", "大安區", "新店區", "信義區", "中山區", "萬華區"]
    let regionPicker = UIPickerView()
    
    @IBOutlet weak var requestTime: UITextField!
    @IBOutlet weak var requestName: UITextField!
    @IBOutlet weak var requestPrice: UITextField!
    @IBOutlet weak var requestRegion: UITextField!
    @IBOutlet weak var requestDetail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        regionPicker.delegate = self
        regionPicker.dataSource = self
        requestRegion.inputView = regionPicker
        
        let ref = Database.database().reference(withPath: "Request")
        ref.observe(.value, with: { snapshot in
            //print(snapshot.value)
        })
        
    }
    
    // MARK: Write Data Code
    
    @IBAction func addPostButton(_ sender: AnyObject) {
        // Set Reference
        var ref : DatabaseReference!
        ref = Database.database().reference(withPath: "Request")
        
        // Get info from user's input
        let name = requestName.text
        let price = requestPrice.text
        let region = requestRegion.text
        let detail = requestDetail.text
        let time = requestTime.text
        let status = "open"
        
        // Get current user info
        let userId: String = (Auth.auth().currentUser?.uid)!
        
        // Create reference to firebase
        let requestItemRef = ref.childByAutoId()
        let key = requestItemRef.key
        
        // Create new Object (Request)
        let requestItem = RequestItem(name: name!, price: price!, region: region!,time: time!, detail: detail!, status: status, requester: userId, accepter: "")
        
        // Save data to firebase (setValue)
        requestItemRef.setValue(requestItem.toAnyObject())
        
        // Create new Object (User)
        let userRequestUpdate = [key: status]
        
        // Child update
        let userRef = Database.database().reference(withPath: "User")
        let idRef = userRef.child("\(userId)")
        let userRequestRef = idRef.child("request")
        userRequestRef.updateChildValues(userRequestUpdate)
        
        Functions.showMsgSegue("Your request is being published.", viewController: self, segueIdentifier: "BackToPostList")
    }
    
    // MARK: Picker View Code
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return regionList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return regionList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        requestRegion.text = regionList[row]
        self.view.endEditing(false)
    }


}

