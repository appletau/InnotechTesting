//
//  HomeViewModel.swift
//  InnotechTesting
//
//  Created by tautau on 2020/10/2.
//  Copyright © 2020 tautau. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: ViewModelType {
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    let input: Input
    let output: Output
    
    private let photosApiResp = PublishRelay<[PhotoModel]>()
    
    private let disposeBag = DisposeBag()
    
    init() {
        self.input = Input()
        self.output = Output()
        
        getPhotos()
    }
    
    private func getPhotos() {
        APIService.shared.request(JsonPlaceholderAPI.getPhotos())
            .subscribe(onSuccess: { (photos) in
                self.photosApiResp.accept(photos)
            }) { (err) in
                print("!!!err:\(err)")
        }
        .disposed(by: self.disposeBag)
    }
}
