//
//  LoginController.swift
//  ChatApp
//
//  Created by L on 2021/8/18.
//

import UIKit
import Firebase
import JGProgressHUD

protocol AuthControllerProtocol {
    func checkFromStatus()
}

class LoginController: UIViewController {
    
    // MARK: - Properties
    
    private var loginViewModel = LoginViewModel()
    
    private let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bubble.right")
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var emailContainerView: inputContainerView = {
        let containerView = inputContainerView(image: UIImage(systemName: "envelope"), textField: emailTextField)
        return containerView
    }()
    
    private lazy var passwordContainerView: inputContainerView = {
        let containerView = inputContainerView(image: UIImage(systemName: "lock"), textField: passwordTextField)
        return containerView
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .falseLoginButtonColor
        button.isEnabled = false
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        return button
    }()
    
    private let emailTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Email")
        return textField
    }()
    
    private let passwordTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedtitle = NSAttributedString(string: "Dont't have a account? ",
                                                 attributes: [.foregroundColor: UIColor.white,
                                                              .font: UIFont.systemFont(ofSize: 20)])
        let whiteAttributedtitle = NSAttributedString(string: "Sign Up",
                                                      attributes: [.foregroundColor: UIColor.white,
                                                                   .font: UIFont.boldSystemFont(ofSize: 20)])
        let attributedText = NSMutableAttributedString()
        attributedText.append(attributedtitle)
        attributedText.append(whiteAttributedtitle)
        button.setAttributedTitle(attributedText, for: .normal)
        button.addTarget(self, action: #selector(showSignUp), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    // MARK: - Selectors
    
    @objc func login() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
//        let hud = JGProgressHUD(style: .dark)
//        hud.textLabel.text = "Logging in"
//        hud.show(in: view)
        showLoader(true, withText: "Logging in")
        
        Authservice.shared.Userlogin(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to login with error \(error.localizedDescription)")
                self.showLoader(false)
                return
            }
            self.showLoader(false)
            // 關閉，並顯示用戶介面。
            self.dismiss(animated: true, completion: nil)
        }
        

        print("login")
    }
    
    @objc func showSignUp() {
        let controller = RegisterController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func textDidChanged(sender: UITextField) {
        if sender == emailTextField {
            loginViewModel.email = sender.text
        } else {
            loginViewModel.password = sender.text
        }
        checkFromStatus()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        configureGradientLayer()
        
        view.addSubview(iconImage)
        iconImage.snp.makeConstraints { make in
            make.size.equalTo(120)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.centerX.equalToSuperview()
        }
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   passwordContainerView,
                                                   loginButton])
        stack.axis = .vertical
        stack.spacing = 16
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalTo(iconImage.snp.bottom).offset(30)
            make.leading.equalTo(view).offset(30)
            make.trailing.equalTo(view).offset(-30)
        }
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.leading.equalTo(view).offset(30)
            make.trailing.equalTo(view).offset(-30)
        }
        
        configureLoginObservers()
    }
    
    func configureLoginObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChanged), for: .editingChanged)
    }
    
}

extension LoginController: AuthControllerProtocol {
    
    func checkFromStatus() {
        if loginViewModel.fromIsVaild {
            loginButton.isEnabled = true
            loginButton.backgroundColor = .loginButtonColor
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = .falseLoginButtonColor
        }
    }
    
}
