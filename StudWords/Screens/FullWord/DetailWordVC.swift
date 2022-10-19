//
//  FullWordVC.swift
//  StudWords
//
//  Created by Vitaliy Griza on 18.10.2022.
//

import UIKit

class DetailWordVC: UIViewController {

    //MARK: UI
    
    var wordLabel: UILabel!
    var wordText: UILabel!
    
    var synonimLabel: UILabel!
    var synonimText: UILabel!
    
    var meaningLabel: UILabel!
    var meaningText: UILabel!
    
    //MARK: ViewModel
    
    private let viewModel: DetailWordViewModel
    private let coordinator: CoordinatorProtocol

    init(viewModel: DetailWordViewModel, coordinator: CoordinatorProtocol){

        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBgColor
        setupUI()
        viewModel.view = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }

}

//MARK: Setup UI
extension DetailWordVC {
    
    func setupUI() {
        
        wordLabel = UILabel().then({ label in
            view.addSubview(label)
            label.textColor = .mainTextColor
            label.font = UIFont(name: "Calligraffitti-Regular", size: 40)
            label.text = "Word Detail"
            label.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
                make.left.equalToSuperview().inset(30)
            }
        })
        
        
        wordText = UILabel().then({ label in
            view.addSubview(label)
            label.textColor = .mainTextColor
            label.font = UIFont(name: "Calligraffitti-Regular", size: 30)
            label.snp.makeConstraints { make in
                make.top.equalTo(wordLabel.snp.bottom).offset(10)
                make.left.equalToSuperview().inset(30)
            }
        })
        
        meaningText = UILabel().then({ label in
            view.addSubview(label)
            
            label.textColor = .mainTextColor
            label.font = .monospacedSystemFont(ofSize: 25, weight: .medium)
            
            
            label.snp.makeConstraints { make in
                make.top.equalTo(wordText.snp.bottom).offset(50)
                make.left.equalToSuperview().inset(30)
            }
        })
        
        synonimText = UILabel().then({ label in
            view.addSubview(label)
            label.textColor = .mainTextColor
            label.font = .monospacedSystemFont(ofSize: 25, weight: .medium)
            
            label.snp.makeConstraints { make in
                make.top.equalTo(meaningText.snp.bottom).offset(50)
                make.left.equalToSuperview().inset(30)
            }
        })
        
    }
    
    
}


//MARK: Load Data
extension DetailWordVC {
    
    func load(with word: FullWordModel) {
        wordText.text = word.text
        meaningText.text = word.meaning
    }
}


