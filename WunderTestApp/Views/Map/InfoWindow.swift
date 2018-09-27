//
//  InfoWindow.swift
//  WunderTestApp
//
//  Created by Nikita Kechinov on 27.09.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit

class InfoWindow: UIView {

//    private let distanceLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont(name: "OpenSans", size: CGFloat.calculateFontSize(from: 10))
//        label.textColor = #colorLiteral(red: 0.1203799175, green: 0.1203799175, blue: 0.1203799175, alpha: 1)
//        return label
//    }()
//    private let timeLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont(name: "OpenSans", size: CGFloat.calculateFontSize(from: 10))
//        label.textColor = #colorLiteral(red: 0.1203799175, green: 0.1203799175, blue: 0.1203799175, alpha: 1)
//        return label
//    }()
    
    
     var distanceLabel: UILabel?
    var timeLabel: UILabel?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.cornerRadius = 2
        self.layer.borderWidth = 0.5
        self.layer.borderColor = #colorLiteral(red: 0.1216092957, green: 0.1216092957, blue: 0.1216092957, alpha: 1)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 20, height: 20)
        self.layer.shadowRadius = 15
        let tempDistanceLabel = UILabel(frame: CGRect(x: 6, y: 8, width: self.bounds.width - 12, height: 14))
        tempDistanceLabel.font = UIFont(name: "OpenSans-Semibold", size: CGFloat.calculateFontSize(from: 13))
        tempDistanceLabel.textColor = #colorLiteral(red: 0.1203799175, green: 0.1203799175, blue: 0.1203799175, alpha: 1)
        distanceLabel = tempDistanceLabel
        
        let tempTimeLabel = UILabel(frame: CGRect(x: 6, y: tempDistanceLabel.frame.height + 11, width: self.bounds.width - 12, height: 14))
        tempTimeLabel.font = UIFont(name: "OpenSans-Semibold", size: CGFloat.calculateFontSize(from: 13))
        tempTimeLabel.textColor = #colorLiteral(red: 0.1203799175, green: 0.1203799175, blue: 0.1203799175, alpha: 1)
        timeLabel = tempTimeLabel
        
        addSubview(tempDistanceLabel)
        addSubview(tempTimeLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabels(with distance: String, time: String) {
        distanceLabel!.text = String("The car will move ") + distance
        timeLabel!.text = String("It will take ") + time
    }
    
  
}



