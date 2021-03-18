//
//  SampleScreenInitializer.swift
//  Ainstags
//
//  Created by Andrey Gavryutenkov on 7/4/19.
//  Copyright © 2019 Andrey Gavryutenkov. All rights reserved.
//

import Foundation
import UIKit

class SampleScreenInitializer: BaseInitializer {
    
    static func initialize(args: Args? = nil) -> BaseViewController? {
        let viewController = SampleScreenViewController()
        let inputView =  viewController as SampleScreenViewInput
        
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        
        let presenter = SampleScreenPresenter(viewInput: inputView)
        (inputView as! BaseViewController).output = presenter
                
        return viewController
    }
}
