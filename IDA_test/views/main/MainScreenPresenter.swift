//
//  MainScreenPresenter.swift
//  Ainstags
//
//  Created by Andrey Gavryutenkov on 7/4/19.
//  Copyright © 2019 Andrey Gavryutenkov. All rights reserved.
//

import Foundation

class MainScreenPresenter: MainScreenPresenterProtocol {
    
    unowned let viewInput: MainScreenViewInput
    var cellsDescriptions: [TableViewCellDescription] = []
    
    init(viewInput: MainScreenViewInput) {
        self.viewInput = viewInput
    }
    
    func didLoad() {
        
        guard let url = URL(string: "https://picsum.photos/v2/list?page=1&limit=15") else { return }
        
        appController?.requestsManager.delegate = self
        appController?.requestsManager.makeRequest(for: url, ofType: [ImageInfo].self)
    }
    
}

extension MainScreenPresenter: MainScreenViewOutput {
    func didSelect(_ idx: Int) {
        // получить картинку по ссылке и открыть новое вью
        appController?.flowController.startFlowWith(initializer: .detail, args: nil)
    }
    

}

extension MainScreenPresenter: RequestDelegate {
    func recievedData(_ decoded: [ImageInfo]) {
        print("RECIEVED")
        self.cellsDescriptions = decoded.map({ TableViewCellDescription(cellType: ImageInfoTableViewCell.self, object: $0) })
        self.viewInput.updateUI()
    }
    

}


