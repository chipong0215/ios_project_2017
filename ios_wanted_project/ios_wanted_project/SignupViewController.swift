//
//  SignupViewController.swift
//  ios_wanted_project
//
//  Created by Ricky on 22/5/2017.
//  Copyright © 2017年 Pong. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
    }
    
    @IBAction func createAccBtnClicked(_ sender: UIButton) {
        
        let email = self.emailTextField.text
        
        let password = self.passwordTextField.text
        
        if email == "" || password == "" {
            self.showMsg("請輸入email和密碼")
            return
        }
        else if (password?.characters.count)! < 6 {
            self.showMsg("密碼長度要大於6")
        }
        
        // 建立帳號
        Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
            
            // 註冊失敗
            if error != nil {
                self.showMsg((error?.localizedDescription)!)
                return
            }
            
            // 註冊成功並顯示已登入
            self.showMsg("已登入")
        }
        
//        var ref : DatabaseReference!
//        ref = Database.database().reference(withPath: "User")
//        // Create new Object (Request)
//        let regUid: String = (Auth.auth().currentUser?.uid)!
//        let regEmail: String = (Auth.auth().currentUser?.email)!
//        let userRef = ref.child("\(regUid)")
//        
//        // Save data to firebase (setValue)
//        userRef.updateChildValues(["name": ""])
//        userRef.updateChildValues(["tel": ""])
//        userRef.updateChildValues(["image": ""])
//        userRef.updateChildValues(["email": regEmail])
//        userRef.updateChildValues(["uid": regUid])

        
        
    }
    
    
    func showMsg(_ message: String) {
        let alertController = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "確定", style: .default, handler: nil)
        
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
