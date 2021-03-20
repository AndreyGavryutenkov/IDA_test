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
        appController?.requestsManager.fetchData(MainInfo.self, for: url)
    }
    
    func didLoad() {
    }
    
}

extension MainScreenPresenter: MainScreenViewOutput {
    func loadNextPage() {
        guard let nextPageUrl = self.nextPage else { return }
        
        if hasNextPage {
            appController?.requestsManager.fetchData(MainInfo.self, for: nextPageUrl)
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
    func recievedData<T: Codable>(_ decoded: T) {
        
        guard let mainInfo = decoded as? MainInfo else { viewInput.show(error: "Not correct Data recieved!"); return }
        
        self.nextPage = mainInfo.info?.next

        if self.nextPage == nil { self.hasNextPage = false }
         let items = mainInfo.results?
            .compactMap({ TableViewCellDescription(
                            cellType: ImageInfoTableViewCell.self,
                            object: $0) }) ?? []
        
        self.cellsDescriptions.append(contentsOf: items)
        

        self.viewInput.updateUI()
    }
    

}


