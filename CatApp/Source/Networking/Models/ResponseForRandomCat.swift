//
//  ResponseForRandomCat.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/19/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import SwiftyJSON

class RandomCatResponseModel: NSObject {
    let id: String?
    let url: String?
    let width: Int?
    let height: Int?
    
    init(json: JSON) {
        id = json["id"].stringValue
        url = json["url"].stringValue
        width = json["width"].intValue
        height = json["height"].intValue
    }
}

