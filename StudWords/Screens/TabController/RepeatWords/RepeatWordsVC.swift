//
//  RepeatWordsVC.swift
//  StudWords
//
//  Created by Vitaliy Griza on 03.10.2022.
//

import UIKit

class RepeatWordsVC: UIViewController {

    // MARK: private var for coordinator and view model
    private let coordinator: CoordinatorProtocol
    
    // MARK: UI
    var repeatTableView: UITableView!
    
    // MARK: init for controller
    init(coordinator: CoordinatorProtocol){
        
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .mainBgColor
        setupUI()
        // Do any additional setup after loading the view.
    }
    

   

}


extension RepeatWordsVC {
    func setupUI() {
        repeatTableView = UITableView().then({ table in
            view.addSubview(table)
            table.backgroundColor = .mainBgColor
            table.register(RepeatWordCell.self, forCellReuseIdentifier: RepeatWordCell.id)
            table.dataSource = self
            table.delegate = self
            table.separatorStyle = .none
            table.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        })
    }
}



extension RepeatWordsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepeatWordCell.id, for: indexPath) as!  RepeatWordCell
//        let cellViewModel = viewModel.model(at: indexPath)
//        cell.setup(with: cellViewModel)
        return cell
    }
    
    
}

extension RepeatWordsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator.showFlashCardScreen()
    }
}

