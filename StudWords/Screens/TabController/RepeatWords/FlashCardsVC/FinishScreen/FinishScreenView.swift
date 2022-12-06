//
//  FinishScreenView.swift
//  StudWords
//
//  Created by Vitaliy Griza on 31.10.2022.
//

import UIKit

class FinishScreenView: UIView {
    private let coordinator: CoordinatorProtocol
    var congratulationsLabel: UILabel!
    var titleLabel: UILabel!
    var resultLabel: UILabel!
    var backToScreenButton: UIButton!
    
    init(coordinator: CoordinatorProtocol) {
        self.coordinator = coordinator
        super.init(frame: .zero)
        setupUI()
        showWithAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FinishScreenView {
    func setupUI() {
        backgroundColor = .mainBgColor
        congratulationsEffect()
       
        
        congratulationsLabel = UILabel().then({ label in
            addSubview(label)
            label.backgroundColor = .clear
            label.textColor = .mainTextColor
            label.font = UIFont(name: "PoiretOne-Regular", size: 50)
            label.text = "Congratulations"
            label.alpha = 0
            label.snp.makeConstraints { make in
                make.top.equalTo(150)
                make.centerX.equalToSuperview()
            }
        })
        
        titleLabel = UILabel().then({ label in
            addSubview(label)
            label.backgroundColor = .clear
            label.textColor = .mainTextColor
            label.font = UIFont(name: "PoiretOne-Regular", size: 40)
            label.text = "Your Result is"
            label.alpha = 0
            label.snp.makeConstraints { make in
                make.top.equalTo(congratulationsLabel.snp.bottom).offset(30)
                make.centerX.equalToSuperview()
            }
        })
        
        resultLabel = UILabel().then({ label in
            addSubview(label)
            label.backgroundColor = .clear
            label.textColor = .mainTextColor
            label.font = UIFont(name: "PoiretOne-Regular", size: 38)
            label.alpha = 0
            label.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(40)
                make.centerX.equalToSuperview()
            }
        })
        
        backToScreenButton = UIButton().then({ button in
            addSubview(button)
            button.setTitle("To Main Screen", for: .normal)
            button.backgroundColor = .mainButtonColor
            button.titleLabel?.font = UIFont(name: "PoiretOne-Regular", size: 18)
            button.layer.cornerRadius = 15
            button.alpha = 0
            
            
            button.addTarget(self, action: #selector(backToMainScreen) , for: .touchUpInside)
            button.snp.makeConstraints { make in
                make.top.equalTo(resultLabel.snp.bottom).offset(60)
                make.width.equalTo(250)
                make.height.equalTo(50)
                make.centerX.equalToSuperview()
            }
        })
        
    }
    
    @objc func backToMainScreen(){
        coordinator.showMainScreen()
    }
    
    func setupData(with correctAnswers: Int) {
        resultLabel.text = "\(correctAnswers)"
    }
    
    func showWithAnimation() {
        UIView.animate(withDuration: 0.17) {
            self.congratulationsLabel.alpha = 1
        }completion: { com in
            UIView.animate(withDuration: 0.19) {
                self.titleLabel.alpha = 1
            }completion: { com in
                UIView.animate(withDuration: 0.22) {
                    self.resultLabel.alpha = 1
                }completion: { com in
                    UIView.animate(withDuration: 0.27) {
                        self.backToScreenButton.alpha = 1
                    }
                }
            }
        }
    }
    
    func congratulationsEffect() {
        let emmiter = CongratulationsView.get(with: UIImage(named: "rectangle")!, velocity: 150)
        emmiter.emitterPosition = CGPoint(x: 200, y: 0)
        emmiter.emitterSize = CGSize(width: 400, height: 2)
        
        emmiter.opacity = 0.9
        
        layer.insertSublayer(emmiter, at: 0)
        
    }
}
