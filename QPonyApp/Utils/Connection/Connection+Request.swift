//
//  Connection+Request.swift
//  QPonyApp
//
//  Created by Jacek Stąporek on 30/03/2020.
//  Copyright © 2020 Jacek Stąporek. All rights reserved.
//

import Foundation

class ConnectionService {
    static func getAllCurrencys(table: ApiUrls.table, completion: @escaping ([TablesModel]) -> ()) {
        guard let url: URL = URL(string: ApiUrls.tables + table.value()) else { return }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error in: ConnectionService.getAllCurrencys")
                    return
            }
            do{
                let currencys = try JSONDecoder().decode([TablesModel].self, from: data)
                completion(currencys)
            } catch {
                print("Error: Couldn't decode data in: ConnectionService.getAllCurrencys")
            }
        }
        task.resume()
    }
    
    static func getCurrencyInfo(table: ApiUrls.table, currency: String, startDate: String, endDate: String, completion: @escaping (SingleCurrencyModel?) -> ()) {
        guard let url: URL = URL(string: ApiUrls.rates + table.value() + "\(currency)/\(startDate)/\(endDate)") else { return }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data,
                error == nil else {
                    completion(nil)
                    print(error?.localizedDescription ?? "Response Error in: ConnectionService.getCurrencyInfo")
                    return
            }
            do{
                let currencys = try JSONDecoder().decode(SingleCurrencyModel.self, from: data)
                completion(currencys)
            } catch {
                completion(nil)
                print("Error: Couldn't decode data in: ConnectionService.getCurrencyInfo")
            }
        }
        task.resume()
    }
}
