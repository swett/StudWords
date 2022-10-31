//
//  PassableUIButton.swift
//  StudWords
//
//  Created by Vitaliy Griza on 31.10.2022.
//

import UIKit

class PassableUIButton: UIButton {

    var params: Dictionary<String, Any>
        override init(frame: CGRect) {
            self.params = [:]
            super.init(frame: frame)
        }

        required init?(coder aDecoder: NSCoder) {
            self.params = [:]
            super.init(coder: aDecoder)
        }

}
