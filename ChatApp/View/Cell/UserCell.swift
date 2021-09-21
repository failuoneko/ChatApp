//
//  UserCell.swift
//  ChatApp
//
//  Created by L on 2021/8/23.
//

import UIKit
import SDWebImage
import Kingfisher

class UserCell: UITableViewCell {
    
    // MARK: - Properties
    
    //進到該cell後呼叫資料
    var user: User? {
        didSet{
            configure()
        }
    }

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemRed
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "BIG CAT"
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = "small cat"
        return label
    }()
        
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.layer.cornerRadius = 60 / 2
        profileImageView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.width.height.equalTo(60)
            make.centerY.equalToSuperview()
        }
        
        let stack = UIStackView(arrangedSubviews: [fullnameLabel, usernameLabel])
        stack.axis = .vertical
        stack.spacing = 2
        
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.left.equalTo(profileImageView.snp.right).offset(12)
        }
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helpers

    func configure() {
        guard let user = user else { return }
        fullnameLabel.text = user.fullname
        usernameLabel.text = user.username
        
        guard let url = URL(string: user.profileImageUrl) else { return }
//        profileImageView.sd_setImage(with: url)
        profileImageView.kf.setImage(with: url)
    }
    
}

