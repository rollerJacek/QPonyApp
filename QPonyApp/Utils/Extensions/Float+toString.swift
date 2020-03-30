//
//  Float+toString.swift
//  QPonyApp
//
//  Created by Jacek Stąporek on 30/03/2020.
//  Copyright © 2020 Jacek Stąporek. All rights reserved.
//

import Foundation

extension Float {
    func toPriceString() -> String {
        return String(format: "%.2f zł", self)
    }
    
    func toString() -> String {
        return "\(self)"
    }
}
