//
//  MainScreenInitializer.swift
//  Ainstags
//
//  Created by Andrey Gavryutenkov on 7/4/19.
//  Copyright © 2019 Andrey Gavryutenkov. All rights reserved.
//

import Foundation
import UIKit

class MainScreenInitializer: BaseInitializer {
    
    static func initialize(args: Args? = nil) -> BaseViewController? {
        let viewController = MainScreenViewController()
        let inputView =  viewController as MainScreenViewInput
        
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        
        let presenter = MainScreenPresenter(viewInput: inputView)
        (inputView as! BaseViewController).output = presenter
                
        return viewController
    }
}
