//
//  FuelImageView.swift
//  WunderTestApp
//
//  Created by Nikita Kechinov on 28.09.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit

class FuelImageView: UIImageView {

   
    //MARK: - Drawing methods
    func drawArrow(accordingTo fuelLevel: Int) {
        guard let image = self.image else { return }
        let imageScale = image.scale
        let arrowCoordinateMaker = ArrowCoordinatesMaker()
        let centerPoint = arrowCoordinateMaker.calculatingCenterArrowPoint(using: imageScale)
        let arrrowPoint = arrowCoordinateMaker.calculatingArrowPoint(using: fuelLevel, imageScale)
        
        let startingImage = image
        UIGraphicsBeginImageContext(startingImage.size)
        startingImage.draw(at: CGPoint.zero)
        
        let context = UIGraphicsGetCurrentContext()!
        context.setLineWidth(3.0)
        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineCap(.round)
        context.move(to: centerPoint)
        context.addLine(to: arrrowPoint)
        context.strokePath()
        
        let arrowRenderedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.image = arrowRenderedImage
    }

    func setImageColor() {
        guard let image = UIImage(named: "fuelIcon1.png") else { return }
        let tintedImage = image.withRenderingMode(.alwaysTemplate)
        self.image = tintedImage
        self.tintColor = #colorLiteral(red: 0.1203799175, green: 0.1203799175, blue: 0.1203799175, alpha: 1)
        
    }
    
    
}
