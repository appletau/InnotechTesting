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

class HomeViewModel: ViewModelType, NetworkErrorHandler {
    
    enum Status {
        case loading, get(photos: [PhotoModel]) ,empty
        
        var cellData: [CellDataModel] {
            switch self {
            case .get(let photos):
                return photos.map({ HomeCellDataModel(photo: $0) })
            case .loading :
                return [HomeSkeletonCellDataModel](repeating: HomeSkeletonCellDataModel(), count: 10)
            default:
                return []
            }
        }
        
        var shouldHideNoDataView: Bool {
            switch self {
            case .empty:
                return false
            default:
                return true
            }
        }
    }
    
    //MARK:- NetworkUIHandler
    var networkError = BehaviorRelay<NetworkErrorType>(value: .None)
    
    struct Input {
        let filterText: AnyObserver<String>
        let reloadButtonPressed: AnyObserver<Void>
    }
    
    struct Output {
        let dataStatus: Driver<Status>
        let networkError: Driver<NetworkErrorType>
    }
    
    let input: Input
    let output: Output
    
    private let photosApiResp = PublishRelay<[PhotoModel]>()
    private let disposeBag = DisposeBag()
    
    init() {
        //input
        let filterText = PublishSubject<String>()
        let reloadButtonPressed = PublishSubject<Void>()
        self.input = Input(
            filterText: filterText.asObserver(),
            reloadButtonPressed: reloadButtonPressed.asObserver()
        )
        //output
        let status = BehaviorRelay<Status>(value: .loading)
        self.output = Output(
            dataStatus: status.asDriver(),
            networkError: networkError.asDriver()
        )
        
        //binding
        Observable.combineLatest(photosApiResp, filterText)
            .subscribeOn(ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global()))
            .map { (photos, text) -> Status in
                guard photos.count > 0 else { return .empty }
                guard text.count > 0  else { return .get(photos: photos) }
                let filterPhotos = photos.filter({ $0.title.contains(text) })
                return filterPhotos.count > 0 ? .get(photos: filterPhotos) : .empty
        }
        .bind(to: status)
        .disposed(by: self.disposeBag)
        
        reloadButtonPressed
            .subscribe(onNext: { [weak self] (_) in
                self?.networkError.accept(.None)
                status.accept(.loading)
            })
            .disposed(by: self.disposeBag)
        
        status
            .subscribe(onNext: { [weak self] (status) in
                switch status {
                case.loading :
                    self?.getPhotos()
                default:
                    break
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    private func getPhotos() {
        APIService.shared.request(JsonPlaceholderAPI.getPhotos())
            .subscribe(onSuccess: { (photos) in
                self.photosApiResp.accept(photos)
            }) { (err) in
                let networkErr = self.analysisNetworkError(err)
                if networkErr != .None {
                    self.networkError.accept(networkErr)
                } else {
                    self.photosApiResp.accept([])
                }
        }
        .disposed(by: self.disposeBag)
    }
}
