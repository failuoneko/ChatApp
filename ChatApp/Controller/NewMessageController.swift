//
//  NewMessageController.swift
//  ChatApp
//
//  Created by L on 2021/8/23.
//

import UIKit

// CELL ID
private let reuseIdentifier = "UserCell"

protocol NewMessageControllerDelegate: AnyObject {
    func controller(_ controller: NewMessageController, startChatWith user: User)
}

class NewMessageController: UITableViewController {
    
    // MARK: - Properties
    
    private var users: [User] = []
    weak var delegate: NewMessageControllerDelegate?

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchUsers()
        
    }
    
    // MARK: - Selectors
    
    @objc func dismissal() {
        dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: - API
    
    //訪問用戶資料
    func fetchUsers() {
        Service.fetchUsers { users in
            self.users = users
            self.tableView.reloadData()
            print("DEBUG: Users is new message controller \(users)")
        }
    }

    
    
    // MARK: - Helpers

    func configureUI() {
        configureNavigationBar(withTitle: "New message", prefersLargeTitles: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissal))
        
        tableView.tableFooterView = UIView()
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 80
    }
    
}

// MARK: - UITableViewDataSource

extension NewMessageController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        cell.user = users[indexPath.row]
        
//        print("DEBUG: Index row is \(indexPath.row)")
//        print("DEBUG: User in array is \(users[indexPath.row].username)")
        
        return cell
    }
}


// 選擇使用者後關閉視窗，並前往聊天室。
// 點選使用者後把user傳給ConversationsController。
extension NewMessageController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate?.controller(self, startChatWith: users[indexPath.row])

    }
    
}
