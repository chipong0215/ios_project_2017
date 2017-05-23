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
            self.showMsg("請輸入email和密碼")
            return
        }
        Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
            // 登入失敗
            if error != nil {
                self.showMsg((error?.localizedDescription)!)
            }
            // 登入成功並顯示已登入
            self.showMsg("登入成功")
        }

    }
    
    @IBAction func ResetBtnClicked(_ sender: UIButton) {
        
    }
    
    func showMsg(_ message: String) {
        let alertController = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "確定", style: .default, handler: nil)
        
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true, completion: nil)
    }

}
