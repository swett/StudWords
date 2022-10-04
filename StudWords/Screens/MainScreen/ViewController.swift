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
    let centerView = UIViewController()
    var button: UIButton!
//    var customTabBarView = UIView(frame: .zero)
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        button.frame = CGRect.init(x: self.tabBar.center.x - 32, y: self.view.bounds.height - 74, width: 64, height: 64)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.selectedItem?.badgeColor = .white
        self.tabBar.unselectedItemTintColor = .gray
        tabBar.clipsToBounds = false
//        tabBar.isHidden = true
        self.delegate = self
        setupMiddleButton()
        tabBar.backgroundColor = .black
        allWords.title = "All Words"
        repeatWords.title = "Repeat Words"
        self.setViewControllers([repeatWords,centerView,allWords], animated: true)
        
        
    }
    

}


extension ViewController {
    func setupMiddleButton() {
        let paddingBottom : CGFloat = 10.0
        button = UIButton(type: .custom).then({ button in
            
            button.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
            button.frame.origin.x = tabBar.bounds.width/2 - button.frame.size.width/2
//            button.frame.origin.y = -20
//            button.layer.cornerRadius = 35
//            button.backgroundColor = .purple
            let image = UIImage(systemName: "plus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 64, weight: .semibold))
            button.tintColor = .white
            button.setImage(image, for: .normal)
//            button.contentMode = .scaleAspectFill
            button.addTarget(self, action: #selector(self.presentAddWord(sender:)) , for: .touchUpInside)
            
            
//            self.tabBar.addSubview(button)
            self.view.insertSubview(button, aboveSubview: self.tabBar)
//            self.view.bringSubviewToFront(button)
            
            button.snp.makeConstraints { make in
                make.top.equalTo(tabBar.snp.top).offset(-40)
                make.centerX.equalToSuperview()
                make.bottom.equalTo(view.safeAreaInsets).inset(10)
            }
            
            self.view.layoutIfNeeded()
        })
//        tabBar.center = UIWindow.safeAreaInsets.bottom
        
    }
    
    @objc func presentAddWord(sender: UIButton) {
        self.selectedIndex = 1
        print("touched")
//
        let addWordVC = AddWordVC()
        addWordVC.modalPresentationStyle = .overFullScreen
        self.present(addWordVC, animated: true)
        self.selectedIndex = 0
    }
    
}

extension ViewController: UITabBarControllerDelegate {
    
    
}
