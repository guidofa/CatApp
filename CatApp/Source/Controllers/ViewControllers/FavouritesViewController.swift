//
//  FavouritesViewController.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 10/14/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import UIKit

class FavouritesViewController: BaseViewController {
    
    var favs: [FavouriteModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favourites"
    }
}
