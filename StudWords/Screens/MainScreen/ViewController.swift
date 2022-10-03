//
//  ViewController.swift
//  StudWords
//
//  Created by Vitaliy Griza on 28.09.2022.
//

import UIKit

class ViewController: UITabBarController {
    
    let allWords = MainViewVC(viewModel: MainViewModel(storage: AppData.shared))
    let repeatWords = RepeatWordsVC()
    var button: UIButton!
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        button.frame = CGRect.init(x: self.tabBar.center.x - 32, y: self.view.bounds.height - 74, width: 64, height: 64)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.selectedItem?.badgeColor = .white
        tabBar.unselectedItemTintColor = .gray
       
        setupMiddleButton()
        
        allWords.title = "All Words"
        repeatWords.title = "Repeat Words"
        self.setViewControllers([repeatWords,allWords], animated: true)
        
        
    }


}


extension ViewController {
    func setupMiddleButton() {
        button = UIButton(type: .custom).then({ button in
            self.tabBar.addSubview(button)
            button.frame = CGRect(x: (self.view.bounds.width / 2)-15, y: -20, width: 50, height: 50)
            button.layer.cornerRadius = 50
            button.backgroundColor = .white
            let image = UIImage(systemName: "plus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 45, weight: .semibold))
            button.tintColor = .black
            button.setImage(image, for: .normal)
            button.contentMode = .scaleAspectFill
        })
        
    }
}
