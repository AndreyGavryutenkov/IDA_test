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
    case userTagInteractiveMode = "UserTagInteractiveMode"
    case info = "PhotoInfo"
    case tagsWorkType = "TagsWorkActionType"
    case location = "location"
    case photoID = "photo id"
    case pressPosition = "pressPosition"
    case selectedTags = "selectedTags"
    case userTagsInteractionMode = "userTagsInteractionMode"
}


typealias Args = [ArgsKey: Any]


protocol BaseInitializer: class {
    static func initialize(args: Args?)  -> BaseViewController?
}
