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
        view.showLoader()
        HomeService.getRandomCat({ (randomCat) in
            self.catImageView.load(url: URL(string: randomCat.url!)!, view: self.view)
        }, errorHandler: { (error) -> Void in
            self.view.hideLoader()
            print(error?.localizedDescription ?? "")
        })
    }
}

extension HomeViewController: NavigationDelegate {
    func goToNextView() {
        view.showLoader()
        BreedService.getBreeds({ (breeds) in
            self.view.hideLoader()
            self.goToBreeds(with: breeds)
        }, errorHandler: { (error) -> Void in
            self.view.hideLoader()
            print(error?.localizedDescription ?? "")
        })
    }
}
