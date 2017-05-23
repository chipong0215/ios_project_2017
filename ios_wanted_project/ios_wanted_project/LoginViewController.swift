//
//  LoginViewController.swift
//  ios_wanted_project
//
//  Created by Ricky on 22/5/2017.
//  Copyright © 2017年 Pong. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth


class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginBtn(_ sender: Any) {
        if self.emailTextField.text == "" || self.passwordTextField.text == "" {
            Functions.showMsg("請輸入email和密碼", viewController: self)
            return
        }
        Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
            // 登入失敗
            if error != nil {
                Functions.showMsg((error?.localizedDescription)!, viewController: self)
            }
            // 登入成功並顯示已登入
            Functions.showMsg("登入成功", viewController: self)
        }

    }
    
    @IBAction func ResetBtnClicked(_ sender: UIButton) {
        
    }
}
