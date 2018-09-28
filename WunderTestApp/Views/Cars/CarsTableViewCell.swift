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
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "OpenSans-Semibold", size: CGFloat.calculateFontSize(from: 18))
        label.textColor = #colorLiteral(red: 0.2880049839, green: 0.6498888229, blue: 0.8780103844, alpha: 1)
        return label
    }()
    private let exteriorLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Vehicle's exterior"
        label.font = UIFont(name: "OpenSans", size: CGFloat.calculateFontSize(from: 15))
        label.textColor = #colorLiteral(red: 0.1203799175, green: 0.1203799175, blue: 0.1203799175, alpha: 1)
        return label
    }()
    private let interiorLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Vehicle's interior"
        label.font = UIFont(name: "OpenSans", size: CGFloat.calculateFontSize(from: 15))
        label.textColor = #colorLiteral(red: 0.1203799175, green: 0.1203799175, blue: 0.1203799175, alpha: 1)
        return label
    }()
    private let exteriorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let interiorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let fuelLevelImage: FuelImageView = {
        let imageView = FuelImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    

    //MARK: - Init
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.isUserInteractionEnabled = false
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
    

    //MARK: - Updating UI
    func updateUI(with car: Car) {
        nameLabel.text = car.name
        exteriorImage.image = UIImage(named: car.exterior.rawValue)
        interiorImage.image = UIImage(named: car.interior.rawValue)
        fuelLevelImage.setImageColor()
        fuelLevelImage.drawArrow(accordingTo: car.fuel)
        
    }
    
    //MARK: - Updating constraints
    private func setupConstraints() {
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 7).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        
        exteriorLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7).isActive = true
        exteriorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        
        exteriorImage.leadingAnchor.constraint(equalTo: exteriorLabel.trailingAnchor, constant: 17).isActive = true
        exteriorImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7).isActive = true
        exteriorImage.heightAnchor.constraint(equalTo: exteriorLabel.heightAnchor).isActive = true
        exteriorImage.widthAnchor.constraint(equalTo: exteriorLabel.heightAnchor).isActive = true
        
        interiorLabel.topAnchor.constraint(equalTo: exteriorLabel.bottomAnchor, constant: 3).isActive = true
        interiorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        interiorLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -7).isActive = true
        
        interiorImage.leadingAnchor.constraint(equalTo: exteriorLabel.trailingAnchor, constant: 17).isActive = true
        interiorImage.topAnchor.constraint(equalTo: exteriorLabel.bottomAnchor, constant: 3).isActive = true
        interiorImage.heightAnchor.constraint(equalTo: interiorLabel.heightAnchor).isActive = true
        interiorImage.widthAnchor.constraint(equalTo: interiorLabel.heightAnchor).isActive = true
        
        fuelLevelImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        fuelLevelImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        fuelLevelImage.heightAnchor.constraint(equalToConstant: 66).isActive = true
        fuelLevelImage.widthAnchor.constraint(equalToConstant: 66).isActive = true
        
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


