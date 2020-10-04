//
//  NoDataView.swift
//  InnotechTesting
//
//  Created by tautau on 2020/10/3.
//  Copyright © 2020 tautau. All rights reserved.
//

import UIKit

class NoDataView: UIView {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "imgDataError")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont(name: "PingFangSC-Regular", size: 15)
        label.textAlignment = .center
        label.text = "暫無數據"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConstraints()
    }
    
    private func setupConstraints() {
        self.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 130/200),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -30)
        ])
        
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15)
        ])
    }
}
