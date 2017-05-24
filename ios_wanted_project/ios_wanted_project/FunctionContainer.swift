//
//  FunctionContainer.swift
//  ios_wanted_project
//
//  Created by Pong on 2017/5/24.
//  Copyright © 2017年 Pong. All rights reserved.
//

import Foundation
import UIKit

struct Functions{
    
    static func showMsg(_ message: String, viewController: UIViewController) {
        let alertController = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "確定", style: .default, handler: nil)
        
        alertController.addAction(cancel)
        
        viewController.present(alertController, animated: true, completion: nil)
    }

    
}
