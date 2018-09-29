//
//  CarsMapViewController.swift
//  WunderTestApp
//
//  Created by Nikita Kechinov on 26.09.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit
import GoogleMaps

class CarsMapViewController: UIViewController, GMSMapViewDelegate, GMUClusterManagerDelegate, CLLocationManagerDelegate {
    
    weak var dataSource: CarsTableViewController?
    private var isMarkerTapped = false
    private var markerManager: MapMarkerManager?
    var clusterManager: GMUClusterManager?
    
    unowned var carsMap: GMSMapView {
        return (view as! CarsMapView).carsMap
    }
    private var isDataSourceEmpty: Bool {
        return dataSource!.cars.isEmpty
    }
    lazy private var infoWindow: InfoWindow = {
        return InfoWindow(frame: CGRect.calculateInfoWindowFrameAccordingToDevice())
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
        
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let clusteringAlgorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: carsMap, clusterIconGenerator: iconGenerator)
        clusterManager = GMUClusterManager(map: carsMap, algorithm: clusteringAlgorithm, renderer: renderer)
        clusterManager?.cluster()
        clusterManager?.setDelegate(self, mapDelegate: self)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let userLocation = dataSource?.currentUserLocation else { return }
        let camera = GMSCameraPosition.camera(withTarget: userLocation, zoom: 15.0)
        carsMap.camera = camera
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isMarkerTapped = false
        carsMap.clear()
    }
    
    //MARK: - GMSMapView delegate methods
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        if !isMarkerTapped {
            markerManager?.setClusterItemsForVisibleArea()
            clusterManager?.cluster()
        }
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        return infoWindow
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if isMarkerTapped {
            markerManager?.addClusterItems()
            mapView.clear()
            isMarkerTapped = !isMarkerTapped
            
        } else {
            let infoWindowMarker = GMSMarker(position: marker.position)
            infoWindowMarker.map = carsMap
            getRouteFromUserLocation(to: infoWindowMarker)
            clusterManager?.clearItems()
            isMarkerTapped = !isMarkerTapped
        }
        clusterManager?.cluster()
        return true
    }
    
    
    //MARK: - GMUClusterManager delegate
    func clusterManager(_ clusterManager: GMUClusterManager, didTap cluster: GMUCluster) -> Bool {
        let newCamera = GMSCameraPosition.camera(withTarget: cluster.position, zoom: carsMap.camera.zoom + 1.5)
        let cameraUpdate = GMSCameraUpdate.setCamera(newCamera)
        carsMap.moveCamera(cameraUpdate)
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
    private func getRouteFromUserLocation(to marker: GMSMarker) {
        guard let userLocation = dataSource?.currentUserLocation else { return }
        NetworkManager.shared.getRoute(with: userLocation, and: marker.position) { [weak self, marker]  (result) in
            switch result {
            case .success(let route):
                self?.infoWindow.setupLabels(with: route.distance, time: route.time)
                self?.buildRoute(polyline: route.polylinePath)
                self?.carsMap.selectedMarker = marker
            case .failure(let error):
                guard let currentVC = self else { return }
                ErrorManager.showErrorMessage(with: error, shownAt: currentVC)
            }
        }
    }
    
    
}

