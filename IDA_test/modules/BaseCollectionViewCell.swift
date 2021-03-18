//
//  BaseCollectionViewCell.swift
//  Ainstags
//
//  Created by Andrey Gavryutenkov on 11/28/19.
//  Copyright © 2019 Dizzain Inc. All rights reserved.
//

import Foundation
import UIKit

/**
    BaseCollectionViewCell. Base set of functions which every collection cell should inhered.
 */
protocol BaseCollectionViewCell {
    
    static func cellIdentifier() -> String
    func configure(for object: Any?)
    
}

extension BaseCollectionViewCell where Self: UICollectionViewCell {
    
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    func configureCell(for object: Any?) {
        
    }
}
