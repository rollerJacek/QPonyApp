//
//  MainCoordinator.swift
//  QPonyApp
//
//  Created by Jacek Stąporek on 30/03/2020.
//  Copyright © 2020 Jacek Stąporek. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = HomeViewController.instantiate(storyboardName: Storyboards.homeViewController)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showDetails(about currency: TablesRatesModel, table: ApiUrls.table) {
        let vc = DetailsViewController.instantiate(storyboardName: Storyboards.detailsViewController)
        vc.currency = currency
        vc.table = table
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showDataLoader() -> DataLoaderViewController {
        let vc = DataLoaderViewController.instantiate(storyboardName: Storyboards.dataLoaderViewController)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        navigationController.present(vc, animated: true)
        return vc
    }
}
