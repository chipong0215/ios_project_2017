//
//  PasswordViewController.swift
//  ios_wanted_project
//
//  Created by Ricky on 22/5/2017.
//  Copyright © 2017年 Pong. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth

class ResetPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func resetPassword(_ sender: Any) {
        if self.emailTextField.text == "" {
            self.showMsg("請輸入email")
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: self.emailTextField.text!, completion: { (error) in
            // 重設失敗
            if error != nil {
                self.showMsg((error?.localizedDescription)!)
                return
            }
            
            self.showMsg("重設成功，請檢查信箱信件")
        })
    }
    func showMsg(_ message: String) {
        let alertController = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "確定", style: .default, handler: nil)
        
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
