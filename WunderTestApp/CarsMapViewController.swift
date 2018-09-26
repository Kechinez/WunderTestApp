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
    weak var delegate: CarsTableViewController?
    private var isMarkerTapped = false
    var markerManager: MapMarkerManager?
    private var infoWindow: UIView?
    unowned var carsMap: GMSMapView {
        return (view as! CarsMapView).carsMap
    }
    
    override func loadView() {
        view = CarsMapView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        carsMap.delegate = self
        let _markerManager = MapMarkerManager(map: carsMap)
        markerManager = _markerManager
        markerManager?.delegate = self
        //print(delegate?.userLocation?.coordinate)
        //guard let userCoordinates = delegate?.userLocation?.coordinate else { return }
        //let tempHamburgCoordinates = CLLocationCoordinate2D(latitude: 53.541564, longitude: 9.994722)
        let camera = GMSCameraPosition.camera(withTarget: userLocation, zoom: 16.0)
        carsMap.animate(to: camera)
        guard delegate!.cars.count > 0 else { return }
        
        markerManager?.setMarkersForVisibleArea()
        
    }

    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        if !isMarkerTapped {
            markerManager?.setMarkersForVisibleArea()
        }
    }
    
    func showPath(polyline: String) {
        let path = GMSPath(fromEncodedPath: polyline)
        DispatchQueue.main.async { [weak self] in
            let polylineDraw = GMSPolyline(path: path)
            polylineDraw.strokeWidth = 4.0
            polylineDraw.strokeColor = #colorLiteral(red: 0.1354461725, green: 0.4608484219, blue: 1, alpha: 1)
            polylineDraw.map = self?.carsMap
        }
    }
    
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let tempInfoWindow = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        infoWindow = tempInfoWindow
        tempInfoWindow.backgroundColor = UIColor.red
        
        NetworkManager.shared.getRouteRequest(with: userLocation, and: marker.position) { [weak self] (route) in
            switch route {
            case .Success(let _route):
                self?.showPath(polyline: _route.polylinePath)

            case .Failure(let error):
                print(error)
            }
            
            //self?.showPath(polyline: route.)
        }
        
        return infoWindow!
    }
    
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if isMarkerTapped {
            markerManager?.addMarkers()
            mapView.selectedMarker = nil
            isMarkerTapped = !isMarkerTapped
            
        } else {
            markerManager?.removeMarkersExcept(marker)
            mapView.selectedMarker = marker
            isMarkerTapped = !isMarkerTapped
        }

        return true
    }
    
    
    

}
