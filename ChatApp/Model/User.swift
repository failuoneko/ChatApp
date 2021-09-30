//
//  User.swift
//  ChatApp
//
//  Created by L on 2021/8/23.
//

import Foundation

struct User {
    let uid: String
    let profileImageUrl: String
    let email: String
    let fullname: String
    let username: String
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
    }
}
