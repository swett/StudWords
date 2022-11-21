//
//  FinishScreenView.swift
//  StudWords
//
//  Created by Vitaliy Griza on 31.10.2022.
//

import UIKit

class FinishScreenView: UIView {

    var titleLabel: UILabel!
    var resultLabel: UILabel!
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FinishScreenView {
    func setupUI() {
        backgroundColor = .mainBgColor
        
        titleLabel = UILabel().then({ label in
            addSubview(label)
            label.backgroundColor = .clear
            label.textColor = .mainTextColor
            label.font = UIFont(name: "Calligraffitti-Regular", size: 40)
            label.text = "Your Result is"
            label.snp.makeConstraints { make in
                make.top.equalTo(150)
                make.centerX.equalToSuperview()
            }
        })
        
        resultLabel = UILabel().then({ label in
            addSubview(label)
            label.backgroundColor = .clear
            label.textColor = .mainTextColor
            label.font = UIFont(name: "Calligraffitti-Regular", size: 32)
            
            label.snp.makeConstraints { make in
                make.top.equalTo(250)
                make.centerX.equalToSuperview()
            }
        })
    }
    
    func setupData(with correctAnswers: Int) {
        resultLabel.text = "\(correctAnswers)"
    }
}
