//
//  ProfileFooter.swift
//  ChatApp
//
//  Created by L on 2021/9/28.
//

import Foundation

import UIKit

protocol ProfileFooterDelegate: AnyObject {
    func handleSignout()
}

class ProfileFooter: UIView {
    
    // MARK: - Properties
    
    weak var delegate: ProfileFooterDelegate?
    
    private lazy var signoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Signout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(signout), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(signoutButton)
        signoutButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.centerY.equalToSuperview()
            make.height.equalTo(50)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Selectors
    
    @objc func signout() {
        delegate?.handleSignout()
    }
    
    // MARK: - Helpers
    
}
