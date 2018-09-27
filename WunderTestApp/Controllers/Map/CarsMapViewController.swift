//
//  CarsMapViewController.swift
//  WunderTestApp
//
//  Created by Nikita Kechinov on 26.09.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit
import GoogleMaps

class CarsMapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    var userLocation = CLLocationCoordinate2D(latitude: 53.541564, longitude: 9.994722)
    weak var dataSource: CarsTableViewController?
    private var isMarkerTapped = false
    var markerManager: MapMarkerManager?

    unowned var carsMap: GMSMapView {
        return (view as! CarsMapView).carsMap
    }
    private var isDataSourceEmpty: Bool {
        return dataSource!.cars.isEmpty
    }
    var route: Route?
    lazy private var infoWindow: InfoWindow = {
        return InfoWindow(frame: CGRect(x: 0, y: 0, width: 170, height: 47))
    }()
    
    override func loadView() {
        view = CarsMapView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let _markerManager = MapMarkerManager(map: carsMap)
        markerManager = _markerManager
        markerManager?.delegate = self
        self.carsMap.delegate = self
        //guard !isDataSourceEmpty else { return }

        
        

        //print(delegate?.userLocation?.coordinate)
        //guard let userCoordinates = delegate?.userLocation?.coordinate else { return }
        //let tempHamburgCoordinates = CLLocationCoordinate2D(latitude: 53.541564, longitude: 9.994722)
        let camera = GMSCameraPosition.camera(withTarget: userLocation, zoom: 16.0)
        carsMap.animate(to: camera)
        
        //markerManager?.setMarkersForVisibleArea()
        
    }


    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        if !isMarkerTapped {
            markerManager?.setMarkersForVisibleArea()
        }
    }
    
    func buildRoute(polyline: String) {
        let path = GMSPath(fromEncodedPath: polyline)
        DispatchQueue.main.async { [weak self] in
            let polylineDraw = GMSPolyline(path: path)
            polylineDraw.strokeWidth = 4.0
            polylineDraw.strokeColor = #colorLiteral(red: 0.1354461725, green: 0.4608484219, blue: 1, alpha: 1)
            polylineDraw.map = self?.carsMap
        }
    }
    
    
    private func getRoute(marker: GMSMarker) {
        
        NetworkManager.shared.getRouteRequest(with: userLocation, and: marker.position) { [weak self, marker]  (result) in
            switch result {
            case .Success(let route):
                self?.infoWindow.setupLabels(with: route.distance, time: route.time)
                self?.route = route
                
                self?.buildRoute(polyline: route.polylinePath)
                self?.carsMap.selectedMarker = marker
            case .Failure(let error):
                print(error)
            }
        }

    }
    
    
    
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        return infoWindow
    }
    
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if isMarkerTapped {
            markerManager?.addMarkers()
            mapView.selectedMarker = nil
            isMarkerTapped = !isMarkerTapped
            
        } else {
            getRoute(marker: marker)
            markerManager?.removeMarkersExcept(marker)
            //mapView.selectedMarker = marker
            isMarkerTapped = !isMarkerTapped
        }

        return true
    }
    
    
    

}
