//
//  CarsTableViewCell.swift
//  WunderTestApp
//
//  Created by Nikita Kechinov on 25.09.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit

class CarsTableViewCell: UITableViewCell {

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setTextAppearance(with: 18)
        return label
    }()
    private let exteriorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Vehicle's exterior"
        label.setTextAppearance(with: CGFloat.calculateFontSize(from: 15))
        return label
    }()
    private let interiorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Vehicle's interior"
        label.setTextAppearance(with: CGFloat.calculateFontSize(from: 15))
        return label
    }()
    private let exteriorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.tintColor = .white
        return imageView
    }()
    private let interiorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.tintColor = .white
        return imageView
    }()
    private let fuelLevelImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    

    //MARK: - Init
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        self.addSubview(nameLabel)
        self.addSubview(exteriorLabel)
        self.addSubview(exteriorImage)
        self.addSubview(interiorLabel)
        self.addSubview(interiorImage)
        self.addSubview(fuelLevelImage)
        setupConstraints()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    //MARK: - Additional methods
    
    func updateUI(with car: Car) {
        nameLabel.text = car.name
        exteriorImage.image = UIImage(named: car.exterior.rawValue)
        interiorImage.image = UIImage(named: car.interior.rawValue)
        setFuelImageWithColor(accordingToThe: car.fuel)
    }
    
    
    
    private func setFuelImageWithColor(accordingToThe fuelLevel: Int) {
        let image = UIImage(named: "fuelLevelIcon.png")!
        let tintedImage = image.withRenderingMode(.alwaysTemplate)
        fuelLevelImage.image = tintedImage
        switch fuelLevel {
        case 0...10:
            fuelLevelImage.tintColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        case 11...25:
            fuelLevelImage.tintColor = #colorLiteral(red: 1, green: 0.6253936491, blue: 0.3428731862, alpha: 1)
        case 26...40:
            fuelLevelImage.tintColor = #colorLiteral(red: 1, green: 0.7997302989, blue: 0.336249338, alpha: 1)
        case 41...60:
            fuelLevelImage.tintColor = #colorLiteral(red: 1, green: 0.9400218825, blue: 0.3274366943, alpha: 1)
        case 61...75:
            fuelLevelImage.tintColor = #colorLiteral(red: 0.9079411833, green: 1, blue: 0.3755851742, alpha: 1)
        case 76...90:
            fuelLevelImage.tintColor = #colorLiteral(red: 0.6647979618, green: 1, blue: 0.28811851, alpha: 1)
        case 91...100:
            fuelLevelImage.tintColor = #colorLiteral(red: 0.4602438957, green: 1, blue: 0.5367191274, alpha: 1)

        default:
            break
        }
    }
    
    
    private func setupConstraints() {
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        
        exteriorLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15).isActive = true
        exteriorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        
        exteriorImage.leadingAnchor.constraint(equalTo: exteriorLabel.trailingAnchor, constant: 20).isActive = true
        exteriorImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        exteriorImage.heightAnchor.constraint(equalTo: exteriorLabel.heightAnchor).isActive = true
        exteriorImage.widthAnchor.constraint(equalTo: exteriorLabel.heightAnchor).isActive = true
        
        interiorLabel.topAnchor.constraint(equalTo: exteriorLabel.bottomAnchor, constant: 10).isActive = true
        interiorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        interiorLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        interiorImage.leadingAnchor.constraint(equalTo: interiorLabel.trailingAnchor, constant: 20).isActive = true
        interiorImage.topAnchor.constraint(equalTo: exteriorLabel.bottomAnchor, constant: 20).isActive = true
        interiorImage.heightAnchor.constraint(equalTo: interiorLabel.heightAnchor).isActive = true
        interiorImage.widthAnchor.constraint(equalTo: interiorLabel.heightAnchor).isActive = true
        
        fuelLevelImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        fuelLevelImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        fuelLevelImage.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6).isActive = true
        fuelLevelImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6).isActive = true
        
    }

}







extension UILabel {
    func setTextAppearance(with textSize: CGFloat) {
        let fontSize = CGFloat.calculateFontSize(from: CGFloat.calculateFontSize(from: textSize))
        self.font = UIFont(name: "OpenSans", size: fontSize)!
        self.textColor = .red
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


