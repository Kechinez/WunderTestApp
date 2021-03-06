//
//  CarsTableViewController.swift
//  WunderTestApp
//
//  Created by Nikita Kechinov on 24.09.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
class CarsTableViewController: UIViewController, CLLocationManagerDelegate {
    var currentUserLocation: CLLocationCoordinate2D?
    private let cellId = "carCellId"
    var cars: [Car] = []
    private unowned var carsTableView: UITableView {
        return (view as! CarsView).carsTableView
    }
    
    
    //MARK: - ViewController lifecycle methods
    override func loadView() {
       view = CarsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = 500
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            currentUserLocation = locationManager.location?.coordinate
        }
        
        carsTableView.dataSource = self
        carsTableView.delegate = self
        
        NetworkManager.shared.getCars { [weak self] (result) in
            switch result {
            case .success(let tempCars):
                self?.cars = tempCars
                self?.carsTableView.reloadData()
            case .failure(let error):
                guard let currentVC = self else { return }
                ErrorManager.showErrorMessage(with: error, shownAt: currentVC)
            }
        }
    }
    
}



// MARK: - TableViewController Delegate
extension CarsTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
        
    }
}


//MARK:- TableView Data Source
extension CarsTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CarsTableViewCell
        let currentCar = cars[indexPath.row]
        cell.updateUI(with: currentCar)
        return cell
    }

}




