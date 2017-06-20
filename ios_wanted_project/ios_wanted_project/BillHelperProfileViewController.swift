//
//  BillHelperProfileViewController.swift
//  ios_wanted_project
//
//  Created by Pong on 2017/6/20.
//  Copyright © 2017年 Pong. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class BillHelperProfileViewController: UIViewController {

    @IBOutlet weak var ProfilePic: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var PhoneLabel: UILabel!
    @IBOutlet weak var DetailTextLabel: UITextView!
    @IBOutlet weak var AcceptBtn: UIButton!
    @IBOutlet weak var RejectBtn: UIButton!
    
    var userItem: User?
    
    var nameTmp = ""
    var emailTmp = ""
    var phoneTmp = ""
    var detailTmp = ""
    static var working_count = 0
    static var keytmp = ""
    static var requestertmp = ""
    static var requestCase = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if BillHelperProfileViewController.requestCase == 0 {
            
            NameLabel.text = nameTmp
            EmailLabel.text = "Email: \(emailTmp)"
            PhoneLabel.text = "Tel: \(phoneTmp)"
            DetailTextLabel.text = detailTmp
            
        } else if BillHelperProfileViewController.requestCase == 1 {
            
            var ref: DatabaseReference!
            ref = Database.database().reference(withPath: "User")
            print(BillHelperProfileViewController.requestertmp)
            ref.observe(.value, with: { snapshot in
                var newItems: User?
                for item in snapshot.children {
                    let userTmp = User(snapshot: item as! DataSnapshot)
                    if userTmp.uid == BillHelperProfileViewController.requestertmp {
                        newItems = userTmp
                    }
                }
                self.userItem = newItems
                
                self.NameLabel.text = self.userItem!.name
                self.EmailLabel.text = "Email: \(self.userItem!.email)"
                self.PhoneLabel.text = "Tel: \(self.userItem!.tel)"
                self.DetailTextLabel.text = self.userItem?.detail
            })
            
        }
        
        
        if BillHelperProfileViewController.working_count == 1 {
            self.RejectBtn.isHidden = true
            self.AcceptBtn.setTitle("Finish", for: .normal)
        }
        else if BillHelperProfileViewController.working_count == 2 {
            self.RejectBtn.isHidden = true
            self.AcceptBtn.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func AcceptBtnClicked(_ sender: UIButton) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        if self.AcceptBtn.titleLabel!.text == "Finish" {
            let requestRef = ref.child("/Request/\(BillHelperProfileViewController.keytmp)")
            let userRef = ref.child("/User/\(BillHelperProfileViewController.requestertmp)/request")
            
            // Update request data
            requestRef.updateChildValues(["status": "finish"])
            // Update user data
            userRef.updateChildValues(["\(BillHelperProfileViewController.keytmp)": "finish"])
            Functions.showMsg("It's done.", viewController: self)
        }
        else {
            let requestRef = ref.child("/Request/\(BillHelperProfileViewController.keytmp)")
            let userRef = ref.child("/User/\(BillHelperProfileViewController.requestertmp)/request")
            
            // Update request data
            requestRef.updateChildValues(["status": "working"])
            // Update user data
            userRef.updateChildValues(["\(BillHelperProfileViewController.keytmp)": "working"])
            Functions.showMsg("You have successfully found a helper!", viewController: self)
        }
    }

    

}
