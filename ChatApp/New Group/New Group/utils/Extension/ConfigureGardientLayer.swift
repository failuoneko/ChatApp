//
//  ConfigureGardientLayer.swift
//  ChatApp
//
//  Created by L on 2021/8/19.
//

import UIKit

extension UIViewController {
    
    func configureGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemRed.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
    
}
