//
//  NetworkUIHandler.swift
//  InnotechTesting
//
//  Created by tautau on 2020/10/3.
//  Copyright © 2020 tautau. All rights reserved.
//

import UIKit

protocol NetworkUIHandler: UIViewController {
    var targetView: UIView { get }
}


extension NetworkUIHandler {
    
    var noDataView: NoDataView {
        if let view = self.view.viewWithTag(-9998) { return view as! NoDataView }
        let view = NoDataView()
        view.tag = -9998
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        view.topAnchor.constraint(equalTo: self.targetView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.targetView.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: self.targetView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.targetView.trailingAnchor).isActive = true
        view.isHidden = true
        return view
    }
    
    var networkErrorView: NetworkErrorView {
        if let view = self.view.viewWithTag(-9999) { return view as! NetworkErrorView }
        let view = NetworkErrorView()
        view.tag = -9999
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        view.topAnchor.constraint(equalTo: self.targetView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.targetView.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: self.targetView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.targetView.trailingAnchor).isActive = true
        view.alpha = 0
        return view
        
    }
}
