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
    
    @IBAction func AcceptBtn(_ sender: UIButton) {
       // let controller = PostShownViewController as! UIViewController
      //  Functions.showMsg("eeee", viewController: controller)
        Functions.showMsg("Apply Success!!!\nWait For Confirmatation", viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CosmosStar.rating = 1
        self.navigationItem.title = PostListViewController.titleName;
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
