//
//  RegisterController.swift
//  ChatApp
//
//  Created by L on 2021/8/18.
//

import UIKit

class RegisterController: UIViewController {
    
    // MARK: - Properties
    
    private let plusPhotoButtonSize = 200
    
    private var registerViewModel = RegisterViewModel()
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        //        let largeConfig = UIImage.SymbolConfiguration(pointSize: 140, weight: .bold, scale: .large)
        //        let largeBoldDoc = UIImage(systemName: "person.crop.circle.badge.plus", withConfiguration: largeConfig)
        //        button.setImage(largeBoldDoc, for: .normal)
        button.setBackgroundImage(UIImage(systemName: "person.crop.circle.badge.plus"), for: .normal)
        button.tintColor = .white
        //        button.imageView?.clipsToBounds = true
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(selectPhoto), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailContainerView: inputContainerView = {
        let containerView = inputContainerView(image: UIImage(systemName: "envelope"), textField: emailTextField)
        return containerView
    }()
    
    private lazy var fullnameContainerView: inputContainerView = {
        let containerView = inputContainerView(image: UIImage(systemName: "envelope"), textField: fullnameTextField)
        return containerView
    }()
    
    private lazy var usernameContainerView: inputContainerView = {
        let containerView = inputContainerView(image: UIImage(systemName: "envelope"), textField: usernameTextField)
        return containerView
    }()
    
    private lazy var passwordContainerView: inputContainerView = {
        let containerView = inputContainerView(image: UIImage(systemName: "lock"), textField: passwordTextField)
        return containerView
    }()
    
    private let emailTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Email")
        return textField
    }()
    
    private let fullnameTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Full Name")
        return textField
    }()
    
    private let usernameTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Username")
        return textField
    }()
    
    private let passwordTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .falseLoginButtonColor
        button.isEnabled = false
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        return button
    }()
    
    private let alreadyAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedtitle = NSAttributedString(string: "Already have a account? ",
                                                 attributes: [.foregroundColor: UIColor.white,
                                                              .font: UIFont.systemFont(ofSize: 20)])
        let whiteAttributedtitle = NSAttributedString(string: "Log In",
                                                      attributes: [.foregroundColor: UIColor.white,
                                                                   .font: UIFont.boldSystemFont(ofSize: 20)])
        let attributedText = NSMutableAttributedString()
        attributedText.append(attributedtitle)
        attributedText.append(whiteAttributedtitle)
        button.setAttributedTitle(attributedText, for: .normal)
        button.addTarget(self, action: #selector(showLogIn), for: .touchUpInside)
        
        return button
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    // MARK: - Selectors
    @objc func selectPhoto() {
        
        let imagePickerController = UIImagePickerController()
        present(imagePickerController, animated: true, completion: nil)
        imagePickerController.delegate = self
        
    }
    
    @objc func showLogIn() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    
    @objc func textDidChanged(sender: UITextField) {
        if sender == emailTextField {
            registerViewModel.email = sender.text
        } else if sender == passwordTextField {
            registerViewModel.password = sender.text
        } else if sender == fullnameTextField {
            registerViewModel.fullname = sender.text
        } else if sender == usernameTextField {
            registerViewModel.username = sender.text
        }
        checkFromStatus()
    }
    
    
    func configureUI() {
        
        configureGardientLayer()
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.snp.makeConstraints { make in
            make.size.equalTo(plusPhotoButtonSize)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.centerX.equalToSuperview()
        }
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   passwordContainerView,
                                                   fullnameContainerView,
                                                   usernameContainerView,
                                                   signUpButton])
        stack.axis = .vertical
        stack.spacing = 20
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalTo(plusPhotoButton.snp.bottom).offset(30)
            make.leading.equalTo(view).offset(30)
            make.trailing.equalTo(view).offset(-30)
        }
        
        view.addSubview(alreadyAccountButton)
        alreadyAccountButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.leading.equalTo(view).offset(30)
            make.trailing.equalTo(view).offset(-30)
        }
        configureRegisterObservers()
    }
    
    func configureRegisterObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChanged), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChanged), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChanged), for: .editingChanged)
    }
}

// MARK: - UIImagePickerControllerDelegate

extension RegisterController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        //        plusPhotoButton.setImage(image, for: .normal)
        plusPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3
        plusPhotoButton.layer.cornerRadius = CGFloat(plusPhotoButtonSize / 2)
        
        dismiss(animated: true, completion: nil)
    }
    
}

extension RegisterController: AuthControllerProtocol {
    
    func checkFromStatus() {
        if registerViewModel.fromIsVaild {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = .loginButtonColor
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = .falseLoginButtonColor
        }
    }
    
}
