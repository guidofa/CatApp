//
//  HomeViewController.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/19/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet fileprivate weak var catImage: UIImageView!
    @IBAction private func buttonOnClick() {
        // Do something
    }
    fileprivate var image = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        HomeService.getRandomCat({ (randomCat) in
            print(randomCat.height ?? 0)
        }) { (error) in
            print(error?.localizedDescription ?? "")
        }
    }
}
