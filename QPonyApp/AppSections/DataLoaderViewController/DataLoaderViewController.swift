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
    var didEndLoading = {}
    
    override func setupUI() {
        super.setupUI()
        activityIndicator.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        didEndLoading()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        activityIndicator.stopAnimating()
    }
}
