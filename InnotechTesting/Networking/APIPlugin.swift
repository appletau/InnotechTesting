//
//  APIPlugin.swift
//  InnotechTesting
//
//  Created by tautau on 2020/10/2.
//  Copyright © 2020 tautau. All rights reserved.
//

import Foundation

import Moya

struct MyPlugin: PluginType {
    
    // 記錄網絡請求
    func willSend(_ request: RequestType, target: TargetType) {
        let requestMessage = "start request:\nurl: \(request.request?.url?.absoluteString ?? "")\nheaders: \(request.request?.allHTTPHeaderFields ?? [:])\ntask: \(target.task)"
        
        #if DEBUG
        print(requestMessage)
        #endif
    }
    
    // 記錄網絡請求
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let response):
            let successMessage = "request success, url: \(response.request?.url?.absoluteString ?? ""), statusCode: \(String(describing: response.statusCode))"
            let json = try? JSONSerialization.jsonObject(with: response.data, options: [])
            
            #if DEBUG
            print(successMessage)
            if let json = json { print("response: \(json)") }
            #endif
            
        case .failure(let error):
            let failureMessage = "request failure,\nerror statusCode:\(String(describing: error.response?.statusCode))\nerror description: \(error.errorDescription ?? "")"
            
            #if DEBUG
            print(failureMessage)
            #endif
        }
    }

}
