//
//  BillDetailViewController.swift
//  ios_wanted_project
//
//  Created by Pong on 2017/6/19.
//  Copyright © 2017年 Pong. All rights reserved.
//

import UIKit
import Firebase

class BillDetailViewController: UIViewController {
    
    @IBOutlet weak var BillDetailPic: UIImageView!
    @IBOutlet weak var HelperName: UILabel!
    @IBOutlet weak var AcceptBtn: UIButton!
    @IBOutlet weak var DeclineBtn: UIButton!
    
    
    let categoryArray = ["Cleaning", "Fixing", "Childcare", "Pets", "Cooking", "Tutoring"]
    var keytmp = ""
    var requestertmp = ""
    var helpername = ""
    var working_count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if working_count == 1 {
            self.AcceptBtn.setTitle("Finish", for: .normal)
            self.DeclineBtn.isHidden = true
        }
        else if working_count == 2 {
            self.AcceptBtn.isHidden = true
            self.DeclineBtn.isHidden = true
        }
        
        HelperName.text = helpername
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func GoProfileBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func AcceptByRequestorBtn(_ sender: UIButton) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        if self.AcceptBtn.titleLabel!.text == "Finish" {
            let requestRef = ref.child("/Request/\(keytmp)")
            let userRef = ref.child("/User/\(requestertmp)/request")
            
            // Update request data
            requestRef.updateChildValues(["status": "finish"])
            // Update user data
            userRef.updateChildValues(["\(keytmp)": "finish"])
            Functions.showMsg("It's done.", viewController: self)
        }
        else {
            let requestRef = ref.child("/Request/\(keytmp)")
            let userRef = ref.child("/User/\(requestertmp)/request")
            
            // Update request data
            requestRef.updateChildValues(["status": "working"])
            // Update user data
            userRef.updateChildValues(["\(keytmp)": "working"])
            Functions.showMsg("You have successfully found a helper!", viewController: self)
        }
    }
    

}
