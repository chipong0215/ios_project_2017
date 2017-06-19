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

struct Category {
    let name: String
    let requests: [RequestItem]
}

struct RequestItem {
    
    let ref: DatabaseReference?
    
    let key:String
    let name: String
    var status: String
    let time: String
    let price: String
    let region: String
    let detail: String
    var category: String
    
    
    
    let requester: String
    let accepter: String

    init(name: String, price: String, region: String, time: String, detail: String, status: String, requester: String, accepter: String, category: String = "") {
        
        self.ref = nil
        self.key = ""
        
        self.name = name
        self.status = status
        self.price = price
        self.region = region
        self.detail = detail
        self.time = time
        
        self.requester = requester
        self.accepter = accepter
        self.category = category
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
        time = snapshotValue["time"] as! String
        requester = snapshotValue["requester"] as! String
        accepter = snapshotValue["accepter"] as! String
        category = ""
    }
    
    func toAnyObject() -> Any {
        return [
            "title": name,
            "status": status,
            "price": price,
            "region": region,
            "detail": detail,
            "requester": requester,
            "accepter": accepter,
            "time": time
        ]
    }
    
}
