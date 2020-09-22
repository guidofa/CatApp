//
//  HomeManager.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/21/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import UIKit

class HomeManager {
    public class var shared: HomeManager {
        struct Static {
            static let instance = HomeManager()
        }
        return Static.instance
    }
    // I can save the last cat here so the user always have a different cat.
}
