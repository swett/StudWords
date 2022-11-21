//
//  FlashCardVC.swift
//  StudWords
//
//  Created by Vitaliy Griza on 26.10.2022.
//

import UIKit

class FlashCardVC: UIViewController {

    // MARK: private var for coordinator and view model
    private let coordinator: CoordinatorProtocol
    private let viewModel: FlashCardViewModel
    // MARK: init for controller
    init(coordinator: CoordinatorProtocol, viewModel: FlashCardViewModel){
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: UI
    var flashCardView: FlashCardView!
    var finishScreenView: FinishScreenView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .mainBgColor
        viewModel.view = self
        flashCardView = FlashCardView().then ({ card in
            view.addSubview(card)
            card.alpha = 0
            card.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).inset(15)
                make.bottom.left.right.equalToSuperview().inset(25)
            }
        })
        viewModel.viewDidLoad()
        
        finishScreenView = FinishScreenView().then({ finish in
            view.addSubview(finish)
            finish.alpha = 0
            finish.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).inset(15)
                make.bottom.left.right.equalToSuperview()
            }
        })
    }
    

}


extension FlashCardVC {
    
    
    func showCard(with question: Question) {
        
        flashCardView.setupData(with: question)
        flashCardView.alpha = 1
        flashCardView.didTapAnswer = { [weak self] index in
            self?.viewModel.didTapAnswer(with: index)
        }
        
    }
    
    func showMistake(at index: Int) {
        flashCardView.showMistake(at: index)
    }
    

    func showResult(with correctAnswers: Int) {
        flashCardView.alpha = 0
        finishScreenView.alpha = 1
        finishScreenView.setupData(with: correctAnswers)
    }
}
