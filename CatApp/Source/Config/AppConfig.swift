//
//  AppConfig.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/20/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import Foundation

class AppConfig {
    fileprivate let baseURL = "https://api.thecatapi.com/v1/"
    fileprivate let apiKey = "b18d7524-957f-4abe-8a38-bceb8603e3b9"
    fileprivate let userId = "jhondoe123"
    
    public class var shared: AppConfig {
        struct Static {
            static let instance = AppConfig()
        }
        return Static.instance
    }
    
    func getBaseURL() -> String {
        return baseURL
    }
    
    func getApiKey() -> String {
        return apiKey
    }
    
    func getUserId() -> String {
        return userId
    }
}
