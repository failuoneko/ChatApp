//
//  LoginViewModel.swift
//  ChatApp
//
//  Created by L on 2021/8/19.
//

import Foundation

protocol AuthProtocol {
    var fromIsVaild: Bool { get }
}

struct LoginViewModel: AuthProtocol {
    var email: String?
    var password: String?
    
    var fromIsVaild: Bool {
        return email?.isEmpty == false &&
            password?.isEmpty == false
    }
}
