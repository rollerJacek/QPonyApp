//
//  HomeViewModel.swift
//  QPonyApp
//
//  Created by Jacek Stąporek on 30/03/2020.
//  Copyright © 2020 Jacek Stąporek. All rights reserved.
//

import Foundation

protocol HomeViewModelDelegate: class {
    func didStartFetching()
    func didEndFetching()
}

class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    private var currencys: TablesModel?
    private var table: ApiUrls.table = .a
    
    private func getCurrencysFor(table: ApiUrls.table) {
        delegate?.didStartFetching()
        ConnectionService.getAllCurrencys(table: table){ [weak self] result in
            self?.currencys = result.first
            self?.delegate?.didEndFetching()
        }
    }
    
    func setTable(_ table: Int) {
        switch table {
        case 0:
            getCurrencysFor(table: .a)
            self.table = .a
        case 1:
            getCurrencysFor(table: .b)
            self.table = .b
        case 2:
            getCurrencysFor(table: .c)
            self.table = .c
        default:
            getCurrencysFor(table: .a)
            self.table = .a
        }
    }
    
    func reloadTable() {
        return getCurrencysFor(table: table)
    }
    
    func getCurrentTable() -> ApiUrls.table {
        return table
    }
    
    func itemForCurrency(index: Int) -> TablesRatesModel? {
        return currencys?.rates[index]
    }
    
    func currencyCount() -> Int {
        guard let count = currencys?.rates.count else { return 0 }
        return count
    }
    
    func getEffectiveDate() -> String {
        guard let date = currencys?.effectiveDate else { return "" }
        return date
    }
    
}
