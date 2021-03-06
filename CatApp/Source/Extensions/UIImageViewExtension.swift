//
//  UIImageViewExtension.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/21/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: URL, vc: UIViewController?) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        if let homeView = vc as? HomeViewController {
                            homeView.imageLoaded()
                        }
                    }
                }
            }
        }
    }
}
