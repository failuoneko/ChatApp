//
//  ProfileHeader.swift
//  ChatApp
//
//  Created by L on 2021/9/27.
//

import UIKit

protocol ProfileHeaderDelegate: AnyObject {
    func dismissController()
}

class ProfileHeader: UIView {
    
    // MARK: - Properties
    
    weak var delegate: ProfileHeaderDelegate?
    
    let gradient = CAGradientLayer()
    
    private let dismissButtom: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(dismissal), for: .touchUpInside)
        button.tintColor = .white
        button.imageView?.snp.makeConstraints({ make in
            make.size.equalTo(22)
        })
        return button
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 4.0
//        imageView.backgroundColor = .white
        return imageView
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.text = "Eddie Brock"
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = "@venom"
        return label
    }()
    
    
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Selectors
    
    @objc func dismissal() {
        delegate?.dismissController()
    }
    
    
    
    // MARK: - Helpers
    
    func configureUI() {

        configureGardientLayer()
        
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
        }
        profileImageView.layer.cornerRadius = 200 / 2
        
        let stack = UIStackView(arrangedSubviews: [fullnameLabel, usernameLabel])
        stack.axis = .vertical
        stack.spacing = 4
        
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
        }
        
        addSubview(dismissButtom)
        dismissButtom.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.left.equalToSuperview().offset(12)
            make.size.equalTo(50)
        }
    }
    
    func configureGardientLayer() {
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemRed.cgColor]
        gradient.locations = [0, 1]
        layer.addSublayer(gradient)
        //        gardient.frame = bounds
    }
    
}
