//
//  BreedsDetailViewController.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/26/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import UIKit

class BreedDetailViewController: BaseViewController {
    @IBOutlet fileprivate var breedNameLabel: UILabel!
    var breed: BreedModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWithBreed()
    }
    
    func configureWithBreed() {
        breedNameLabel.text = breed?.name
    }
}
