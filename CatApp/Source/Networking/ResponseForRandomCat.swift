//
//  ResponseForRandomCat.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/19/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import Foundation

struct ResponseForRandomCat: Codable {
    let breeds: [String]?
    let id: String?
    let url: String?
    let width: Int?
    let height: Int?
}
