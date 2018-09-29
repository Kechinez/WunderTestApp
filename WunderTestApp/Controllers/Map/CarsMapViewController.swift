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
    
    
    let userLocation = CLLocationCoordinate2D(latitude: 53.517234, longitude: 9.978951)

    weak var dataSource: CarsTableViewController?
    private var isMarkerTapped = false
    var markerManager: MapMarkerManager?

    unowned var carsMap: GMSMapView {
        return (view as! CarsMapView).carsMap
    }
    private var isDataSourceEmpty: Bool {
        return dataSource!.cars.isEmpty
    }
    lazy private var infoWindow: InfoWindow = {
        return InfoWindow(frame: CGRect(x: 0, y: 0, width: 192, height: 47))
    }()
    
    
    //MARK: - View Controller lifecycle
    override func loadView() {
        view = CarsMapView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let _markerManager = MapMarkerManager(map: carsMap)
        markerManager = _markerManager
        markerManager?.delegate = self
        self.carsMap.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let userLocation = carsMap.myLocation?.coordinate else { return }
        let camera = GMSCameraPosition.camera(withTarget: userLocation, zoom: 16.0)
        carsMap.animate(to: camera)
    }
    
    
    //MARK: - GMSMapView delegate methods
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        if !isMarkerTapped {
            markerManager?.setMarkersForVisibleArea()
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
            isMarkerTapped = !isMarkerTapped
        }
        return true
    }
    
    
    //MARK: - Build polyline path
    private func buildRoute(polyline: String) {
        let path = GMSPath(fromEncodedPath: polyline)
        DispatchQueue.main.async { [weak self] in
            let polylineDraw = GMSPolyline(path: path)
            polylineDraw.strokeWidth = 4.0
            polylineDraw.strokeColor = #colorLiteral(red: 0.1354461725, green: 0.4608484219, blue: 1, alpha: 1)
            polylineDraw.map = self?.carsMap
        }
    }
    
    //MARK: - Network
    private func getRoute(marker: GMSMarker) {
        
        NetworkManager.shared.getRoute(with: userLocation, and: marker.position) { [weak self, marker]  (result) in
            switch result {
            case .success(let route):
                self?.infoWindow.setupLabels(with: route.distance, time: route.time)
                self?.buildRoute(polyline: route.polylinePath)
                self?.carsMap.selectedMarker = marker
            case .failure(let error):
                print(error)
            }
        }
    }
  
    
}

