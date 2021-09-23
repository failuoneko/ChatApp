//
//  MessageCell.swift
//  ChatApp
//
//  Created by L on 2021/9/22.
//

import UIKit

class MessageCell: UICollectionViewCell {

    // MARK: - Properties
    
    var message: Message? {
        didSet { configureChatBox() }
    }
    
    var leftMessageBubble: NSLayoutConstraint!
    var rightMessageBubble: NSLayoutConstraint!
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private let chatTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = .systemFont(ofSize: 16)
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.textColor = .white
        return textView
    }()
    
    private let messageBubble: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple
        return view
    }()

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(10)
            make.bottom.equalTo(self.snp.bottom)
            make.size.equalTo(40)
            profileImageView.layer.cornerRadius = 40 / 2
        }
        
        addSubview(messageBubble)
        messageBubble.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
//            make.left.equalTo(profileImageView.snp.right).offset(12)
            make.width.lessThanOrEqualTo(250)
            messageBubble.layer.cornerRadius = 12
        }
        
        leftMessageBubble = messageBubble.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 10)
        leftMessageBubble.isActive = false
        
        rightMessageBubble = messageBubble.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
        rightMessageBubble.isActive = false
        
        
        messageBubble.addSubview(chatTextView)
        chatTextView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 4, left: 12, bottom: 4, right: 12))
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureChatBox() {
        guard let message = message else { return }
        let viewModel = MessageViewModel(message: message)

        messageBubble.backgroundColor = viewModel.messageBackgroundColor
        chatTextView.textColor = viewModel.messageTextColor
        chatTextView.text = message.text
        
        leftMessageBubble.isActive = viewModel.leftMessageActive
        rightMessageBubble.isActive = viewModel.rightMessageActive
        
        profileImageView.isHidden = viewModel.hideProfileImage
    }

}
