//
//  ViewModelType.swift
//  InnotechTesting
//
//  Created by tautau on 2020/10/2.
//  Copyright © 2020 tautau. All rights reserved.
//

import Foundation

protocol ViewModelType: class {
   associatedtype Input
   associatedtype Output

   var input: Input { get }
   var output: Output { get }
}
