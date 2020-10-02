//
//  PhotoAPI.swift
//  InnotechTesting
//
//  Created by tautau on 2020/10/2.
//  Copyright © 2020 tautau. All rights reserved.
//

import Foundation

protocol JsonPlaceholderAPITargetType: ApiTargetType {}


enum JsonPlaceholderAPI {
    
    struct getPhotos: JsonPlaceholderAPITargetType {
        typealias ResponseDataType = [PhotoModel]
        
        var path: String { return "photos" }
    }
}
