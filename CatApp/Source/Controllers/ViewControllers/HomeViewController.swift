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
        BreedService.getBreeds({ (breeds) in
            for breed in breeds {
                print(breed.name ?? "Unnamed")
            }
        }) { (error) in
            print(error?.localizedDescription ?? "Error")
        }
    }
}
