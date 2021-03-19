//
//  DetailScreen.swift
//  Ainstags
//
//  Created by Andrey Gavryutenkov on 7/4/19.
//  Copyright © 2019 Andrey Gavryutenkov. All rights reserved.
//

import Foundation
import UIKit

protocol DetailScreenModuleInput: BaseModuleInput {
    
}

protocol DetailScreenModuleOutput: BaseModuleOutput {
}

protocol DetailScreenViewInput: BaseViewInput {
    func updateUI()
    func setImage(_ image: UIImage)
}

protocol DetailScreenViewOutput: BaseViewOutput {
    var model: RMCharacter { get }
}

protocol DetailScreenPresenterProtocol: DetailScreenModuleInput, DetailScreenViewOutput {
    
}
