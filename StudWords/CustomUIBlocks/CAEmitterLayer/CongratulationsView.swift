//
//  CongratulationsView.swift
//  StudWords
//
//  Created by Vitaliy Griza on 02.12.2022.
//

import Foundation
import UIKit

class CongratulationsView {
    public static let dimension = 4
    public static var imagesNames = ["triangledown", "rectangle", "ellipse", "star", "triangleUp"]
   public static func get(with image: UIImage, velocity: Float) -> CAEmitterLayer{
        let emitter = CAEmitterLayer()
        emitter.emitterShape = .line
        emitter.emitterCells = generateEmitterCells(with: image, velocity: velocity)
        
        return emitter
    }
     public static func generateEmitterCells(with image: UIImage, velocity: Float) -> [CAEmitterCell] {
        var cells = [CAEmitterCell]()
            for index in 0..<5 {
                let cell = CAEmitterCell()
                cell.contents = nextImage(i: index)
                cell.birthRate = 4
                cell.lifetime = 14
                cell.velocity = CGFloat(velocity)
                cell.velocityRange = 0
                cell.emissionLongitude = .pi
                cell.emissionRange = 0.5
                cell.spin = 3.5
                cell.spinRange = 1
                cell.scale = 0.1
    
                cells.append(cell)
        }
        return cells
    }
    
   public static func nextImage(i: Int) -> CGImage? {
//       print(imagesNames[i])
        let image = UIImage(named:"\(imagesNames[i])")
            return image?.cgImage
//       return UIImage(named: "den2")?.cgImage
        }
}
