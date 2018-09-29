//
//  ErrorManager.swift
//  WunderTestApp
//
//  Created by Nikita Kechinov on 29.09.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit

final class ErrorManager {
    
    static func showErrorMessage(with error: Error, shownAt viewController: UIViewController) {
        let alertViewController = UIAlertController(title: "Something went wrong...", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "continue", style: .default, handler: nil)
        alertViewController.addAction(okAction)
        viewController.present(alertViewController, animated: true, completion: nil)
    }
    
}
