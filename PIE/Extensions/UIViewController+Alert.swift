//
//  UIViewController+Alert.swift
//  PIE
//
//  Created by Karina on 9/1/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertWithMessage(message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: self.title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

