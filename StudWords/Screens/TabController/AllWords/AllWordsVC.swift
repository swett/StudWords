//
//  MainViewVC.swift
//  StudWords
//
//  Created by Vitaliy Griza on 03.10.2022.
//

import UIKit

class AllWordsVC: UIViewController {
    
    
    private var viewModel: AllWordsModelProtocol
    private let coordinator: CoordinatorProtocol
    
    var wordsTableView: UITableView!
    var indicator: UIActivityIndicatorView!
    
    
    init(viewModel: AllWordsModelProtocol, coordinator: CoordinatorProtocol){
        
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureTableView()
        configureIndicator()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear()
    }
    
}


private extension AllWordsVC {
    
    func configureTableView() {
        wordsTableView = UITableView().then({ wordsTableView in
            view.addSubview(wordsTableView)
            wordsTableView.backgroundColor = .mainBgColor
            wordsTableView.register(WordCell.self, forCellReuseIdentifier: WordCell.id)
            wordsTableView.dataSource = self
            wordsTableView.delegate = self
            wordsTableView.separatorStyle = .none
            wordsTableView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        })
    }
    
    func configureIndicator(){
        indicator = UIActivityIndicatorView().then({ indicator in
            view.addSubview(indicator)
            indicator.hidesWhenStopped = true
            indicator.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.size.equalTo(24)
            }
        })
    }
}

extension AllWordsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WordCell.id, for: indexPath) as!  WordCell
        let cellViewModel = viewModel.model(at: indexPath)
        cell.setup(with: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
         return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // TODO: add word removal
            // FIXME: esli ne lox
            viewModel.removeWord(at: indexPath) { _ in
//                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    
    
}

extension AllWordsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let model =  viewModel.didSelectRow(at: indexPath)
        coordinator.showFullWordScreen(word: model)
    }
}


extension AllWordsVC: AllWordsView {
    
    
    func didChangeLoadingState(isLoading: Bool) {
        isLoading
        ? indicator.startAnimating()
        : indicator.stopAnimating()
    }
    func didEndLoading() {
        wordsTableView.reloadData()
    }
}
