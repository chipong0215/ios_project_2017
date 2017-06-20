//
//  PostShownViewController.swift
//  ios_wanted_project
//
//  Created by Pong on 2017/5/23.
//  Copyright © 2017年 Pong. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PostShownViewController: UIViewController {
   
   
    
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var RewardLabel: UILabel!
    @IBOutlet weak var RegionLabel: UILabel!
    @IBOutlet weak var DetailTextViewLabel: UITextView!
    @IBOutlet weak var TimeLabel: UILabel!
    
    var titletmp = ""
    var rewardtmp = ""
    var regiontmp = ""
    var detailtmp = ""
    var keytmp = ""
    var timetmp = ""
    var requestertmp = ""
    
    @IBAction func AcceptBtn(_ sender: UIButton) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let requestRef = ref.child("/Request/\(keytmp)")
        let userRef = ref.child("/User/\(requestertmp)/request")
        let accepterID: String = (Auth.auth().currentUser?.uid)!
        
        guard requestertmp != accepterID else {
            Functions.showMsg("You cannot accept your own request!", viewController: self)
            return
        }
        // Update request data
        requestRef.updateChildValues(["accepter": accepterID])
        requestRef.updateChildValues(["status": "accepted"])
        // Update user data
        userRef.updateChildValues(["\(keytmp)": "accepted"])
        Functions.showMsg("Apply Success!!!\nWait For Confirmatation", viewController: self)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = MainPageViewController.btnName;
        
        TitleLabel.text = titletmp
        RewardLabel.text = rewardtmp
        RegionLabel.text = regiontmp
        DetailTextViewLabel.text = detailtmp
        TimeLabel.text = timetmp
        // Do any additional setup after loading the view.
    }
    
    
    //let cosmosView = CosmosView()
    /* source from : https://github.com/marketplacer/Cosmos/issues/18
     func update(rating: Double) {
     CosmosStar.rating
     CosmosStar.didTouchCosmos = { rating in
     // Example of using a closure
     }
     }
     */
    
}
