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
    
    var billdetailpic: UIImageView?
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
    

}
