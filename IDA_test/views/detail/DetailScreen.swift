//
//  DetailScreen.swift
//  Ainstags
//
//  Created by Andrey Gavryutenkov on 7/4/19.
//  Copyright © 2019 Andrey Gavryutenkov. All rights reserved.
//

import Foundation

protocol DetailScreenModuleInput: BaseModuleInput {
    
}

protocol DetailScreenModuleOutput: BaseModuleOutput {
}

protocol DetailScreenViewInput: BaseViewInput {
}

protocol DetailScreenViewOutput: BaseViewOutput {

}

protocol DetailScreenPresenterProtocol: DetailScreenModuleInput, DetailScreenViewOutput {
    
}
