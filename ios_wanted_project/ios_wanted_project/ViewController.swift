//
//  ViewController.swift
//  lai dog
//
//  Created by Pong on 2017/4/26.
//  Copyright © 2017年 Pong. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class MainViewController: UITableViewController, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

