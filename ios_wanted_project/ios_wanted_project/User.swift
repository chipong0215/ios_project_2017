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
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }

}
