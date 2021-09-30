//
//  showError.swift
//  ChatApp
//
//  Created by L on 2021/9/29.
//

import UIKit

extension UIViewController {
    
    func showError(_ errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}
