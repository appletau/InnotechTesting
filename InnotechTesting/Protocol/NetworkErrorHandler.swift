//
//  NetworkErrorHandler.swift
//  InnotechTesting
//
//  Created by tautau on 2020/10/4.
//  Copyright © 2020 tautau. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

enum NetworkErrorType {
    case NetworkNotReachable, Timeout, None
}

protocol NetworkErrorHandler {
    var networkError: BehaviorRelay<NetworkErrorType> { get }
}

extension NetworkErrorHandler {
    func analysisNetworkError(_ error: Error) ->  NetworkErrorType {
        guard let moError = error as? MoyaError else { return .None }
        switch moError {
        case .underlying(let nsErr as NSError, _):
            guard let afErr = nsErr.asAFError else { return .None }
            switch afErr {
            case .sessionTaskFailed(let e as NSError):
                switch e.code {
                case NSURLErrorTimedOut: return .Timeout
                case NSURLErrorNotConnectedToInternet: return .NetworkNotReachable
                default: return .None
                }
            default: return .None
            }
        default: return .None
        }
    }
}
