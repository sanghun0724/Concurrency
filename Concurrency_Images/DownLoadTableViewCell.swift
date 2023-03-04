//
//  DownLoadTableViewCell.swift
//  Concurrency_Images
//
//  Created by sangheon on 2023/03/04.
//

import UIKit

class DownLoadTableViewCell: UITableViewCell {
    
    // MARK: - Views
    
    lazy var loadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = .checkmark
        return imageView
    }()
    
    private lazy var loadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Load", for: .normal)
        button.backgroundColor = .blue
        button.isUserInteractionEnabled = false
        return button
    }()
    
    lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        return indicator
    }()
    
    // MARK: - Properties
    var photo: Photo?
    
    // MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUI() {
        contentView.addSubview(loadImageView)
        loadImageView.addSubview(indicator)
        
        contentView.addSubview(loadButton)
        contentView.addSubview(indicator)
        
        loadImageView.translatesAutoresizingMaskIntoConstraints = false
        loadImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40).isActive = true
        loadImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        loadImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        loadImageView.widthAnchor.constraint(equalTo: loadImageView.heightAnchor).isActive = true
        
        loadButton.translatesAutoresizingMaskIntoConstraints = false
        loadButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        loadButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        loadButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        loadButton.heightAnchor.constraint(equalTo: loadImageView.heightAnchor, multiplier: 0.3).isActive = true
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: loadImageView.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: loadImageView.centerYAnchor).isActive = true
    }
    
}

