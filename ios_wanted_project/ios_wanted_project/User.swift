//
//  User.swift
//  ios_wanted_project
//
//  Created by Llewellyn Cheung on 11/6/2017.
//  Copyright © 2017 Pong. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

struct User {

    let uid: String
    let email: String
    let name: String
    let tel: String
    
    init(uid: String, email: String, name: String, tel: String) {
        self.uid = uid
        self.email = email
        self.name = name
        self.tel = tel
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        
        name = snapshotValue["name"] as! String
        uid = snapshotValue["uid"] as! String
        email = snapshotValue["email"] as! String
        tel = snapshotValue["tel"] as! String
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "email": email,
            "uid": uid,
            "tel": tel,
        ]
    }


}
