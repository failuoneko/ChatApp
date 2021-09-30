//
//  ProfileCell.swift
//  ChatApp
//
//  Created by L on 2021/9/28.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    // MARK: - Properties
    
    var viewModel: ProfileViewModel? {
        didSet { configure() }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints { $0.size.equalTo(30) }
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var iconView: UIView = {
        let view = UIView()
        
        view.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { $0.center.equalToSuperview() }
        
        view.backgroundColor = .systemPurple
        view.snp.makeConstraints { $0.size.equalTo(40) }
        view.layer.cornerRadius = 40 / 2
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stack = UIStackView(arrangedSubviews: [iconView, titleLabel])
        stack.spacing = 10
        stack.axis = .horizontal
        
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let viewModel = viewModel else { return }
        
        iconImageView.image = UIImage(systemName: viewModel.iconImageName)
        titleLabel.text = viewModel.description
    }
}

