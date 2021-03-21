//
//  RequestManager.swift
//  IDA_test
//
//  Created by Andrey Gavryutenkov on 3/18/21.
//

import Foundation
import UIKit

typealias RequestQueries = [String: String]

enum ConnectionState {
    case connected
    case disconnected
}

protocol RequestDelegate: class {
    func recievedData<T: Codable>(_ decoded: T)
    
    func connectionStateBecomes(_ newState: ConnectionState)
}


protocol RequestManagerInterface {
    
    var delegate: RequestDelegate? { get set }
    func fetchData<T: Codable>(_ object: T.Type, for url: URL)
}


class RequestManager {
    
    private let session: URLSession
    weak var delegate: RequestDelegate?
    var netConditioner: NetworkAvailabilityInterface
    
    init (with netConditioner: NetworkAvailabilityInterface){
        let configuration = URLSessionConfiguration.default
        
        let memoryCapacity = 500 * 1024 * 1024
        let diskCapacity = 500 * 1024 * 1024
        
        configuration.requestCachePolicy =  .returnCacheDataElseLoad
        configuration.urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "shared_cache")
        self.session = URLSession(configuration: configuration)
        
        self.netConditioner = netConditioner
        self.netConditioner.delegate = self
        
    }
}


extension RequestManager: RequestManagerInterface {
    
    func fetchData<T: Codable>(_ object: T.Type, for url: URL){
        if netConditioner.isNetworkAvailable {
            let task = session.dataTask(with: url) { [weak self] (data, response, error) in
                guard let data = data,
                      let decoded = self?.parse(data, ofType: object.self) else {  return }

                DispatchQueue.main.async {
                    self?.delegate?.recievedData(decoded)
                }
            }
            task.resume()
        } 
    }
    
    
}



private extension RequestManager {

    func parse<T: Codable>(_ data: Data, ofType: T.Type) -> T? {
        let jsonDecoder = JSONDecoder()
        guard let decodedData = try? jsonDecoder.decode(T.self, from: data) else {
            return nil
        }

        return decodedData
    }
}



extension RequestManager: NetworkAvailabilityDelegate {
    func disconnectFromNetwork() {
        self.session.getAllTasks(){ tasks in
            let _ = tasks.map({ if $0.state == .running { $0.cancel() } })
        }
        delegate?.connectionStateBecomes(.disconnected)
    }
    
    func networkIsAvailableAgain() {
        delegate?.connectionStateBecomes(.connected)
    }
    
    
}



extension URL {
    func withQueries(_ queries: RequestQueries) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}


