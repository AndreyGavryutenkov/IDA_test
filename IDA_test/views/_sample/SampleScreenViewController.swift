//
//  SampleScreenViewController.swift
//  Ainstags
//
//  Created by Andrey Gavryutenkov on 7/4/19.
//  Copyright © 2019 Andrey Gavryutenkov. All rights reserved.
//

import Foundation
class SampleScreenViewController: BaseViewController, BaseViewProtocol, BaseViewControllerOutputProtocol {
    
    typealias ViewClass = SampleScreenView
    typealias OutputClass = SampleScreenViewOutput
    
    

}


extension SampleScreenViewController: SampleScreenViewInput {
}
