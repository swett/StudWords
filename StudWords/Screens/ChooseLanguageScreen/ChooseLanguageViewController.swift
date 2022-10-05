//
//  ChooseLanguageViewController.swift
//  StudWords
//
//  Created by Vitaliy Griza on 28.09.2022.
//

import UIKit
import Then
import SnapKit
class ChooseLanguageViewController: UIViewController {
    
    var chooseLanguageLabel: UILabel!
    var ukraineLanguageButton: UIButton!
    var englishLanguageButton: UIButton!
    
    var apiClient: AppData?
    var words: [OldStyleWord] = []
    
    init(apiClient: AppDataProtocol) {
        self.apiClient = apiClient as! AppData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureShadowForElemnts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    
}

extension ChooseLanguageViewController {
    
    
    
    
    func configureUI() {
        view.backgroundColor = UIColor(named: "CyanColorBG")
        chooseLanguageLabel = UILabel().then({ label in
            view.addSubview(label)
            label.text = "Choose language"
            label.font = .monospacedDigitSystemFont(ofSize: 40, weight: .light)
            label.numberOfLines = 0
            label.textAlignment = .left
            label.textColor = .white
            label.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).offset(150)
                make.centerX.equalToSuperview()
            }
        })
        
        ukraineLanguageButton = UIButton().then({ button in
            view.addSubview(button)
            button.setImage(UIImage(named: "Ukraine_flag"), for: .normal)
            button.tag = 0
            button.addTarget(self, action: #selector(self.chooseLanguage), for: .touchUpInside)
            button.snp.makeConstraints { make in
                make.top.equalTo(chooseLanguageLabel.snp.bottom).offset(120)
                make.centerX.equalToSuperview()
                make.width.equalTo(80)
                make.height.equalTo(60)
            }
        })
        englishLanguageButton = UIButton().then({ button in
            view.addSubview(button)
            button.setImage(UIImage(named: "UK_flag"), for: .normal)
            button.tag = 1
            button.addTarget(self, action: #selector(self.chooseLanguage), for: .touchUpInside)
            button.snp.makeConstraints { make in
                make.top.equalTo(ukraineLanguageButton.snp.bottom).offset(50)
                make.centerX.equalToSuperview()
                make.width.equalTo(80)
                make.height.equalTo(60)
            }
        })
        
        
        
    }
    
    func configureShadowForElemnts() {
        self.ukraineLanguageButton.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        self.ukraineLanguageButton.layer.shadowRadius = 3
        self.ukraineLanguageButton.layer.shadowOffset = .init(width: 0, height: 5)
        self.ukraineLanguageButton.layer.shadowOpacity = 1
        
        self.englishLanguageButton.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        self.englishLanguageButton.layer.shadowRadius = 3
        self.englishLanguageButton.layer.shadowOffset = .init(width: 0, height: 5)
        self.englishLanguageButton.layer.shadowOpacity = 1
    }
    
}

extension ChooseLanguageViewController {
    @objc func chooseLanguage(sender: UIButton){
        
        let button = sender
        print(button.tag)
        UIView.animate(withDuration: 0.2) {
            button.transform = .init(scaleX: 0.85, y: 0.85)
        } completion: { com in
            button.transform = .identity
        }
        switch button.tag {
        case 0:
            print("I loaded with ukraine words")
            let controller = ViewController()
            navigationController?.setViewControllers([controller], animated: true)
            self.loadData()
        case 1:
            print("I loaded with english words")
            let controller = ViewController()
            navigationController?.setViewControllers([controller], animated: true)
            self.loadData()
        default:
            print("aaa nam vsem pizda")
        }
        
        //
    }
    func loadData() {
        apiClient?.getWord { [weak self] words, error in
            if let words = words {
                self?.words = words
            } else {
                assertionFailure("aaa nam vsem pizda choose language")
            }
        }
    }
    
}
