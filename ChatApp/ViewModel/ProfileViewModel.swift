//
//  ProfileViewModel.swift
//  ChatApp
//
//  Created by L on 2021/9/28.
//

import Foundation

enum ProfileViewModel: Int, CaseIterable {
    case accountInfo
    case settings
    
    var description: String {
        switch self {
        case .accountInfo:
            return "Account Info"
        case .settings:
            return "Settings"
        }
    }
    
    var iconImageName: String {
        switch self {
        case .accountInfo:
            return "person.circle"
        case .settings:
            return "gear"
        }
    }
}
