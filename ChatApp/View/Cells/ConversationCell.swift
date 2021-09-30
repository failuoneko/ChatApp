//
//  ConversationCell.swift
//  ChatApp
//
//  Created by L on 2021/9/26.
//

import UIKit

class ConversationCell: UITableViewCell {
    
    // MARK: - Properties
    
    var conversation: Conversation? {
        didSet { configure() }
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    let timestampLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        label.text = "1h"
        return label
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let messageTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.size.equalTo(50)
            make.centerY.equalToSuperview()
            profileImageView.layer.cornerRadius = 50 / 2
        }
        
        let stack = UIStackView(arrangedSubviews: [usernameLabel,messageTextLabel])
        stack.axis = .vertical
        stack.spacing = 5
        
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.left.equalTo(profileImageView.snp.right).offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        
        addSubview(timestampLabel)
        timestampLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-12)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let conversation = conversation else { return }
        let viewModel = ConversationViewModel(conversation: conversation)
        
        usernameLabel.text = conversation.user.username
        messageTextLabel.text = conversation.message.text
        
        timestampLabel.text = viewModel.timestamp
        profileImageView.kf.setImage(with: viewModel.profileImageUrl)
    }
}
