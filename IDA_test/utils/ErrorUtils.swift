//
//  ErrorUtils.swift
//  Aintags
//
//  Created by Andrey Gavryutenkov on 4/29/19.
//  Copyright © 2019 Dizzain Inc. All rights reserved.
//

import UIKit

func showError(message: String, viewController: UIViewController?, completion: @escaping () -> Void = {}) {
    let alert = UIAlertController(title: "Error".localized, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok".localized, style: .default) { _ in
        completion()
    })
    if let viewController = viewController {
        viewController.present(alert, animated: true)
    } 
}
