//
//  FavCell.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 10/14/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import UIKit

class FavCell: UITableViewCell {
    @IBOutlet fileprivate weak var favImageView: UIImageView!
    func configure(url: String) {
        favImageView.load(url: URL(string: url)!, vc: nil)
    }
}
