//
//  FlashCardView.swift
//  StudWords
//
//  Created by Vitaliy Griza on 26.10.2022.
//

import UIKit

class FlashCardView: UIView {
    
    
    var didTapAnswer: ((Int) -> Void)?
    
    private let coordinator: CoordinatorProtocol
    
    //MARK: UI
    var titleLabel: UILabel!
    var stackView: UIStackView!
    var button: UIButton!
    var closeButton: UIButton!

    
    
    
    
    init(coordinator: CoordinatorProtocol) {

        self.coordinator = coordinator
        super.init(frame: .zero)

        setupUI()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderWidth = 1
        layer.borderColor = UIColor.mainDetailsColor.cgColor
        layer.cornerRadius = 10
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension FlashCardView {
    func setupUI() {
        backgroundColor = .mainBgColor
        
        titleLabel = UILabel().then({ label in
            addSubview(label)
            label.backgroundColor = .clear
            label.textColor = .mainTextColor
//            label.text = "hello"
            label.font = UIFont(name: "PoiretOne-Regular", size: 22)
            
            label.snp.makeConstraints { make in
                make.top.equalTo(150)
                make.centerX.equalToSuperview()
            }
        })
        
        stackView = UIStackView().then({ stack in
            addSubview(stack)
            stack.axis = .vertical
            stack.spacing = 20
            stack.alignment = .center
            stack.distribution = .fillEqually

            stack.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(150)
                make.left.right.equalToSuperview().inset(20)
            }
        })
    }
}


extension FlashCardView {
    func setupData(with question: Question) {
        titleLabel.text = question.text
        stackView.arrangedSubviews.forEach { button in
            button.removeFromSuperview()
        }
        question.answers.forEach { answer in
            let button = mapAnswer(answer)
            stackView.addArrangedSubview(button)
            button.snp.makeConstraints { make in
                make.height.equalTo(64)
                make.left.right.equalToSuperview().inset(15)
            }
        }
        
    }
    
    func mapAnswer(_ answer: Answer) -> UIButton {
        let button = UIButton().then { button in
            
            button.setTitle(answer.text, for: .normal)
            button.titleLabel?.font = UIFont(name: "PoiretOne-Regular", size: 20)
            button.layer.cornerRadius = 15
            button.backgroundColor = .mainButtonColor
            button.addTarget(self, action: #selector(questionButtonAct), for: .touchUpInside)
        }
        
        return button
    }
}


extension FlashCardView {
    
    @objc func questionButtonAct(sender: UIButton) {
        guard let index = stackView.arrangedSubviews.firstIndex(where: {$0 == sender}) else {
            assertionFailure("Missing button index")
            return
        }
        didTapAnswer?(index)
    }
    
    func showMistake(at index: Int) {
        
        guard index < stackView.arrangedSubviews.count else {
            assertionFailure("index out of bounds")
            return
        }
        
        let button = stackView.arrangedSubviews[index]
       
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.22
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: button.center.x - 10, y: button.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: button.center.x + 10, y: button.center.y))

        button.layer.add(animation, forKey: "position")
        button.backgroundColor = .red
        
    }
}
