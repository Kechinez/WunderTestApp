//
//  CarsTableViewController.swift
//  WunderTestApp
//
//  Created by Nikita Kechinov on 24.09.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import Foundation
import UIKit

class CarsTableViewController: UIViewController {
    
    private var cars: [Car] = []
    
    private unowned var carsTableView: UITableView {
        return (view as! CarsView).carsTableView
    }
    
    override func loadView() {
       view = CarsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.getCars { [weak self] (result) in
            switch result {
            case .Success(let tempCars):
                //self?.cars = tempCars
                    print(tempCars)
            //self?.carsTableView.reloadData()
            case .Failure(let error):
                print(error)
            }
        }
        
    }
    
    
    
}
