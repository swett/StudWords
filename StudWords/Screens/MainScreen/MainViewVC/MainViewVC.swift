//
//  MainViewVC.swift
//  StudWords
//
//  Created by Vitaliy Griza on 03.10.2022.
//

import UIKit

class MainViewVC: UIViewController {

    private var viewModel: MainViewModelProtocol
    
    var wordsTableView: UITableView!
    var indicator: UIActivityIndicatorView!
    
    
    init(viewModel: MainViewModelProtocol){
        
        self.viewModel = viewModel
        
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


private extension MainViewVC {
    
    func configureTableView() {
        wordsTableView = UITableView().then({ wordsTableView in
            view.addSubview(wordsTableView)
            wordsTableView.backgroundColor = UIColor(named: "YellowColor")
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

extension MainViewVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WordCell.id, for: indexPath) as!  WordCell
        let cellViewModel = viewModel.model(at: indexPath)
        cell.setup(with: cellViewModel)
        return cell
    }
    
}

extension MainViewVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}


extension MainViewVC: MainViewDelegate {
    
    
    func didChangeLoadingState(isLoading: Bool) {
        isLoading
            ? indicator.startAnimating()
            : indicator.stopAnimating()
    }
    func didEndLoading() {
        wordsTableView.reloadData()
    }
}
