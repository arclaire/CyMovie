//
//  Filter.swift
//  SimpleApps
//
//  Created by lucy on 13/06/19.
//  Copyright © 2019 lucy. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Filter {
    var strId: String = ""
    var strName: String = "obat kesehatan"
    var price: Float = 0.0
    var strPMin: String = "0"
    var strPMax: String = "1000000"
    var isWholeSale: Bool = false
    var isOfficialSeller: Bool = true
    var isGoldMerch: Bool = true
    var strTotalGold: String = "2"
    var intStart = 0
    var intRows = 20
    init(jsonData: JSON) {
        self.strId = jsonData["_id"].stringValue
    }
}
