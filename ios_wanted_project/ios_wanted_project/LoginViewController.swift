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
    
    @IBAction func unwindToLoginPage(segue:UIStoryboardSegue) { }
    
    @IBAction func loginButton(_ sender: Any) {
        
        let email = self.emailTextField.text
        
        let password = self.passwordTextField.text
        
        
        if self.emailTextField.text == "" || self.passwordTextField.text == "" {
            Functions.showMsg("請輸入email和密碼", viewController: self)
            return
        }
        else if (password?.characters.count)! < 6 {
            Functions.showMsg("密碼長度要大於6", viewController: self)
        }
        
        Auth.auth().signIn(withEmail: email!, password: password!) { (user, error) in
            // 登入失敗
            if error != nil {
                Functions.showMsg((error?.localizedDescription)!, viewController: self)
            }
                // 登入成功並顯示已登入
            else{
                Functions.showMsgSegue("Welcome Back", viewController: self, segueIdentifier: "LoginMainSegue")
            }
        }
    }
    
   
    
    
    
    func switchStoryboard() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Main") as UIViewController
        
        self.present(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        Auth.auth().addStateDidChangeListener() { auth, user in
            
            if user != nil {
                
                self.switchStoryboard()
            }
        
    }
        
        
        
        
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//    }

}
}
