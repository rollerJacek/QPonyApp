//
//  DetailsViewController.swift
//  QPonyApp
//
//  Created by Jacek Stąporek on 30/03/2020.
//  Copyright © 2020 Jacek Stąporek. All rights reserved.
//

import UIKit

class DetailsViewController: BaseViewController {
    
    @IBOutlet weak var currencyCodeLabel: UILabel!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var viewModel = DetailsViewModel(currency: currency, table: table)
    private var dataLoader: DataLoaderViewController?
    var currency: TablesRatesModel!
    var table: ApiUrls.table!
    
    override func setupUI() {
        super.setupUI()
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadData))
        navigationItem.rightBarButtonItem  = refreshButton
        title = currency.currency
        currencyCodeLabel.text = currency.code
        viewModel.delegate = self
        viewModel.getCurencyInfo()
        startDateTextField.setInputViewDatePicker(target: self, selector: #selector(startDate))
        endDateTextField.setInputViewDatePicker(target: self, selector: #selector(endDate))
        startDateTextField.text = viewModel.startDate
        endDateTextField.text = viewModel.endDate
    }
    
    override func setupTableView() {
        super.setupTableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: TableCellsIdentifiers.detailsTableViewCell, bundle: nil), forCellReuseIdentifier: TableCellsIdentifiers.detailsTableViewCell)
    }
    
    @objc func startDate() {
        startDateTextField.resignFirstResponder()
        if let datePicker = self.startDateTextField.inputView as? UIDatePicker {
            let date = datePicker.formatIsoDate()
            startDateTextField.text = date
            viewModel.startDate = date
            reloadData()
        }
    }
    
    @objc func endDate() {
        endDateTextField.resignFirstResponder()
        if let datePicker = self.endDateTextField.inputView as? UIDatePicker {
            let date = datePicker.formatIsoDate()
            endDateTextField.text = date
            viewModel.endDate = date
            reloadData()
        }
    }
    
    @objc func reloadData() {
        viewModel.getCurencyInfo()
    }
}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currencyCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCellsIdentifiers.detailsTableViewCell, for: indexPath) as? DetailsTableViewCell,
            let item = viewModel.itemForCurrency(index: indexPath.row)
            else {
                return UITableViewCell()
        }
        
        cell.setupCell(for: item)
        return cell
    }
}

extension DetailsViewController: DetailsViewModelDelegate {
    func dateFormattingError(error: DetailsError) {
        switch error {
        case .formating:
            presentAlert(title: "Nie poprawny format daty", message: "Data końca nie może być przed datą rozpoczęcia")
        case .tooLong:
            presentAlert(title: "Nie poprawny format daty", message: "Różnica między datami przekracza 367 dni")
        case .check:
            presentAlert(title: "Nie poprawny format daty", message: "")
        case .noData:
            presentAlert(title: "Brak danych", message: "")
        }
    }
    
    func didStartFetching() {
        dataLoader = coordinator?.showDataLoader()
    }
    
    func didEndFetching() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
            if let _ = self.dataLoader?.activityIndicator {
                self.dismissDataLoader()
            } else {
                self.dataLoader?.didEndLoading = { [weak self] in
                    self?.dismissDataLoader()
                }
            }
        }
    }
    
    private func dismissDataLoader() {
        self.dataLoader?.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            if self.viewModel.currencyCount() == 0 {
                self.dateFormattingError(error: .noData)
            }
        }
    }
    
    private func presentAlert(title: String, message: String, preferedStyle: UIAlertController.Style = .alert) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
