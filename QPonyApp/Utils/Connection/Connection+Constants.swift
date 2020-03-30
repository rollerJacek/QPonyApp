//
//  Connection+Constants.swift
//  QPonyApp
//
//  Created by Jacek Stąporek on 30/03/2020.
//  Copyright © 2020 Jacek Stąporek. All rights reserved.
//

import Foundation

enum ApiUrls {
    static let host     = "http://api.nbp.pl/api/exchangerates/"

    static let tables   = host + "tables"
    static let rates    = host + "rates"
    
    enum table: String {
        case a, b, c
        
        func value() -> String {
            return "/\(self.rawValue)/"
        }
    }
}
