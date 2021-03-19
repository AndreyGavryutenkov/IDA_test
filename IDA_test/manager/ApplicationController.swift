//
//  ApplicationController.swift
//  IDA_test
//
//  Created by Andrey Gavryutenkov on 3/18/21.
//

import Foundation



protocol ApplicationProtocol {
    
    var flowController: FlowProtocol { get }
    var requestsManager: RequestManager { get }
    var imageLoader: ImageLoader { get }
    
    func run()
}



class AppController {
    
    let flowController: FlowProtocol
    let requestsManager : RequestManager
    let imageLoader: ImageLoader
    
    init(with flowController: FlowProtocol) {
        self.flowController = flowController
        self.requestsManager = RequestManager()
        self.imageLoader = ImageLoader()
    }
    
}



extension AppController: ApplicationProtocol {
    
    func run() {
        self.flowController.startFlowWith(initializer: .main, args: nil)
    }
    
    
}
