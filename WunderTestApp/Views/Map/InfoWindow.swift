//
//  InfoWindow.swift
//  WunderTestApp
//
//  Created by Nikita Kechinov on 27.09.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit

class InfoWindow: UIView {

    private var distanceLabel: UILabel?
    private var timeLabel: UILabel?
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.149984137, green: 0.149984137, blue: 0.149984137, alpha: 1)
        self.layer.cornerRadius = 4
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 20, height: 20)
        self.layer.shadowRadius = 15
        let tempDistanceLabel = UILabel(frame: CGRect(x: 6, y: 8, width: self.bounds.width - 12, height: 14))
        tempDistanceLabel.setTextAppearance(with: .semiBoldStyle, textSize: 14)
        tempDistanceLabel.textColor = #colorLiteral(red: 0.9664102157, green: 0.9664102157, blue: 0.9664102157, alpha: 1)
        distanceLabel = tempDistanceLabel
        
        let tempTimeLabel = UILabel(frame: CGRect(x: 6, y: tempDistanceLabel.frame.height + 11, width: self.bounds.width - 12, height: 14))
        tempTimeLabel.setTextAppearance(with: .semiBoldStyle, textSize: 13)
        tempTimeLabel.textColor = #colorLiteral(red: 0.9664102157, green: 0.9664102157, blue: 0.9664102157, alpha: 1)
        timeLabel = tempTimeLabel
        
        addSubview(tempDistanceLabel)
        addSubview(tempTimeLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - UI updating
    func setupLabels(with distance: String, time: String) {
        distanceLabel!.text = String("The car will move ") + distance
        timeLabel!.text = String("It will take ") + time
    }
    
}



