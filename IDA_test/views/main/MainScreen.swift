//
//  MainScreen.swift
//  Ainstags
//
//  Created by Andrey Gavryutenkov on 7/4/19.
//  Copyright © 2019 Andrey Gavryutenkov. All rights reserved.
//

import Foundation

protocol MainScreenModuleInput: BaseModuleInput {
    
}

protocol MainScreenModuleOutput: BaseModuleOutput {
}

protocol MainScreenViewInput: BaseViewInput {

    func insertRowsAt(_ indexPath: [IndexPath])
}

protocol MainScreenViewOutput: BaseViewOutput {
    var cellsDescriptions: [TableViewCellDescription] { get }
    
    func didSelect(_ idx: Int)
    
    func loadNextPage()
}

protocol MainScreenPresenterProtocol: MainScreenModuleInput, MainScreenViewOutput {
    
}
