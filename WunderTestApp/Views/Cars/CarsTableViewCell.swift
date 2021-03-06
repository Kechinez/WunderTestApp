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
        label.setTextAppearance(with: .semiBoldStyle, textSize: 18)
        return label
    }()
    private let exteriorLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.setTextAppearance(with: .regularStyle, textSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Vehicle's exterior"
        return label
    }()
    private let interiorLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Vehicle's interior"
        label.setTextAppearance(with: .regularStyle, textSize: 15)
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
    private let fuelLevelImage: FuelImageView = {
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
        fuelLevelImage.setNeedsDisplay()
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


