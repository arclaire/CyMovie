//
//  Product.swift
//  SimpleApps
//
//  Created by lucy on 13/06/19.
//  Copyright © 2019 lucy. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ModelMovie {
    var strId: String = ""
    var strName: String = "-"
    var strSummary: String = "-"
    var strImageItemUrl: String = ""
    var strImagePlaceHolder = "placeholder_item"
    var strVoteAvg: String = "0"
    
    var isGoldSeller: Bool = false
    var isShowBadge: Bool = false
    //https://www.themoviedb.org/t/p/w1280/2CAL2433ZeIihfX1Hb2139CX0pW.jpg
    //https://www.themoviedb.org/t/p/w220_and_h330_face/2CAL2433ZeIihfX1Hb2139CX0pW.jpg
    ///t/p/w220_and_h330_face/sWgBv7LV2PRoQgkxwlibdGXKz1S.jpg
    init(jsonData: JSON) {
        self.strId = jsonData["id"].stringValue
        self.strSummary = jsonData["overview"].stringValue
        self.strName = jsonData["title"].stringValue
        self.strVoteAvg = String(jsonData["vote_average"].floatValue)
        self.strImageItemUrl = "https://www.themoviedb.org/t/p/w220_and_h330_face" + jsonData["poster_path"].stringValue
        self.isGoldSeller = jsonData["is_gold"].boolValue
        
    }
}

struct ModelGenre {
    var name: String = ""
    var id: Int = 0
    
    init(jsonData: JSON) {
        self.id = jsonData["id"].intValue
        self.name = jsonData["name"].stringValue
        
    }
}

struct ModelVideo {
    var name: String = ""
    var id: Int = 0
    var key: String = ""
    var strSite: String = ""
    init(jsonData: JSON) {
        self.id = jsonData["id"].intValue
        self.name = jsonData["name"].stringValue
        self.key = jsonData["key"].stringValue
        self.strSite = jsonData["site"].stringValue
    }
}
