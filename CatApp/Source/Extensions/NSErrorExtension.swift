//
//  NSErrorExtension.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/20/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import Foundation

extension NSError {
    static func initWithMessage(_ msg: String) -> NSError {
        return NSError(domain: "CatApp", code: 1, userInfo: [NSLocalizedDescriptionKey: msg])
    }
}
