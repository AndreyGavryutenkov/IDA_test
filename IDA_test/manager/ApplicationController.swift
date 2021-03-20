//
//  ApplicationController.swift
//  IDA_test
//
//  Created by Andrey Gavryutenkov on 3/18/21.
//

import Foundation



protocol ApplicationProtocol {
    
    var flowController: FlowProtocol { get }
    var requestsManager: RequestManagerInterface { get set}
    var imageLoader: ImageLoader { get }
    
    func run()
}



class AppController {
    
    let flowController: FlowProtocol
    var requestsManager : RequestManagerInterface
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
