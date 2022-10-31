//
//  NavigationVC.swift
//  StudWords
//
//  Created by Vitaliy Griza on 28.09.2022.
//

import UIKit

class NavigationVC: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .mainBgColor
        appearance.titleTextAttributes = [
            .font: UIFont.boldSystemFont(ofSize: 20.0),
            .foregroundColor: UIColor.mainDetailsColor
        ]
        navigationBar.tintColor = .mainDetailsColor
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}

//extension NavigationVC {
//    func setColorBackground(_ color: UIColor) {
//        self.navigationBar.backgroundColor = color
//    }
//}
