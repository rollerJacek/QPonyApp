//
//  BaseViewController.swift
//  QPonyApp
//
//  Created by Jacek Stąporek on 30/03/2020.
//  Copyright © 2020 Jacek Stąporek. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, Storyboarded {

    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    func setupUI() {}
    func setupTableView() {}
}
