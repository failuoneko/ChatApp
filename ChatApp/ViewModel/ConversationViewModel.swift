//
//  ConversationViewModel.swift
//  ChatApp
//
//  Created by L on 2021/9/27.
//

import Foundation

class ConversationViewModel {
    
    private let conversation: Conversation
    
    var profileImageUrl: URL? {
        return URL(string: conversation.user.profileImageUrl)
    }
    
    var timestamp: String {
        let data = conversation.message.timestamp.dateValue()
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "hh:mm a"
        return dataFormatter.string(from: data)
    }
    
    init(conversation: Conversation) {
        self.conversation = conversation
    }
    
}
