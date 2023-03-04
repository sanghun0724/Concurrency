//
//  ViewController.swift
//  Concurrency_Images
//
//  Created by sangheon on 2023/03/04.
//

import UIKit

final class DownloadViewController: UIViewController {
    
    private lazy var loadImageStackView: UIStackView = {
        
       return UIStackView()
    }()
    
    private lazy var loadImageView: LoadImageView = {
       
        return LoadImageView()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

