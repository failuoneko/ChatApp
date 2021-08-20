//
//  RegisterViewModel.swift
//  ChatApp
//
//  Created by L on 2021/8/19.
//

import Foundation

struct RegisterViewModel: AuthProtocol {
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    
    var fromIsVaild: Bool {
        return email?.isEmpty == false &&
            password?.isEmpty == false &&
            fullname?.isEmpty == false &&
            username?.isEmpty == false
    }
}
