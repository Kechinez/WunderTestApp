//
//  CarsMapView.swift
//  WunderTestApp
//
//  Created by Nikita Kechinov on 26.09.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit
import GoogleMaps
class CarsMapView: UIView {
    
    let carsMap: GMSMapView = {
        let map = GMSMapView(frame: CGRect.zero)
        map.isMyLocationEnabled = true
        map.settings.myLocationButton = true
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(carsMap)
        setupConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setup GMSMapView delegate
    func setMapDelegate(withCoresponding vc: CarsMapViewController) {
        carsMap.delegate = vc
    }
    
    
    //MARK: - updating constraints
    private func setupConstraints() {
        let guide = self.safeAreaLayoutGuide
        carsMap.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        carsMap.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        carsMap.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        carsMap.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        
    }
    
}
