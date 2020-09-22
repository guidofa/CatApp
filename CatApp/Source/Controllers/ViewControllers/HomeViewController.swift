//
//  HomeViewController.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/19/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    @IBOutlet fileprivate weak var catImageView: UIImageView!
    @IBAction private func buttonOnClick() {
        setACatImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setACatImage()
    }
    
    func setACatImage() {
        // What happen if the URL is nil ?
        HomeService.getRandomCat({ (randomCat) in
            self.catImageView.load(url: URL(string: randomCat.url!)!)
        }, errorHandler: { (error) -> Void in
            print(error?.localizedDescription ?? "")
        })
    }
}

extension HomeViewController: NavigationDelegate {
    func goToNextView() {
        goToBreeds()
    }
}
