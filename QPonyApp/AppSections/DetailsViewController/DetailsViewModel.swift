//
//  DetailsViewModel.swift
//  QPonyApp
//
//  Created by Jacek Stąporek on 30/03/2020.
//  Copyright © 2020 Jacek Stąporek. All rights reserved.
//

import Foundation

protocol DetailsViewModelDelegate: class {
    func didStartFetching()
    func didEndFetching()
    func dateFormattingError(error: DetailsError)
}

enum DetailsError {
    case tooLong, formating, check, noData
}

class DetailsViewModel {
    
    private var currency: TablesRatesModel
    private var table: ApiUrls.table
    private var currencyInfo: SingleCurrencyModel?
    weak var delegate: DetailsViewModelDelegate?
    lazy var startDate = self.getTodayDate()
    lazy var endDate = self.getTodayDate()
    
    init(currency: TablesRatesModel, table: ApiUrls.table) {
        self.currency = currency
        self.table = table
    }
    
    func getCurencyInfo() {
        if checkDateDifference() {
            delegate?.didStartFetching()
            ConnectionService.getCurrencyInfo(table: table, currency: currency.code, startDate: startDate, endDate: endDate) { [weak self] result in
                self?.currencyInfo = result
                sleep(1)
                self?.delegate?.didEndFetching()
            }
        }
    }
    
    func currencyCount() -> Int {
        guard let count = currencyInfo?.rates.count else { return 0 }
        return count
    }
    
    func itemForCurrency(index: Int) -> SingleCurrencyRatesModel? {
        return currencyInfo?.rates[index]
    }
    
    private func checkDateDifference() -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let start = dateFormatter.date(from: startDate),
            let end = dateFormatter.date(from: endDate)
            else {
                delegate?.dateFormattingError(error: .tooLong)
                return false
        }
        
        if daysBetween(start: start, end: end) >= 367 {
            delegate?.dateFormattingError(error: .tooLong)
            return false
        }
        
        if start > end {
            delegate?.dateFormattingError(error: .formating)
            return false
        }
        
        return true
    }
    
    private func daysBetween(start: Date, end: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: start, to: end).day!
    }
    
    private func getTodayDate() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        return dateformatter.string(from: Date())
    }
}
