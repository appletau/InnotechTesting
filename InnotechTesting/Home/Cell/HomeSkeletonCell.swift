//
//  HomeSkeletonCell.swift
//  InnotechTesting
//
//  Created by tautau on 2020/10/4.
//  Copyright © 2020 tautau. All rights reserved.
//

import UIKit
import SkeletonView

class HomeSkeletonCell: UITableViewCell {
    
    //MARK:- Property
    private lazy var thumbnailImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSkeletonable = true
        return view
    } ()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isSkeletonable = true
        return label
    }()
    
    //MARK:- Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    //MARK:- Public Function
    func showSkeletonAnimation() {
        thumbnailImageView.showAnimatedSkeleton()
        titleLabel.showAnimatedSkeleton()
        self.isUserInteractionEnabled = false
            
    }
    
    func hideSkeletonAnimation() {
        thumbnailImageView.hideSkeleton()
        titleLabel.hideSkeleton()
        self.isUserInteractionEnabled = true
    }
    
    
    //MARK:- Private Function
    private func setupUI() {
        self.selectionStyle = .none
        setupConstraints()
    }
    
    private func setupConstraints() {
        self.contentView.addSubview(thumbnailImageView)
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            thumbnailImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 150),
            thumbnailImageView.heightAnchor.constraint(equalTo: thumbnailImageView.widthAnchor),
        ])
        
        self.contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])

    }
}


