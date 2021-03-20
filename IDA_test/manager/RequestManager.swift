//
//  RequestManager.swift
//  IDA_test
//
//  Created by Andrey Gavryutenkov on 3/18/21.
//

import Foundation
import UIKit

typealias RequestQueries = [String: String]


protocol RequestDelegate: class {
    func recievedData<T: Codable>(_ decoded: T)
}


protocol RequestManagerInterface {
    
    var delegate: RequestDelegate? { get set }
    
    func fetchData<T: Codable>(_ object: T.Type, for url: URL)
}


class RequestManager {
    
    private let session = URLSession(configuration: .default)
    weak var delegate: RequestDelegate?
    
}


extension RequestManager: RequestManagerInterface {
    
    func fetchData<T: Codable>(_ object: T.Type, for url: URL){
        
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



private extension RequestManager {

    func parse<T: Codable>(_ data: Data, ofType: T.Type) -> T? {
        let jsonDecoder = JSONDecoder()
        guard let decodedData = try? jsonDecoder.decode(T.self, from: data) else {
            return nil
        }

        return decodedData
    }
}


extension URL {
    func withQueries(_ queries: RequestQueries) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}


