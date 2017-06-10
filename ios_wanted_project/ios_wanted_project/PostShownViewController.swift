//
//  PostShownViewController.swift
//  ios_wanted_project
//
//  Created by Pong on 2017/5/23.
//  Copyright © 2017年 Pong. All rights reserved.
//

import UIKit
import Cosmos

class PostShownViewController: UIViewController {
   
    @IBOutlet weak var CosmosStar: CosmosView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var RewardLabel: UILabel!
    @IBOutlet weak var RegionLabel: UILabel!
    @IBOutlet weak var DetailTextViewLabel: UITextView!
    
    @IBAction func AcceptBtn(_ sender: UIButton) {
       // let controller = PostShownViewController as! UIViewController
      //  Functions.showMsg("eeee", viewController: controller)
        Functions.showMsg("Apply Success!!!\nWait For Confirmatation", viewController: self)
    }
    
    var titletmp = ""
    var rewardtmp = ""
    var regiontmp = ""
    var detailtmp = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CosmosStar.rating = 1
        self.navigationItem.title = MainPageViewController.btnName;
        
        TitleLabel.text = titletmp
        RewardLabel.text = rewardtmp
        RegionLabel.text = regiontmp
        DetailTextViewLabel.text = detailtmp
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
