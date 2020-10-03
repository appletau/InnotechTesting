//
//  HomeTableViewCell.swift
//  InnotechTesting
//
//  Created by tautau on 2020/10/3.
//  Copyright © 2020 tautau. All rights reserved.
//

import UIKit
import Kingfisher

class HomeTableViewCell: UITableViewCell {
    
    //MARK:- Property
    private lazy var thumbnailImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    } ()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        return view
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
    func configureCell(model: PhotoModel) {
        thumbnailImageView.kf.setImage(with: URL(string: "\(model.thumbnailUrl).png"))
        titleLabel.text = model.title
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
            titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])

    }
}

