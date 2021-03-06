//
//  CarsView.swift
//  WunderTestApp
//
//  Created by Nikita Kechinov on 24.09.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit

class CarsView: UIView {

    var carsTableView: UITableView {
        return _carsTableView
    }
    private let _carsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = #colorLiteral(red: 0.9226681472, green: 0.9226681472, blue: 0.9226681472, alpha: 1)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CarsTableViewCell.self, forCellReuseIdentifier: "carCellId")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        return tableView
    }()

    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(carsTableView)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Updating constraints
    private func setupConstraints() {
        
        let guide = self.safeAreaLayoutGuide
        carsTableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        carsTableView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        carsTableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        carsTableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        
    }
    
}
