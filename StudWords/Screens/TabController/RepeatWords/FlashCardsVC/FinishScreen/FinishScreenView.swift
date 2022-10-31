//
//  FinishScreenView.swift
//  StudWords
//
//  Created by Vitaliy Griza on 31.10.2022.
//

import UIKit

class FinishScreenView: UIView {

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
        backgroundColor = .red
    }
}
