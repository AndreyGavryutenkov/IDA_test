//
//  MainScreenPresenter.swift
//  Ainstags
//
//  Created by Andrey Gavryutenkov on 7/4/19.
//  Copyright © 2019 Andrey Gavryutenkov. All rights reserved.
//

import Foundation
import UIKit

class MainScreenPresenter: MainScreenPresenterProtocol {
    
    unowned let viewInput: MainScreenViewInput
    var cellsDescriptions: [TableViewCellDescription] = []
    
    //MARK: Pagination
    var hasNextPage: Bool = true
    var nextPage: URL?
    
    
    init(viewInput: MainScreenViewInput) {
        self.viewInput = viewInput
        
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return }
        
        appController?.requestsManager.delegate = self
        appController?.requestsManager.makeRequest(for: url, ofType: MainInfo.self)
    }
    
    func didLoad() {
    }
    
}

extension MainScreenPresenter: MainScreenViewOutput {
    func loadNextPage() {
        guard let nextPageUrl = self.nextPage else { return }
        
        if hasNextPage {
            appController?.requestsManager.makeRequest(for: nextPageUrl, ofType: MainInfo.self)
        }
        
    }
    
    func didSelect(_ idx: Int) {
        // получить картинку по ссылке и открыть новое вью
        
        guard let character = (cellsDescriptions[idx].object as? RMCharacter) else { return }
        let ID = character.id
        
        var args: Args = [:]
        args[.model] = character
        appController?.flowController.startFlowWith(initializer: .detail, args: args)
    }
    

}

extension MainScreenPresenter: RequestDelegate {

    
    func recievedData(_ decoded: MainInfo) {
        self.nextPage = decoded.info?.next

        if self.nextPage == nil { self.hasNextPage = false }
         let items = decoded.results?
            .compactMap({ TableViewCellDescription(
                            cellType: ImageInfoTableViewCell.self,
                            object: $0) }) ?? []
        
        self.cellsDescriptions.append(contentsOf: items)
        

        self.viewInput.updateUI()
    }
    

}


