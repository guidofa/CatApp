//
//  ImageModel.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 10/14/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import Foundation
import SwiftyJSON

class ImageModel {
    var id: String?
    var url: String!
    
    init(json: JSON) {
        id = json["id"].stringValue
        url = json["url"].stringValue
    }
}
