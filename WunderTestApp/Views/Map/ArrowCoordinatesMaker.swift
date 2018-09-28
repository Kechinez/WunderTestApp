//
//  ArrowLogic.swift
//  WunderTestApp
//
//  Created by Nikita Kechinov on 27.09.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

//import Foundation
import UIKit

struct ArrowCoordinatesMaker {
    
    private let minAngle: Double = 125.0
    private let radius = 58.9
    private let centerPoint = CGPoint(x: 109.8, y: 109.8)
    private let step = 0.65
    private let radianMultiplier = 0.0174533
    
    
    func calculatingArrowPoint(using fuelLevel: Int, _ imageScale: CGFloat) -> CGPoint {
        let angle = (minAngle - Double(fuelLevel) * step) * radianMultiplier
        let y = radius * sin(angle)
        let superViewCoordinateY = 50.9 + (58.9 - y)
        let superViewCoordinateX = calculatingSuperViewCoordinateX(using: angle, fuelLevel: fuelLevel)
        let scaledPoint = applying(imageScale, for: CGPoint(x: superViewCoordinateX, y: superViewCoordinateY))
        return scaledPoint
    }
   
    private func calculatingSuperViewCoordinateX(using angle: Double, fuelLevel: Int) -> Double {
        if fuelLevel > 90 {
            let x = Double(centerPoint.x) -  ((-1) * cos(angle) * Double(centerPoint.x))
            return x
        } else {
            let x = Double(centerPoint.x) + (cos(angle) * Double(centerPoint.x))
            return x
        }
    }
    
    private func applying(_ imageScale: CGFloat, for point: CGPoint) -> CGPoint {
        return CGPoint(x: point.x / imageScale, y: point.y / imageScale)
    }
    
    func calculatingCenterArrowPoint(using imageScale: CGFloat) -> CGPoint {
        return CGPoint(x: centerPoint.x / imageScale, y: centerPoint.y / imageScale)
    }
    
    
}
