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
    private var characterID: Int
    
    var model: RMCharacter?
    
    init(viewInput: DetailScreenViewInput, args: Args) {
        self.viewInput = viewInput
        self.characterID = args[.characterID] as! Int
    }
    
    func didLoad() {
        
//
        
        let endpoint: Endpoint = .character(characterID)
        guard let finalURL = endpoint.url() else {
            viewInput.show(error: "Could not get initial url")
            return
        }

        appController?.requestsManager.fetchData(RMCharacter.self, for: finalURL)
        appController?.requestsManager.delegate = self
        

//        viewInput.updateUI()
    }
    
    func didAppear() {
        
    }
}

extension DetailScreenPresenter: DetailScreenViewOutput {
    

}


private extension DetailScreenPresenter  {
    func fetchImage(from url: URL){
        appController?.imageLoader.loadImage(url) { [weak self]  result in
            switch result {
            case .failure(let error):
                self?.viewInput.show(error: error.localizedDescription)
            case .success(let image):
                self?.viewInput.setImage(image)
            }
        }
    }
}

extension DetailScreenPresenter: RequestDelegate{
    func recievedData<T: Codable>(_ decoded: T) {
        guard let decoded = decoded as? RMCharacter else { viewInput.show(error: "Not correct data recieved"); return }
        self.model = decoded
        
        guard let imageUrl = decoded.image else { viewInput.show(error: "No IMAGE URL"); return }
        fetchImage(from: imageUrl)
        
        viewInput.updateUI()
    }
    
    func connectionStateBecomes(_ newState: ConnectionState) {
        
    }
    
    
    
}
