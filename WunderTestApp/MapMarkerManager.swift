//
//  MapMarkerManager.swift
//  WunderTestApp
//
//  Created by Nikita Kechinov on 26.09.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import Foundation
import GoogleMaps

class MapMarkerManager {
    
    weak var delegate:  CarsMapViewController?
    let map: GMSMapView
    var visibleMarkers: [String: GMSMarker] = [:]
    
    
    init(map: GMSMapView) {
        self.map = map
    }
    
    
    func setMarkersForVisibleArea() {
        for car in delegate!.delegate!.cars {
            
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
        print(visibleMarkers.count)
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
    
    
    func removeMarkersExcept(_ marker: GMSMarker) {
        map.clear()
        marker.map = map
    }
    
    func addMarkers() {
        for (_, marker) in visibleMarkers {
            marker.map = map
        }
    }
    
    //
    //    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
    //
    //    guard let `self` = self else {
    //    return
    //    }
    
    
    
    
}

//    func setCameraAndMarkerOnTheMap(using coordinates: CLLocationCoordinate2D) {
//        let placeMarker = GMSMarker(position: coordinates)
//        placeMarker.map = self.map
//        let camera = GMSCameraPosition.camera(withLatitude: coordinates.latitude, longitude: coordinates.longitude, zoom: 15.0)
//        self.map.camera = camera
//    }



