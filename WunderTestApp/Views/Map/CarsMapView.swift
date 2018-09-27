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
         //CLLocationCoordinate2D(latitude: 53.541564, longitude: 9.994722)
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(carsMap)
        setupConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setMapDelegate(withCoresponding vc: CarsMapViewController) {
        carsMap.delegate = vc
    }
    
    
    
//    private func isMarkerVisibleOnMap(marker: GMSMarker) -> Bool {
//    
//        let padding: CGFloat = 0.0
//        let markerScreenPoint: CGPoint = carsMap.projection.point(for: marker.position)
//    
//        if markerScreenPoint.x < padding &&
//           markerScreenPoint.y < padding &&
//           markerScreenPoint.x > carsMap.frame.size.width &&
//           markerScreenPoint.y > carsMap.frame.size.height {
//            
//            return false
//        }
//        return true
//    }
//    
////
////    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
////
////    guard let `self` = self else {
////    return
////    }
//    
//    func setMarkers(for cars: [Car]) {
//        for car in cars {
//            carsMap.
//            let marker = GMSMarker()
//            let doubleCoordinates = car.buildCoordinates()
//            
//            //let camera = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2D(latitude: doubleCoordinates.latitude, longitude: doubleCoordinates.longitude), zoom: 14.0)
//            //carsMap.animate(to: camera)
//            
//            marker.position = CLLocationCoordinate2D(latitude: doubleCoordinates.latitude, longitude: doubleCoordinates.longitude)
//            marker.map = carsMap
//            
//            
//        }
//        
//
//    }
//    
////    func setCameraAndMarkerOnTheMap(using coordinates: CLLocationCoordinate2D) {
////        let placeMarker = GMSMarker(position: coordinates)
////        placeMarker.map = self.map
////        let camera = GMSCameraPosition.camera(withLatitude: coordinates.latitude, longitude: coordinates.longitude, zoom: 15.0)
////        self.map.camera = camera
////    }
    
    
    private func setupConstraints() {
        carsMap.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        carsMap.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        carsMap.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        carsMap.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        //carsMap.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        //carsMap.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    
    
    
}
