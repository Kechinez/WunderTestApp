//
//  Helper.swift
//  WunderTestApp
//
//  Created by Nikita Kechinov on 29.09.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit
import CoreLocation

extension CLLocationCoordinate2D {
    func coordinatesToString() -> String {
        print(String(self.latitude) + "," + String(self.longitude))
        return String(self.latitude) + "," + String(self.longitude)
    }
}


extension UILabel {
    enum FontStyle {
        case semiBoldStyle
        case regularStyle
    }
    
    func setTextAppearance(with textStyle: FontStyle, textSize: CGFloat) {
        let fontSize = CGFloat.calculateFontSize(from: CGFloat.calculateFontSize(from: textSize))
        switch textStyle {
        case .regularStyle:
            if let font = UIFont(name: "OpenSans", size: fontSize) {
                self.font = font
            }
        case .semiBoldStyle:
            if let font = UIFont(name: "OpenSans-Semibold", size: fontSize) {
                self.font = font
            }
        }
        self.textColor = #colorLiteral(red: 0.1203799175, green: 0.1203799175, blue: 0.1203799175, alpha: 1)
    }
}


extension CGRect {
    
    static func calculateInfoWindowFrameAccordingToDevice() -> CGRect {
        var frame = CGRect(x: 0, y: 0, width: 187, height: 47)
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1334, 2436:                                         // iPhone 6/6S/7/8/X
                frame = CGRect(x: 0, y: 0, width: 200, height: 51)
            case 1920, 2208:                                           // iPhone 6+/6S+/7+/8+
                frame =  CGRect(x: 0, y: 0, width: 205, height: 51)
            default:                                                    //iPhone 5 or 5S or 5C
                break
            }
        }
        return frame
    }
}

extension CGFloat {
    
    static func calculateFontSize(from originalSize: CGFloat) -> CGFloat {
        var deviceWidth: CGFloat = 0.0
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                deviceWidth = 320         //iPhone 5 or 5S or 5C
            case 1334, 2436:
                deviceWidth = 375          // iPhone 6/6S/7/8/X
            case 1920, 2208:
                deviceWidth = 414          // iPhone 6+/6S+/7+/8+
            default:
                deviceWidth = 320
            }
        }
        return originalSize / 320 * deviceWidth
    }
}
