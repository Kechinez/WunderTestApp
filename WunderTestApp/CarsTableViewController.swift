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
        
        userLocation = locationManager.location
        
        
        
        carsTableView.dataSource = self
        carsTableView.delegate = self
        
        carsTableView.rowHeight = UITableViewAutomaticDimension
        carsTableView.estimatedRowHeight = 300
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = CarsMapViewController()
        nextVC.delegate = self
        navigationController?.pushViewController(nextVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)

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














