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
    private var visibleMarkers: [String: GMSMarker] = [:]
    
    //MARK: - init
    init(map: GMSMapView) {
        self.map = map
    }
    
    //MARK: - Set markers only for visible area on the map
    func setMarkersForVisibleArea() {
        guard let cars = delegate?.dataSource?.cars else { return }
        for car in cars {
        
            if isCarVisibleOnMap(car: car) {
                guard visibleMarkers[car.stringCoordinates] == nil else { continue }
                let marker = GMSMarker()
                marker.position = car.coordinates
                marker.map = map
                visibleMarkers[car.stringCoordinates] = marker
                
            } else {
                guard let marker = visibleMarkers[car.stringCoordinates] else { continue }
                marker.map = nil
                visibleMarkers.removeValue(forKey: car.stringCoordinates)
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
    func removeMarkersExcept(_ marker: GMSMarker) {
        for (_, item) in visibleMarkers {
            guard item === marker else {
                item.map = nil
                continue
            }
        }
    }
    
    func addMarkers() {
        map.clear()
        for (_, marker) in visibleMarkers {
            marker.map = map
        }
    }
    
}


