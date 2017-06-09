//
//  RequestItem.swift
//  ios_wanted_project
//
//  Created by Llewellyn Cheung on 8/6/2017.
//  Copyright © 2017 Pong. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

struct RequestItem {
    
    let ref: DatabaseReference?
    let key: String
    
    let name: String
    var status: String
    let price: String
    let region: String
    let detail: String

    init(key: String,
         name: String,
         price: String,
         region: String,
         detail: String,
         status: String) {
        
        self.ref = nil
        self.key = key
        
        self.name = name
        self.status = status
        self.price = price
        self.region = region
        self.detail = detail
    }
    
    init(snapshot: DataSnapshot) {
        ref = snapshot.ref
        let snapshotValue = snapshot.value as! [String: AnyObject]
        key = snapshotValue["key"] as! String
        
        name = snapshotValue["title"] as! String
        status = snapshotValue["status"] as! String
        price = snapshotValue["price"] as! String
        region = snapshotValue["region"] as! String
        detail = snapshotValue["detail"] as! String
    }
    
    func toAnyObject() -> Any {
        return [
            "title": name,
            "status": status,
            "price": price,
            "region": region,
            "detail": detail,
            "key": key
        ]
    }
    
}
