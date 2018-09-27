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
    private let cellId = "carCellId"
    var cars: [Car] = []
    var userLocation:  CLLocation?
    private unowned var carsTableView: UITableView {
        return (view as! CarsView).carsTableView
    }
    
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
        }
        
        
        userLocation = locationManager.location
        
        
//        let c = Car(address: "", coordinates: CLLocationCoordinate2D(latitude: 233, longitude: 33), engineType: "sdsd", exterior: .good, fuel: 57, interior: .good, name: "WEWEEUIEU7876", vin: "333")
//        cars.append(c)
        carsTableView.dataSource = self
        carsTableView.delegate = self
        
        
        
        NetworkManager.shared.getCars { [weak self] (result) in
            switch result {
            case .Success(let tempCars):
                self?.cars = tempCars
                self?.carsTableView.reloadData()
            case .Failure(let error):
                print(error)
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
        print(cell.frame)
        return cell
    }

}














