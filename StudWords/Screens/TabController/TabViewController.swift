//
//  ViewController.swift
//  StudWords
//
//  Created by Vitaliy Griza on 28.09.2022.
//

import UIKit

class TabViewController: UITabBarController {
    
    var wordAddButton: UIButton!
    var customTabBarView = UIView(frame: .zero)
    var showRepeatWordsButton: UIButton!
    var showAllWordsButton: UIButton!
    
    private let coordinator: CoordinatorProtocol
    
    //MARK: - Lifecycle
    init(coordinator: CoordinatorProtocol) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isHidden = true
        self.addCustomTabBarView()
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
}


extension TabViewController {
    
    
    private func addCustomTabBarView() {
        
        customTabBarView = UIView().then({ tabBarView in
            self.view.addSubview(tabBarView)
            
            tabBarView.frame = tabBar.frame
            tabBarView.backgroundColor = .mainDescriptionColor
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
            button.tintColor = .mainDetailsColor
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
//            button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
                        let image = UIImage(systemName: "goforward", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .light))
            button.tintColor = .mainDetailsColor
            button.setTitleColor(.mainDetailsColor, for: .normal)
            button.tag = 0
            button.setImage(image, for: .normal)
            button.setTitle("repeat", for: .normal)
            button.alignVertical()
            button.addTarget(self, action: #selector(changeScreen(sender:)) , for: .touchUpInside)
            
            button.snp.makeConstraints { make in
                make.top.equalTo(customTabBarView.snp.top).offset(10)
                make.left.equalToSuperview().inset(25)
                make.height.width.equalTo(60)
//                make.bottom.equalTo(view.safeAreaInsets).inset(10)
            }
        })
        
        showAllWordsButton = UIButton(type: .custom).then({ button in
            customTabBarView.addSubview(button)
            let image = UIImage(systemName: "book.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .light))
            button.tintColor = .mainDetailsColor
            button.setTitleColor(.mainDetailsColor, for: .normal)
            button.tag = 2
            button.setImage(image, for: .normal)
            button.setTitle("show All", for: .normal)
            button.alignVertical()
            button.addTarget(self, action: #selector(changeScreen(sender:)) , for: .touchUpInside)
            
            button.snp.makeConstraints { make in
                make.top.equalTo(customTabBarView.snp.top).offset(10)
                make.right.equalToSuperview().inset(25)
                make.height.equalTo(60)
                make.width.equalTo(80)
            }
        })
        
        
        
    }
    
    
    @objc func presentAddWord(sender: UIButton) {
        
        UIView.animate(withDuration: 0.15) {
            self.wordAddButton.transform = .init(scaleX: 0.85, y: 0.85)
        } completion: { com in
            UIView.animate(withDuration: 0.1) {
                self.wordAddButton.transform = .identity
            }
        }
        
        
        coordinator.showAddWordScreen()
    }
    
    @objc func changeScreen(sender: UIButton) {
        
        UIView.animate(withDuration: 0.15) {
            sender.transform = .init(scaleX: 0.85, y: 0.85)
        } completion: { com in
            UIView.animate(withDuration: 0.15) {
                sender.transform = .identity
            }
            
        }
        
        
        switch sender.tag {
        case 0 : self.selectedIndex = 0
        case 2 : self.selectedIndex = 2
        default:
            print("nam vsem pizda knopki na custom uiTabBar")
        }
        
    }
    
}

extension TabViewController: UITabBarControllerDelegate {
    
    
}
