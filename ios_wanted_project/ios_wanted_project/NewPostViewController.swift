//
//  NewPostViewController.swift
//  ios_wanted_project
//
//  Created by Llewellyn Cheung on 8/6/2017.
//  Copyright © 2017 Pong. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class NewPostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var requestName: UITextField!
    @IBAction func addPostButton(_ sender: AnyObject) {
        
        var ref : DatabaseReference!
        ref = Database.database().reference(withPath: "Request")
        
        // 1 Get info from textfield
        let text = requestName.text
        let status = "open"
                                        
        // 2 Create new Object (Request)
        let groceryItem = GroceryItem(name: text!, status: status)
                                        
        // 3 Create reference to firebase
        let groceryItemRef = ref.child(text!.lowercased())
                                        
        // 4 Save data to firebase (setValue)
        groceryItemRef.setValue(groceryItem.toAnyObject())
    
    }

    
}

    



