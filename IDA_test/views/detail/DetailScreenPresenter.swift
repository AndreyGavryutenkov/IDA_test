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
    
    let model: RMCharacter
    
    init(viewInput: DetailScreenViewInput, args: Args) {
        self.viewInput = viewInput
        self.model = args[.model] as! RMCharacter
    }
    
    func didLoad() {
        guard let url = model.image else { viewInput.show(error: "No IMAGE URL"); return }
        appController?.imageLoader.loadImage(url) { [weak self]  result in
            switch result {
            case .failure(let error):
                self?.viewInput.show(error: error.localizedDescription)
            case .success(let image):
                self?.viewInput.setImage(image)
            }
            
        }
        viewInput.updateUI()
    }
    
    func didAppear() {
        
    }
}

extension DetailScreenPresenter: DetailScreenViewOutput {

}
