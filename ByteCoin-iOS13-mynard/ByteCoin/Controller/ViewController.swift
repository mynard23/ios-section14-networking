//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

extension ViewController : CoinManagerDelegate{
    func onUpdateCurrency(_ result : CoinResult) {
        DispatchQueue.main.async {
            self.currencyLabel.text = "\(result.rate)"
            self.bitcoinLabel.text = result.asset_id_quote
        }
    }
}

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    var coinManger = CoinManager()
    
    
    @IBOutlet weak var currencyLabel: UILabel!
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManger.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManger.currencyArray.count
    }
    

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManger.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedText = coinManger.currencyArray[row]
        coinManger.getCoinPrice(for: selectedText)
    }
    
}

