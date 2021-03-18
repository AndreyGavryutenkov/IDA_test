//
//  SampleScreen.swift
//  Ainstags
//
//  Created by Andrey Gavryutenkov on 7/4/19.
//  Copyright © 2019 Andrey Gavryutenkov. All rights reserved.
//

import Foundation

protocol SampleScreenModuleInput: BaseModuleInput {
    
}

protocol SampleScreenModuleOutput: BaseModuleOutput {
}

protocol SampleScreenViewInput: BaseViewInput {
}

protocol SampleScreenViewOutput: BaseViewOutput {

}

protocol SampleScreenPresenterProtocol: SampleScreenModuleInput, SampleScreenViewOutput {
    
}
