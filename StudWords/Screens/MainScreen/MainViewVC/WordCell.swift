//
//  WordCell.swift
//  StudWords
//
//  Created by Vitaliy Griza on 03.10.2022.
//

import UIKit

class WordCell: UITableViewCell {
    
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

private extension WordCell {
    func configureUI() {
        contentView.backgroundColor = UIColor(named: "YellowColor")
        containerView = UIView().then({ container in
            contentView.addSubview(container)
            //            container.backgroundColor = UIColor(named: "YellowColor")
            container.snp.makeConstraints { make in
                make.top.left.right.equalToSuperview()
                make.height.equalTo(60)
                make.bottom.equalToSuperview().inset(10)
            }
        })
        
        titleLabel = UILabel().then({ label in
            containerView.addSubview(label)
            label.backgroundColor = .clear
            label.snp.makeConstraints { make in
                
                make.edges.equalToSuperview()
                
            }
        })
    }
}


extension WordCell {
    func setup(with viewModel: WordViewModel) {
        titleLabel.text = viewModel.text
    }
}


extension WordCell {
    static let id = WordCell.description()
}


struct WordViewModel {
    let text: String
    let translation: String
}
