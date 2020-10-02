//
//  APIProtocol.swift
//  InnotechTesting
//
//  Created by tautau on 2020/10/2.
//  Copyright © 2020 tautau. All rights reserved.
//

import Moya

let apiDomain = "https://jsonplaceholder.typicode.com"

protocol ApiTargetType: TargetType {
    associatedtype ResponseDataType: Codable
    var dataKeyPath: String? { get }
    var timeout: TimeInterval { get }
}

extension ApiTargetType {
    var baseURL: URL { return URL(string: apiDomain)! }
    var path: String { fatalError("path for ApiTargetType must be override") }
    var method: Moya.Method { return .get }
    var headers: [String : String]? { return nil }
    var task: Task { return .requestPlain }
    var sampleData: Data { return Data() }
    
    var dataKeyPath: String? { return nil }
    var timeout: TimeInterval { return 20 }
}
