//
//  DetailScreenPresenter.swift
//  Ainstags
//
//  Created by Andrey Gavryutenkov on 7/4/19.
//  Copyright © 2019 Andrey Gavryutenkov. All rights reserved.
//

import Foundation

class DetailScreenPresenter: DetailScreenPresenterProtocol {
    
    unowned let viewInput: DetailScreenViewInput
    
    
    init(viewInput: DetailScreenViewInput) {
        self.viewInput = viewInput
    }
    
}

extension DetailScreenPresenter: DetailScreenViewOutput {

}
