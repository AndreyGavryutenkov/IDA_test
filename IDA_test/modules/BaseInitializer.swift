//
//  BaseInitializer.swift
//  Ainstags
//
//  Created by Andrey Gavryutenkov on 12/24/20.
//  Copyright © 2020 Dizzain Inc. All rights reserved.
//

import Foundation
import UIKit


enum ArgsKey: String, CaseIterable {
    case moduleOutput = "modueOutput"
    case animated = "animated"
    case model = "model"
   
}


typealias Args = [ArgsKey: Any]


protocol BaseInitializer: class {
    static func initialize(args: Args?)  -> BaseViewController?
}
