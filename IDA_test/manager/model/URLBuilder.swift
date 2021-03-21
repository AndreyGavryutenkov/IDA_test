//
//  RequestBuilder.swift
//  IDA_test
//
//  Created by Andrey Gavryutenkov on 3/21/21.
//

import Foundation

enum Endpoint {
    
    static let baseURL: URL = URL(string: "https://rickandmortyapi.com/api/")!
    
    case character(Int?)
    case page(Int)
    
    
    func url() ->  URL? {
        
        switch self {
        
        case .character(let characterID):
            let result = Endpoint.baseURL.appendingPathComponent("character")
            return characterID == nil ? result : result.appendingPathComponent(String(characterID!))
       
        case .page(let pageNo):
            var queries: RequestQueries = [:]
            queries["page"] = "\(pageNo)"
            return Endpoint.baseURL
                .appendingPathComponent("character")
                .withQueries(queries)
        }
        
    }
}
