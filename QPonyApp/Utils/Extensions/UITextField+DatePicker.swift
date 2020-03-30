//
//  UITextField+DatePicker.swift
//  QPonyApp
//
//  Created by Jacek Stąporek on 30/03/2020.
//  Copyright © 2020 Jacek Stąporek. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setInputViewDatePicker(target: Any, selector: Selector) {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let start = dateFormatter.date(from: "2002-01-02")
        datePicker.datePickerMode = .date
        self.inputView = datePicker
        datePicker.maximumDate = Date()
        datePicker.minimumDate = start
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Anuluj", style: .plain, target: nil, action: #selector(tapCancel))
        let barButton = UIBarButtonItem(title: "OK", style: .plain, target: target, action: selector)
        toolBar.setItems([cancel, flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    
}
