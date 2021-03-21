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
    private var hasNextPage: Bool = true
    private var nextPage: URL?
    
    
    init(viewInput: MainScreenViewInput) {
        self.viewInput = viewInput
        
        let endpoint: Endpoint = .character(nil)
        guard let finalURL = endpoint.url() else {
            viewInput.show(error: "Could not get initial url")
            return
        }
        
        appController?.requestsManager.delegate = self
        appController?.requestsManager.fetchData(MainInfo.self, for: finalURL)
    }
    
    func didLoad() {
    }
    
}

extension MainScreenPresenter: MainScreenViewOutput {
    func loadNextPage() {
        guard let nextPageUrl = self.nextPage else { return }
        
        if hasNextPage {
            
            guard let pageNo = nextPageUrl.valueOf("page"),
                  let pageNumber = Int( pageNo ) else { viewInput.show(error: "Couldn't get next page"); return }
            
            let pageEndpoint: Endpoint = .page(pageNumber)
            guard let nextPageURL = pageEndpoint.url()
            else { viewInput.show(error: "Couldn't get URL for the next page"); return }
            
            appController?.requestsManager.fetchData(MainInfo.self, for: nextPageURL)
        }
        
    }
    
    func didSelect(_ idx: Int) {
        
        guard let character = (cellsDescriptions[idx].object as? RMCharacter) else { return }        
        var args: Args = [:]
        args[.characterID] = character.id
        appController?.flowController.startFlowWith(initializer: .detail, args: args)
    }
    

}

extension MainScreenPresenter: RequestDelegate {
    
    func connectionStateBecomes(_ newState: ConnectionState) {
        switch newState{
        case .connected:
            print("Connected!")
        case .disconnected:
            print("Disconnected!")
            viewInput.show(error: "Network disconnected! Try later.")
        }
    }
    
    func recievedData<T: Codable>(_ decoded: T) {
        
        guard let mainInfo = decoded as? MainInfo else { viewInput.show(error: "Not correct Data recieved!"); return }
        
        self.nextPage = mainInfo.info?.next

        
        
        if self.nextPage == nil { self.hasNextPage = false }
        
        let items = mainInfo.results?
            .compactMap({ TableViewCellDescription(
                            cellType: ImageInfoTableViewCell.self,
                            object: $0) }) ?? []
        
        self.cellsDescriptions.append(contentsOf: items)
        
        let firstIndex =  self.cellsDescriptions.count - items.count
        let lastIndex = self.cellsDescriptions.count - 1
        let indexPath = Array(firstIndex...lastIndex).map({ IndexPath(row: $0, section: 0) })
        self.viewInput.insertRowsAt(indexPath)
    }
    

}


