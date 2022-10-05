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
    var wordAddButton: UIButton!
    var customTabBarView = UIView(frame: .zero)
    var showRepeatWordsButton: UIButton!
    var showAllWordsButton: UIButton!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isHidden = true
        self.addCustomTabBarView()
        self.setViewControllers([repeatWords,centerView,allWords], animated: true)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
}


extension ViewController {
    
    
    private func addCustomTabBarView() {
        
        customTabBarView = UIView().then({ tabBarView in
            self.view.addSubview(tabBarView)
            
            tabBarView.frame = tabBar.frame
            tabBarView.backgroundColor = .purple
            tabBarView.layer.cornerRadius = 30
            tabBarView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            tabBarView.layer.masksToBounds = false
            tabBarView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
            tabBarView.layer.shadowOffset = CGSize(width: -4, height: -6)
            tabBarView.layer.shadowOpacity = 0.5
            tabBarView.layer.shadowRadius = 20
            tabBarView.snp.makeConstraints { make in
                make.height.equalTo(view.safeAreaInsets).offset(90)
                make.left.right.equalToSuperview()
                make.bottom.equalToSuperview()
            }
        })
        
        wordAddButton = UIButton(type: .custom).then({ button in
            customTabBarView.addSubview(button)
            button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
            let image = UIImage(systemName: "plus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 44, weight: .light))
            button.tintColor = .white
            button.setImage(image, for: .normal)
            
            button.addTarget(self, action: #selector(self.presentAddWord(sender:)) , for: .touchUpInside)
            
            button.snp.makeConstraints { make in
                make.top.equalTo(customTabBarView.snp.top).offset(-60)
                make.centerX.equalToSuperview()
                make.bottom.equalTo(view.safeAreaInsets).inset(10)
            }
        })
        
        showRepeatWordsButton = UIButton(type: .custom).then({ button in
            
            customTabBarView.addSubview(button)
            button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
            //            let image = UIImage(systemName: "plus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 44, weight: .light))
            button.tintColor = .white
            button.tag = 0
            //            button.setImage(image, for: .normal)
            button.setTitle("repeat", for: .normal)
            button.addTarget(self, action: #selector(changeScreen(sender:)) , for: .touchUpInside)
            
            button.snp.makeConstraints { make in
                make.top.equalTo(customTabBarView.snp.top)
                make.left.equalToSuperview().inset(25)
                make.bottom.equalTo(view.safeAreaInsets).inset(10)
            }
        })
        
        showAllWordsButton = UIButton(type: .custom).then({ button in
            customTabBarView.addSubview(button)
            button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
            
            //            let image = UIImage(systemName: "plus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 44, weight: .light))
            button.tintColor = .white
            button.tag = 2
            //            button.setImage(image, for: .normal)
            button.setTitle("show All", for: .normal)
            button.addTarget(self, action: #selector(changeScreen(sender:)) , for: .touchUpInside)
            
            button.snp.makeConstraints { make in
                make.top.equalTo(customTabBarView.snp.top)
                make.right.equalToSuperview().inset(25)
                make.bottom.equalTo(view.safeAreaInsets).inset(10)
            }
        })
        
        
        
    }
    
    
    @objc func presentAddWord(sender: UIButton) {
        //        self.selectedIndex = 1
        print("touched")
        //
        let addWordVC = AddWordVC()
        addWordVC.modalPresentationStyle = .overFullScreen
        self.present(addWordVC, animated: false)
        //        self.selectedIndex = 0
    }
    
    @objc func changeScreen(sender: UIButton) {
        
        switch sender.tag {
        case 0 : self.selectedIndex = 0
        case 2 : self.selectedIndex = 2
        default:
            print("nam vsem pizda knopki na custom uiTabBar")
        }
        
    }
    
}

extension ViewController: UITabBarControllerDelegate {
    
    
}
