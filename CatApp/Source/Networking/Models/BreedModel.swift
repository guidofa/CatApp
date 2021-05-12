//
//  BreedModel.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/20/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import SwiftyJSON

class BreedModel {
    let id: String?
    let name: String?
    let wikiURL: String?
    
    init(json: JSON) {
        id = json["id"].stringValue
        name = json["name"].stringValue
        wikiURL = json["wikipedia_url"].stringValue
    }
}
