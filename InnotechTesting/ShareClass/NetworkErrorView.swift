//
//  NetworkErrorView.swift
//  InnotechTesting
//
//  Created by tautau on 2020/10/3.
//  Copyright © 2020 tautau. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NetworkErrorView: UIView {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "imgConnectivityError")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont(name: "PingFangSC-Regular", size: 15)
        label.textAlignment = .center
        label.text = "請確認網路連線狀態"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var reloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("重新加載", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 123/255, green: 56/255, blue: 209/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var reloadButtonPressed: Observable<Void> {
        return reloadButton.rx.tap.asObservable()
    }
    
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupUI()
        initBinding()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConstraints()
        setupUI()
        initBinding()
    }
    
    private func setupUI() {
        self.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        DispatchQueue.main.async {
            self.reloadButton.layer.cornerRadius = self.reloadButton.frame.height*(18/38)
        }
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
        
        self.addSubview(reloadButton)
        NSLayoutConstraint.activate([
            reloadButton.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 160/200),
            reloadButton.heightAnchor.constraint(equalTo: reloadButton.widthAnchor, multiplier: 38/160),
            reloadButton.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            reloadButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15)
        ])
    }
    
    private func initBinding() {
        reloadButton.rx.tap
            .subscribe(onNext: { [weak self] (_) in
                UIView.animate(withDuration: 0.3) { self?.alpha = 0 }
            })
            .disposed(by: self.disposeBag)
    }
}
