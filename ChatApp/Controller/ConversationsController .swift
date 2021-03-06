//
//  ConversationsController .swift
//  ChatApp
//
//  Created by L on 2021/8/18.
//

import UIKit
import SnapKit
import Firebase

class ConversationsController: UIViewController {
    
    // MARK: - Properties
    private let tableView = UITableView()
    private var conversations: [Conversation] = []
    private var conversationsDictionary: [String: Conversation] = [:]
    
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
        fetchConversations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar(withTitle: "Messages", prefersLargeTitles: true)
    }
    
    // MARK: - Selectors
    
    @objc func showProfile() {
        let controller = ProfileController(style: .insetGrouped)
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
        
    }
    
    @objc func showNewMessage() {
        let controller = NewMessageController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
        
    }
    
    // MARK: - API
    
    func fetchConversations() {
        showLoader(true)
        Service.fetchConversations { conversations in
            conversations.forEach { conversation in
                let message = conversation.message
                self.conversationsDictionary[message.chatPartnerId] = conversation
            }
            self.showLoader(false)
            self.conversations = Array(self.conversationsDictionary.values)
            self.tableView.reloadData()
        }
    }
    
    //??????????????????
    func authUser() {
        if Auth.auth().currentUser?.uid == nil {
            presentLoginScreen()
        }
    }
    
    func signOut() {
        do {
            //???????????????????????????
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
            controller.delegate = self
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    func configureUI() {
        
        view.backgroundColor = .white
        
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
        tableView.backgroundColor = .white
        tableView.rowHeight = 80
        tableView.register(ConversationCell.self, forCellReuseIdentifier: ConversationCell.id)
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
    
    func showChatControlloer(forUser user: User) {
        let controller = ChatController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }

}

// MARK: - tableViewDatasource

extension ConversationsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConversationCell.id, for: indexPath) as! ConversationCell
        cell.conversation = conversations[indexPath.row]
        return cell
    }
}

// MARK: - tableViewDelegate

extension ConversationsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = conversations[indexPath.row].user
        showChatControlloer(forUser: user)
    }
}


// MARK: - NewMessageControllerDelegate

//?????????????????????user???????????????????????????
extension ConversationsController: NewMessageControllerDelegate {
    func controller(_ controller: NewMessageController, startChatWith user: User) {
        dismiss(animated: true, completion: nil)
        showChatControlloer(forUser: user)
    }
}

// MARK: - ProfileControllerDelegate

extension ConversationsController: ProfileControllerDelegate {
    func handleSignout() {
        signOut()
    }
}

// MARK: - AuthDelegate

extension ConversationsController: AuthDelegate {
    func authComplete() {
        dismiss(animated: true, completion: nil)
        configureUI()
        fetchConversations()
    }
}
