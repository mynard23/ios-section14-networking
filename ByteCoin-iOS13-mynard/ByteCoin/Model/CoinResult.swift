//
//  CoinResult.swift
//  ByteCoin
//
//  Created by OPSolutions on 1/26/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct CoinResult : Decodable {
    var rate : Double
    var asset_id_quote : String
}
