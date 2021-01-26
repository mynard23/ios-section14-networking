//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func onUpdateCurrency(_ coinResult : CoinResult)
}

struct CoinManager {
    
    var delegate : CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    
    func getCoinPrice(for currency: String) {
        
        let urlString = "\(Utils.baseURL)\(currency)?apikey=\(Utils.apiKey)"
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    return
                }
                
                if let safeData = data {
                    if let coinResult = self.parseJSON(safeData) {
                        self.delegate?.onUpdateCurrency(coinResult)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> CoinResult? {
        
        let decoder = JSONDecoder()
        do {
            var decodedData = try decoder.decode(CoinResult.self, from: data)
            if let rate = Double(String(format: "%.2f", decodedData.rate)){
                decodedData.rate = rate
            }
            return decodedData
            
        } catch {
            return nil
        }
    }
}

