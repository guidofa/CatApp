//
//  MenuCell.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/20/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
