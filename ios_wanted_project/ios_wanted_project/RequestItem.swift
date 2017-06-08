//
//  RequestItem.swift
//  ios_wanted_project
//
//  Created by Llewellyn Cheung on 8/6/2017.
//  Copyright © 2017 Pong. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct GroceryItem {
    
    let key: String
    let name: String
    let ref: DatabaseReference?
    var status: String
    let requester: String
    let accepter: String
    
    init(name: String, status: String, key: String = "") {
        self.key = key
        self.name = name
        self.status = status
        self.ref = nil
        self.requester = ""
        self.accepter = ""
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        ref = snapshot.ref
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        status = snapshotValue["status"] as! String
        requester = snapshotValue["requester"] as! String
        accepter = snapshotValue["accepter"] as! String
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "status": status
        ]
    }
    
}
