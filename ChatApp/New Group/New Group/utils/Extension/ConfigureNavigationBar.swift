//
//  test.swift
//  ChatApp
//
//  Created by L on 2021/8/23.
//

import UIKit

extension UIViewController {
    
    func configureNavigationBar(withTitle title: String, prefersLargeTitles: Bool) {
        let barAppearance = UINavigationBarAppearance()
        barAppearance.configureWithOpaqueBackground()
        
        //大標題屬性
        barAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        barAppearance.backgroundColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = barAppearance //向上捲動時的bar樣式
        navigationController?.navigationBar.compactAppearance = barAppearance //橫向時的bar樣式
        navigationController?.navigationBar.scrollEdgeAppearance = barAppearance //一開始的bar樣式(大標題)
        
        //大標題
        navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
        navigationItem.title = title
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = true //是否為半透明
        
        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
    }
    
}
