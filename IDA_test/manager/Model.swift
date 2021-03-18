//
//  Model.swift
//  IDA_test
//
//  Created by Andrey Gavryutenkov on 3/18/21.
//

import Foundation


//id    :    0
//author    :    Alejandro Escamilla
//width    :    5616
//height    :    3744
//url    :    https://unsplash.com/photos/yC-Yzbqy7PY
//download_url    :    https://picsum.photos/id/0/5616/3744



class ImageInfo:  Codable {
    let id: String?
    let author: String?
    let width: Int?
    let height: Int?
    let url: URL? //   :    https://unsplash.com/photos/yC-Yzbqy7PY
    let downloadURL: URL?   // :    https://picsum.photos/id/0/5616/3744
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case author = "author"
        case width = "width"
        case height = "height"
        case url = "url"
        case downloadURL = "download_url"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decodeIfPresent(String.self, forKey: .id)
        self.author = try values.decodeIfPresent(String.self, forKey: .author)
        self.width = try values.decodeIfPresent(Int.self, forKey: .width)
        self.height = try values.decodeIfPresent(Int.self, forKey: .height)
        
        let strURL = try values.decodeIfPresent(String.self, forKey: .url) ?? ""
        self.url = URL(string: strURL)
        
        let dldStr = try values.decodeIfPresent(String.self, forKey: .downloadURL) ?? ""
        self.downloadURL = URL(string: dldStr)
    }
}
