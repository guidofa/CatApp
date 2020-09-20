//
//  AppConfig.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/20/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import Foundation

class AppConfig {
    fileprivate let BaseURL = "https://api.thecatapi.com/v1/"
    
    public class var shared: AppConfig {
        struct Static {
            static let instance = AppConfig()
        }
        return Static.instance
    }
    
    func getBaseURL() -> String {
        return BaseURL
    }
}
