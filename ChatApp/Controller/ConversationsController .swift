//
//  ConversationsController .swift
//  ChatApp
//
//  Created by L on 2021/8/18.
//

import UIKit
import SnapKit

class ConversationsController: UIViewController {
    
    // MARK: - Properties
    private let tableView = UITableView()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    // MARK: - Selectors
    @objc func showProfile() {
        print(123)
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        
        view.backgroundColor = .white
        
        configureNavigationBar()
        configureTableView()
        
        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
    }
    
    func configureTableView() {
        tableView.backgroundColor = .systemPink
        tableView.rowHeight = 80
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
    
    
    func configureNavigationBar() {
        let barAppearance = UINavigationBarAppearance()
        barAppearance.configureWithOpaqueBackground()

//        //大標題屬性
        barAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        barAppearance.backgroundColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = barAppearance //向上捲動時的bar樣式
        navigationController?.navigationBar.compactAppearance = barAppearance //橫向時的bar樣式
        navigationController?.navigationBar.scrollEdgeAppearance = barAppearance //一開始的bar樣式(大標題)

        //大標題
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Messages"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = true //是否為半透明

        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark

    }
}

extension ConversationsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Test"
        return cell
    }
}

extension ConversationsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
