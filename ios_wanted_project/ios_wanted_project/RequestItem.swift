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
    
    enum RequestStatus {
        case open, accepted, complete
    }
    
    let key: String
    let name: String
    let ref: DatabaseReference?
    var status: String
    
    init(name: String, status: String, key: String = "") {
        self.key = key
        self.name = name
        self.status = status
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        status = snapshotValue["status"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "status": status
        ]
    }
    
}
