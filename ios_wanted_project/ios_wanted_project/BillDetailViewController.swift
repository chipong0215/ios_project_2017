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
    
    
    let categoryArray = ["Cleaning", "Fixing", "Childcare", "Pets", "Cooking", "Tutoring"]
    var keytmp = ""
    var requestertmp = ""
    var helpername = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            let requestRef = ref.child("/Request/\(keytmp)")
            let userRef = ref.child("/User/\(requestertmp)/request")
        
            // Update request data
            requestRef.updateChildValues(["status": "working"])
            // Update user data
            userRef.updateChildValues(["\(keytmp)": "working"])
            Functions.showMsg("You have successfully found a helper!", viewController: self)
        
    }
    

}
