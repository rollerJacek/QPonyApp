//
//  HomeViewController.swift
//  QPonyApp
//
//  Created by Jacek Stąporek on 30/03/2020.
//  Copyright © 2020 Jacek Stąporek. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = HomeViewModel()
    private var dataLoader: DataLoaderViewController?
    
    override func setupUI() {
        super.setupUI()
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadData))
        self.navigationItem.rightBarButtonItem  = refreshButton
        
        viewModel.delegate = self
        viewModel.setTable(0)
    }
    
    override func setupTableView() {
        super.setupTableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: TableCellsIdentifiers.homeTableViewCell, bundle: nil), forCellReuseIdentifier: TableCellsIdentifiers.homeTableViewCell)
    }
    
    @IBAction func changeTable(_ sender: UISegmentedControl) {
        viewModel.setTable(sender.selectedSegmentIndex)
    }
    
    @objc func reloadData(sender: AnyObject) {
        viewModel.reloadTable()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currencyCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCellsIdentifiers.homeTableViewCell, for: indexPath) as? HomeTableViewCell,
            let item = viewModel.itemForCurrency(index: indexPath.row)
            else {
                return UITableViewCell()
        }
        
        cell.setupCell(for: item, date: viewModel.getEffectiveDate())
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currency = viewModel.itemForCurrency(index: indexPath.row) else { return }
        let table = viewModel.getCurrentTable()
        coordinator?.showDetails(about: currency, table: table)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func didStartFetching() {
        dataLoader = coordinator?.showDataLoader()
    }
    
    func didEndFetching() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.dataLoader?.dismiss(animated: true)
        }
    }
}
