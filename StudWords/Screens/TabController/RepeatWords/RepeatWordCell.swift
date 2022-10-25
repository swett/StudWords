//
//  RepeatWordCell.swift
//  StudWords
//
//  Created by Vitaliy Griza on 25.10.2022.
//

import UIKit

class RepeatWordCell: UITableViewCell {

    private var titleLabel: UILabel!
    var containerView: UIView!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension RepeatWordCell {
    
    func configureUI() {
        
        contentView.backgroundColor = .mainBgColor
        
        containerView = UIView().then({ container in
            contentView.addSubview(container)
            container.layer.cornerRadius = 10
            container.layer.borderWidth = 0.3
            container.layer.borderColor = UIColor.mainDetailsColor.cgColor
            
            
            container.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.left.right.equalToSuperview().inset(10)
                make.height.equalTo(60)
                make.bottom.equalToSuperview().inset(10)
            }
        })
        
        titleLabel = UILabel().then({ label in
            containerView.addSubview(label)
            label.backgroundColor = .clear
            label.textColor = .mainTextColor
            label.font = UIFont(name: "Calligraffitti-Regular", size: 22)
            
            label.text = "Repeat all words"
            
            label.snp.makeConstraints { make in
                
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().inset(15)
            }
            
        })
        
    }
}


extension RepeatWordCell {
    static let id = RepeatWordCell.description()
}
