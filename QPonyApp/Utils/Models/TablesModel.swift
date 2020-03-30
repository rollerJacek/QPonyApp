//
//  TablesModel.swift
//  QPonyApp
//
//  Created by Jacek Stąporek on 30/03/2020.
//  Copyright © 2020 Jacek Stąporek. All rights reserved.
//

import Foundation

class TablesModel: Codable {
    let table: String
    let no: String
    let tradingDate: String?
    let effectiveDate: String
    let rates: [TablesRatesModel]
}

class TablesRatesModel: Codable {
    let currency: String
    let code: String
    let mid: Float?
    let bid: Float?
    let ask: Float?
}
