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
        let filterText: AnyObserver<String>
    }
    
    struct Output {
        let photoList: Driver<[PhotoModel]>
    }
    
    let input: Input
    let output: Output
    
    private let photosApiResp = PublishRelay<[PhotoModel]>()
    private let disposeBag = DisposeBag()
    
    init() {
        let filterText = PublishSubject<String>()
        let photoList = BehaviorRelay<[PhotoModel]>(value: [])
        
        self.input = Input(filterText: filterText.asObserver())
        self.output = Output(photoList: photoList.asDriver())
        
        Observable.combineLatest(photosApiResp, filterText)
            .map { (photos, text) -> [PhotoModel] in
                return text.count > 0 ? photos.filter({ $0.title.contains(text) }) : photos
        }
        .bind(to: photoList)
        .disposed(by: self.disposeBag)
        
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
