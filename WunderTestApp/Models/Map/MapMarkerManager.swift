//
//  MapMarkerManager.swift
//  WunderTestApp
//
//  Created by Nikita Kechinov on 26.09.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import Foundation
import GoogleMaps

final class MapMarkerManager {
    
    weak var delegate:  CarsMapViewController?
    private let map: GMSMapView
    private var visibleClusterItems: [String: POIItem] = [:]

    
    //MARK: - init
    init(map: GMSMapView) {
        self.map = map
    }
    
    //MARK: - Set markers only for visible area on the map
    
    func setClusterItemsForVisibleArea() {
        guard let cars = delegate?.dataSource?.cars else { return }
        
        for car in cars {
            if isCarVisibleOnMap(car: car) {
                guard visibleClusterItems[car.stringCoordinates] == nil else { continue }
                let item = POIItem(position: car.coordinates, name: "new")
                visibleClusterItems[car.stringCoordinates] = item
                delegate?.clusterManager?.add(item)
                
            } else {
                guard let marker = visibleClusterItems[car.stringCoordinates] else { continue }
                delegate?.clusterManager?.remove(marker)
                visibleClusterItems.removeValue(forKey: car.stringCoordinates)
            }
        }
    }
    
    private func isCarVisibleOnMap(car: Car) -> Bool {
        
        let padding: CGFloat = 0.0
        let carScreenPoint: CGPoint = map.projection.point(for: car.coordinates)
        
        if carScreenPoint.x < padding ||
            carScreenPoint.y < padding ||
            carScreenPoint.x > map.frame.size.width ||
            carScreenPoint.y > map.frame.size.height {
            
            return false
        }
        return true
    }
    
    
    //MARK: - Removing/Adding markers
    func addClusterItems() {
        delegate?.clusterManager?.clearItems()
        for (_, marker) in visibleClusterItems {
            delegate?.clusterManager?.add(marker)
        }
    }
    
}


