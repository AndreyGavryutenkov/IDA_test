//
//  Model.swift
//  IDA_test
//
//  Created by Andrey Gavryutenkov on 3/18/21.
//

import Foundation



class MainInfo: Codable {
    let info: RMInfo?
    let results: [RMCharacter]?
    
    
    enum CodingKeys: String, CodingKey {
        case info, results
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        info = try? values.decodeIfPresent(RMInfo.self, forKey: .info)
        results = try? values.decodeIfPresent([RMCharacter].self, forKey: .results)
        
    }
    
}

class RMInfo: Codable {
    
    var hasNext: Bool = false
    let next: URL?
    
    enum CodingKeys: String, CodingKey {
        case next
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let strNext = (try? values.decodeIfPresent(String.self, forKey: .next)) ?? ""
        next = URL(string: strNext)
        
    }

}

//enum RMGender {
//    
//    case male
//    case female
//    case unknown
//    
//    
//    init(_ value: String?) {
//        
//        guard let value = value else { self = .unknown; return }
//        
//        let valueToConvert = value
//            .lowercased()
//            .trimmingCharacters(in: .whitespacesAndNewlines)
//        
//        switch valueToConvert {
//        case "female": self = .female
//        case "male": self = .male
//        default: self = .unknown
//        }
//    }
//}

class RMCharacter: Codable {
//    name    :    Rick Sanchez
//    status    :    Alive
//    species    :    Human

    let id: Int
    let name: String?
    let status: String
    let species: String?
    let origin: Location?
    let location: Location?
    let image: URL?
    let gender: String
    let characterType: String
    let episodes: [URL]?
    
    
    enum CodingKeys: String, CodingKey {
        case id, name, status, species, origin, location, image, gender
        case characterType = "type"
        case episodes = "episode"
    }
    
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try? values.decodeIfPresent(String.self, forKey: .name)
        status = (try? values.decodeIfPresent(String.self, forKey: .status)) ?? "unknown"
        species = try? values.decodeIfPresent(String.self, forKey: .species)
        origin = try? values.decodeIfPresent(Location.self, forKey: .origin)
        location = try? values.decodeIfPresent(Location.self, forKey: .location)
        
        let strImage = (try? values.decodeIfPresent(String.self, forKey: .image)) ?? ""
        image = URL(string: strImage)
        
        gender = (try? values.decodeIfPresent(String.self, forKey: .gender)) ?? "unknown"
        characterType = (try? values.decodeIfPresent(String.self, forKey: .characterType)) ?? "unknown"
        
        let episodesStrings = try? values.decodeIfPresent([String].self, forKey: .episodes)
        
        episodes = episodesStrings?
            .map({ URL(string: $0) })
            .compactMap({ $0 })
    }

    
}


class Location: Codable {
    let name: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case name, url
    }
    
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try? values.decodeIfPresent(String.self, forKey: .name)
        url = try? values.decodeIfPresent(String.self, forKey: .url)
    }
}
