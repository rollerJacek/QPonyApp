//
//  HomeTableViewCell.swift
//  QPonyApp
//
//  Created by Jacek Stąporek on 30/03/2020.
//  Copyright © 2020 Jacek Stąporek. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var currencyCodeLabel: UILabel!
    @IBOutlet weak var currencyValueLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func setupCell(for rates: TablesRatesModel, date: String) {
        currencyNameLabel.text = rates.currency
        currencyCodeLabel.text = rates.code
        dateLabel.text = date
        if let mid = rates.mid {
            currencyValueLabel.text = mid.toPriceString()
        } else if let ask = rates.ask {
            currencyValueLabel.text = ask.toPriceString()
        }
    }
}
