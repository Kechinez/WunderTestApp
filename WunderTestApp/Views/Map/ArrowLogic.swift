//
//  ArrowLogic.swift
//  WunderTestApp
//
//  Created by Nikita Kechinov on 27.09.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

//import Foundation
import UIKit

struct ArrowLogic {
    private let minAngle: Double = 125
    private let maxAngle: Double = 53
    private let minX = CGPoint(x: 50.9, y: 109.8)
    private let maxX = CGPoint(x: 168.7, y: 109.8)
    private let maxY = CGPoint(x: 109.8, y: 168.7)
    private let radius = 58.9
    private let centerPoint = CGPoint(x: 109.8, y: 109.8)
    private let step = 0.65
    //private let imageRect: CGRect
    //private var calculatedSizeOfPanel: CGRect {
        //let width =
     //   return CGRect.zero
    //}
//    init(imageRect: CGRect) {
//        self.imageRect = imageRect
//    }
    
    func calculatePoint(using fuelLevel: Int) -> CGPoint {
        let angle = (minAngle - Double(fuelLevel) * step) * 0.0174533
        
        let tempX = radius * cos(angle)
        let tempY = radius * sin(angle)
        
        let x = calculateXRealSize(angle: angle, fuelLevel: fuelLevel)
    
        let y = 50.9 + (58.9 - tempY)
        return CGPoint(x: x, y: y)
    }
   
    private func calculateXRealSize(angle: Double, fuelLevel: Int) -> Double {
        if fuelLevel > 90 {
            let realX = Double(centerPoint.x) -  ((-1) * cos(angle) * Double(centerPoint.x))
            return realX
        } else {
            return Double(centerPoint.x) + (cos(angle) * Double(centerPoint.x))//(1 - cos(angle)) * Double(centerPoint.x) + Double(centerPoint.x)
        }
    }
    
    func calculateWithScale(point: CGPoint, with imagescale: CGFloat) -> CGPoint {
        return CGPoint(x: point.x / imagescale, y: point.y / imagescale)
    }
    
    func calculateCenter(with imageScale: CGFloat) -> CGPoint {
        return CGPoint(x: centerPoint.x / imageScale, y: centerPoint.y / imageScale)
    }
    
    /*
         if cos(angle) < 0 {
             let coefficent = 1 - cos(angle)
         } else {
             let coefficent = 1 + cos(angle)
         }
 
         что делать затвра:
         1) считать в абстрактных единицах из тригонометрии (начало координат - (0,0); (0,1) - самый верхняя точка; (-1,0) - самая левая точка и тд)
         2) потом посчитать чему соответствуют реальные точки из картинки этим абстрактным точкам
         3) просто домножать абстрактные точки, которые будут работать как коэффиценты на реальны точки.
         4) счиатть реальные точки в фотошопе. Счатать
         
         */
        
   // }
    
}
