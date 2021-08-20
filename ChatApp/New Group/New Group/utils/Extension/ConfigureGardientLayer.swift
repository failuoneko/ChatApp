//
//  ConfigureGardientLayer.swift
//  ChatApp
//
//  Created by L on 2021/8/19.
//

import UIKit

extension UIViewController {
    
    func configureGardientLayer() {
        let gardient = CAGradientLayer()
        gardient.colors = [UIColor.systemPurple.cgColor, UIColor.systemRed.cgColor]
        gardient.locations = [0, 1]
        view.layer.addSublayer(gardient)
        gardient.frame = view.frame
    }
    
}
