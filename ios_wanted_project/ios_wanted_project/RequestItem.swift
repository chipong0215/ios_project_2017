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
    
    let key:String
    let name: String
    var status: String
    let price: String
    let region: String
    let detail: String
    
    let requester: String

    init(name: String, price: String, region: String, detail: String, status: String, requester: String) {
        
        self.ref = nil
        self.key = ""
        
        self.name = name
        self.status = status
        self.price = price
        self.region = region
        self.detail = detail
        
        self.requester = requester
    }
    
    init(snapshot: DataSnapshot) {
        ref = snapshot.ref
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        
        name = snapshotValue["title"] as! String
        status = snapshotValue["status"] as! String
        price = snapshotValue["price"] as! String
        region = snapshotValue["region"] as! String
        detail = snapshotValue["detail"] as! String
        
        requester = snapshotValue["requester"] as! String
    }
    
    func toAnyObject() -> Any {
        return [
            "title": name,
            "status": status,
            "price": price,
            "region": region,
            "detail": detail,
            "requester": requester
        ]
    }
    
}
