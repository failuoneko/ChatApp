//
//  ReuseCell.swift
//  ChatApp
//
//  Created by L on 2021/8/18.
//

import UIKit

extension UITableViewCell {
    static var id: String {
        return "\(Self.self)"
    }
    
}

extension UICollectionViewCell {
    static var id: String {
        return "\(Self.self)"
    }
}

extension UITableViewController {
    static var id: String {
        return "\(Self.self)"
    }
}
