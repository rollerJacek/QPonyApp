//
//  DetailsTableViewCell.swift
//  QPonyApp
//
//  Created by Jacek Stąporek on 30/03/2020.
//  Copyright © 2020 Jacek Stąporek. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    func setupCell(for rates: SingleCurrencyRatesModel) {
        dateLabel.text = rates.effectiveDate
        if let mid = rates.mid {
            currencyLabel.text = mid.toPriceString()
        } else if let ask = rates.ask, let bid = rates.bid {
            currencyLabel.text = "Sprzedaż: \(ask.toPriceString())\nKupno: \(bid.toPriceString())"
        }
    }
}
