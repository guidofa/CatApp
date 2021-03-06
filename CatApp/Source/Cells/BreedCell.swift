//
//  BreedCell.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/22/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import UIKit

class BreedCell: UITableViewCell {
    @IBOutlet fileprivate weak var breedNameLabel: UILabel!
    
    func configure(breedName: String) {
        breedNameLabel.text = breedName
    }
}
