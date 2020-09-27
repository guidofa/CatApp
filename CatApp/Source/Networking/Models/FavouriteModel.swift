//
//  FavouriteModel.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/26/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import SwiftyJSON

class FavouriteModel {
    var id: String?
    var imageId: String?
    var subId: String?
    var createdAt: String?
    
    init(json: JSON) {
        id = json["id"].stringValue
        imageId = json["image_id"].stringValue
        subId = json["sub_id"].stringValue
        createdAt = json["created_at"].stringValue
    }
}
