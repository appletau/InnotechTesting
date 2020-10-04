//
//  HomeCellDataModel.swift
//  InnotechTesting
//
//  Created by tautau on 2020/10/4.
//  Copyright © 2020 tautau. All rights reserved.
//

import Foundation

struct HomeCellDataModel: CellDataModel {
    let cellIdentifier: String
    let title: String
    let imageUrl: URL?
    
    init(photo: PhotoModel) {
        self.title = photo.title
        self.imageUrl = URL(string: "\(photo.thumbnailUrl).png")
        self.cellIdentifier = HomeTableViewCell.identifier
    }
}

struct HomeSkeletonCellDataModel: CellDataModel {
    let cellIdentifier: String
    
    init() {
        self.cellIdentifier = HomeSkeletonCell.identifier
    }
}
