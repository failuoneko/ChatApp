//
//  ConversationsController .swift
//  ChatApp
//
//  Created by L on 2021/8/18.
//

import UIKit
import SnapKit
import Firebase

private let reuseIdentifier = "UserCell"

class ConversationsController: UIViewController {
    
    // MARK: - Properties
    private let tableView = UITableView()
    
    private let newMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.addTarget(self, action: #selector(showNewMessage), for: .touchUpInside)
        button.imageView?.snp.makeConstraints { make in
            make.width.height.equalTo(25)
        }
        return button
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        authUser()
    }
    
    
    // MARK: - Selectors
    @objc func showProfile() {
        signOut()
        print(123)
    }
    
    @objc func showNewMessage() {
        let controller = NewMessageController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
        
    }
    
    // MARK: - API
    
    //維持登入狀態
    func authUser() {
        if Auth.auth().currentUser?.uid == nil {
            presentLoginScreen()
            print("DEBUG: User is not logged in. Prensent login screen here..")
        } else {
            print("DEBUG: User id is \(String(describing: Auth.auth().currentUser?.uid))")
        }
    }
    
    func signOut() {
        do {
            //登出後顯示登入畫面
            presentLoginScreen()
            try Auth.auth().signOut()
        } catch {
            print("DEBUG: Error signing out..")
        }
    }
    
    // MARK: - Helpers
    
    func presentLoginScreen() {
        DispatchQueue.main.async {
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    func configureUI() {
        
        view.backgroundColor = .white
        
        configureNavigationBar(withTitle: "Messages", prefersLargeTitles: true)
        configureTableView()
        
        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
        
        view.addSubview(newMessageButton)
        newMessageButton.layer.cornerRadius = 60 / 2
        newMessageButton.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-30)
        }
    }
    
    func configureTableView() {
        tableView.backgroundColor = .systemPink
        tableView.rowHeight = 80
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.frame = view.frame
    }

}

extension ConversationsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = "Test"
        return cell
    }
}

extension ConversationsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}


// MARK: - NewMessageControllerDelegate

//關閉視窗，接收user參數，前往聊天室。
extension ConversationsController: NewMessageControllerDelegate {
    func controller(_ controller: NewMessageController, startChatWith user: User) {
        controller.dismiss(animated: true, completion: nil)
        let chat = ChatController(user: user)
        navigationController?.pushViewController(chat, animated: true)
//        print("DEBUG: User in convesation controller is \(user.username)")

    }
}
