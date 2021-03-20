//
//  ImageCodableWrapper.swift
//  IDA_test
//
//  Created by Andrey Gavryutenkov on 3/20/21.
//

import Foundation
import UIKit

//Для requestManager Where T: Codable
public struct ImageWrapper: Codable {
    
    public let photo: Data?
    
    public init(photo: UIImage) {
        self.photo = photo.pngData() ?? photo.jpegData(compressionQuality: 1.0)
    }
}
