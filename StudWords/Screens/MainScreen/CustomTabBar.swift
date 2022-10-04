//
//  CustomTabBar.swift
//  StudWords
//
//  Created by Vitaliy Griza on 04.10.2022.
//

import UIKit

class CustomTabBar: UITabBar {

    
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
        for member in subviews.reversed() {
            let subPoint = member.convert(point, from: self)
            guard let result = member.hitTest(subPoint, with: event) else { continue }
            return result
        }
        return nil
    }
    }

