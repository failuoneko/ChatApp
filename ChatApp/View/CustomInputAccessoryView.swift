//
//  CustomInputAccessoryView.swift
//  ChatApp
//
//  Created by L on 2021/9/18.
//

import UIKit

class CustomInputAccessoryView: UIView {
    
    // MARK: - Properties
    
    private let messageInputTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isScrollEnabled = false
        return textView
    }()

    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        
        //自動調整高度
        autoresizingMask = .flexibleHeight
        
        addSubview(sendButton)
        sendButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(4)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        addSubview(messageInputTextView)
        messageInputTextView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.left.equalTo(self.snp.left).offset(20)
            make.right.equalTo(sendButton.snp.left).offset(-6)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-10)
            
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    // MARK: - Selectors

    @objc func sendMessage() {
        print("DEBUG:send message")
    }
    
}



