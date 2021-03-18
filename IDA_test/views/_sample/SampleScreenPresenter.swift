//
//  SampleScreenPresenter.swift
//  Ainstags
//
//  Created by Andrey Gavryutenkov on 7/4/19.
//  Copyright © 2019 Andrey Gavryutenkov. All rights reserved.
//

import Foundation

class SampleScreenPresenter: SampleScreenPresenterProtocol {
    
    unowned let viewInput: SampleScreenViewInput
    
    
    init(viewInput: SampleScreenViewInput) {
        self.viewInput = viewInput
    }
    
}

extension SampleScreenPresenter: SampleScreenViewOutput {

}
