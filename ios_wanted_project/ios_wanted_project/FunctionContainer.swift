//
//  FunctionContainer.swift
//  ios_wanted_project
//
//  Created by Pong on 2017/5/24.
//  Copyright © 2017年 Pong. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

struct Functions{
    
    static func showMsg(_ message: String, viewController: UIViewController) {
        let alertController = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "確定", style: .default, handler: nil)
        
        alertController.addAction(cancel)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    /*
    static func postList() -> [RequestItem]{
        var items : [RequestItem] = []
        
        var ref : DatabaseReference!
        ref = Database.database().reference(withPath: "Request")
        
        // Observe any change in Firebase
        ref.observe(.value, with: { snapshot in
            // Create a storage for latest data
            
            var newItems: [RequestItem] = []
            // Adding item to the storage
            for item in snapshot.children {
                let requestItem = RequestItem(snapshot: item as! DataSnapshot)
                newItems.append(requestItem)
            }
            // Reassign new data and reload view
     
            items = newItems        //items has a proper outcome here
            // self.items = newItems
            // self.tableView.reloadData()
        })
        print("HELLO")
        print(items)
        return items       // it's a fucking nil....
    }
    */
    
}
