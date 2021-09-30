//
//  MessageViewModel.swift
//  ChatApp
//
//  Created by L on 2021/9/22.
//

import UIKit

struct MessageViewModel {
    
    private let message: Message
    
    var messageBackgroundColor: UIColor {
        return message.isCurrentUser ? .trueMessageBackgroundColor : .falseMessageTextColor
    }
    
    var messageTextColor: UIColor {
        return message.isCurrentUser ? .black : .white
    }
    
    var rightMessageActive: Bool {
        return message.isCurrentUser
    }
    
    var leftMessageActive: Bool {
        return !message.isCurrentUser
    }
    
    var hideProfileImage: Bool {
        return message.isCurrentUser
    }
    
    var profileImageUrl: URL? {
        guard let user = message.user else { return nil }
        return URL(string: user.profileImageUrl)
        
    }
    
    init(message: Message){
        self.message = message
    }
}
