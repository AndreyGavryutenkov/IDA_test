//
//  DetailScreenInitializer.swift
//  Ainstags
//
//  Created by Andrey Gavryutenkov on 7/4/19.
//  Copyright © 2019 Andrey Gavryutenkov. All rights reserved.
//

import Foundation
import UIKit

class DetailScreenInitializer: BaseInitializer {
    
    static func initialize(args: Args? = nil) -> BaseViewController? {
        let viewController = DetailScreenViewController()
        let inputView =  viewController as DetailScreenViewInput
        
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        
        guard let args = args else { fatalError("Where is args with model?") }
        
        let presenter = DetailScreenPresenter(viewInput: inputView, args: args)
        (inputView as! BaseViewController).output = presenter
                
        return viewController
    }
}
