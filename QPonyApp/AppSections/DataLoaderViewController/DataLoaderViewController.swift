//
//  DataLoaderViewController.swift
//  QPonyApp
//
//  Created by Jacek Stąporek on 30/03/2020.
//  Copyright © 2020 Jacek Stąporek. All rights reserved.
//

import UIKit

class DataLoaderViewController: BaseViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func setupUI() {
        super.setupUI()
        activityIndicator.startAnimating()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicator.stopAnimating()
    }
}
