//
//  inputContainerView.swift
//  ChatApp
//
//  Created by L on 2021/8/18.
//

import UIKit

class inputContainerView: UIView {
    
    init(image: UIImage?, textField: UITextField){
        super.init(frame: .zero)
        
        snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        let imageView = UIImageView()
        imageView.image = image
        imageView.tintColor = .white
        imageView.alpha = 0.8
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(25)
            make.width.equalTo(30)
        }
        
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(imageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalTo(0)
        }
        
        let underline = UIView()
        underline.backgroundColor = .white
        addSubview(underline)
        underline.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(0.8)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
