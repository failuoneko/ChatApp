//
//  NewMessageController.swift
//  ChatApp
//
//  Created by L on 2021/8/23.
//

import UIKit

protocol NewMessageControllerDelegate: AnyObject {
    func controller(_ controller: NewMessageController, startChatWith user: User)
}

class NewMessageController: UITableViewController {
    
    // MARK: - Properties
    
    private var users: [User] = []
    private var filterUsers: [User] = []
    weak var delegate: NewMessageControllerDelegate?
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var isSeachMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureSearchController()
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
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.id)
        tableView.rowHeight = 80
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.showsCancelButton = false
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false // 是否模糊
        searchController.hidesNavigationBarDuringPresentation = false // 是否隱藏導航欄
        searchController.searchBar.placeholder = "Search for a user"
        definesPresentationContext = false // 是否跟隨view滑動
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = .systemPurple
            textField.backgroundColor = .white
        }
    }
    
}

// MARK: - UITableViewDataSource

extension NewMessageController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSeachMode ? filterUsers.count : users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.id, for: indexPath) as! UserCell
        cell.user = isSeachMode ? filterUsers[indexPath.row] : users[indexPath.row]
        
//        print("DEBUG: Index row is \(indexPath.row)")
//        print("DEBUG: User in array is \(users[indexPath.row].username)")
        
        return cell
    }
}

// 選擇使用者後關閉視窗，並前往聊天室。
// 點選使用者後把user傳給ConversationsController。
extension NewMessageController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = isSeachMode ? filterUsers[indexPath.row] : users[indexPath.row]
        delegate?.controller(self, startChatWith: user)
    }
}


// MARK: - UISearchResultsUpdating

// 更新搜尋結果
extension NewMessageController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        
        filterUsers = users.filter({ user in
            return user.fullname.contains(searchText) || user.username.contains(searchText)
        })
        self.tableView.reloadData()
    }
}
