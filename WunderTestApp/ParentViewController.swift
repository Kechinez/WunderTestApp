//
//  ParentViewController.swift
//  WunderTestApp
//
//  Created by Nikita Kechinov on 27.09.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit

class ParentViewController: UIViewController {

    
    enum TabIndex : Int {
        case firstChildTab = 0
        case secondChildTab = 1
    }
    
    //var segmentedControl: TabySegmentedControl!
    
    var isInitialSwitching = true
    
    var currentViewController: UIViewController?
    lazy var firstChildTabVC: CarsTableViewController? = {
        let firstChildTabVC = CarsTableViewController()
        return firstChildTabVC
    }()
    lazy var secondChildTabVC : CarsMapViewController? = {
        let secondChildTabVC = CarsMapViewController()
        return secondChildTabVC
    }()
    
//    unowned var parentView: ParentView {
//        return (view as! ParentView)
//    }
    
    
    // MARK: - View Controller Lifecycle
    
    
//    override func loadView() {
//        view = ParentView()
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertSegmentedControl()
        //segmentedControl.initUI()
        //segmentedControl.selectedSegmentIndex = TabIndex.firstChildTab.rawValue
        displayCurrentTab(TabIndex.firstChildTab.rawValue)
    }
    
    func setUpConstraints(for view: UIView) {
        let guide = self.view.safeAreaLayoutGuide
        view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let currentViewController = currentViewController {
            currentViewController.viewWillDisappear(animated)
        }
    }
    
    
    private func insertSegmentedControl() {
        let items = ["Cars list", "Map"]
        let segmentedController = UISegmentedControl(items: items)
        segmentedController.addTarget(self, action: #selector(switchTabs(_:)), for: .valueChanged)
        segmentedController.selectedSegmentIndex = TabIndex.firstChildTab.rawValue
        navigationItem.titleView = segmentedController
    }
    
    
    // MARK: - Switching Tabs Functions
    @objc func switchTabs(_ sender: UISegmentedControl) {
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParentViewController()
        
        displayCurrentTab(sender.selectedSegmentIndex)
    }
    
    func displayCurrentTab(_ tabIndex: Int){
        if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
            
            if tabIndex == TabIndex.secondChildTab.rawValue && isInitialSwitching {
                guard let carsMapViewController = vc as? CarsMapViewController else { return }
                carsMapViewController.dataSource = firstChildTabVC
                isInitialSwitching = false
            }
            
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            
            vc.view.frame = view.bounds//self.contentView.bounds
            view.addSubview(vc.view)//self.contentView.addSubview(vc.view)
            setUpConstraints(for: vc.view)
            self.currentViewController = vc
        }
    }
    
    
    
    
    func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
        var vc: UIViewController?
        switch index {
        case TabIndex.firstChildTab.rawValue :
            vc = firstChildTabVC
        case TabIndex.secondChildTab.rawValue :
            vc = secondChildTabVC
        default:
            return nil
        }
        
        return vc
    }
    
    

}
