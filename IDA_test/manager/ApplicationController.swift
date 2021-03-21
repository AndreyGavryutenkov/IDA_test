//
//  ApplicationController.swift
//  IDA_test
//
//  Created by Andrey Gavryutenkov on 3/18/21.
//

import Foundation



protocol ApplicationProtocol {
//    var netConditioner: NetworkAvailabilityInterface { get set}
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
        let networkConditioner: NetworkAvailabilityInterface = NetworkAvailabilityManager(with: 1)
        self.requestsManager = RequestManager(with: networkConditioner)
        self.imageLoader = ImageLoader(with: networkConditioner)
//        self.netConditioner = NetworkAvailabilityManager(with: 5)
    }
    
}



extension AppController: ApplicationProtocol {
    
    func run() {
        self.flowController.startFlowWith(initializer: .main, args: nil)
    }
    
    
}
