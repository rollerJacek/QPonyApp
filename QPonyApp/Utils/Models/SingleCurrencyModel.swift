//
//  SingleCurrencyModel.swift
//  QPonyApp
//
//  Created by Jacek Stąporek on 30/03/2020.
//  Copyright © 2020 Jacek Stąporek. All rights reserved.
//

import Foundation

class SingleCurrencyModel: Codable {
    let table: String
    let country: String?
    let currency: String?
    let code: String
    let rates: [SingleCurrencyRatesModel]
}

class SingleCurrencyRatesModel: Codable {
    let no: String
    let effectiveDate: String
    let mid: Float?
    let bid: Float?
    let ask: Float?
}
