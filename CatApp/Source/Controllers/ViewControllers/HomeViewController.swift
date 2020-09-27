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
    @IBAction private func addFavourite() {
        addTheImageToFavourite()
    }
    fileprivate var imageId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setACatImage()
    }
    
    func setACatImage() {
        // What happen if the URL is nil ?
        view.showLoader()
        HomeService.getRandomCat({ (randomCat) in
            self.imageId = randomCat.id
            self.catImageView.load(url: URL(string: randomCat.url!)!, view: self.view)
        }, errorHandler: { (error) -> Void in
            self.view.hideLoader()
            print(error?.localizedDescription ?? "")
        })
    }
    
    func addTheImageToFavourite() {
        guard let id = imageId else { return }
        FavouriteService.addFavourite(id, subId: "jhondoe123", callback: { (message) in
            self.showAlert(title: "Favourite", message: message, alertActionTitle: "Accept")
        }, errorHandler: { (error) -> Void in
            self.showAlert(title: "Error", message: "Duplicate", alertActionTitle: "Accept")
        })
    }
}

extension HomeViewController: NavigationDelegate {
    func goToNextView(_ toView: MenuOptions) {
        view.showLoader()
        switch toView {
        case .breeds:
            BreedService.getBreeds({ (breeds) in
                self.view.hideLoader()
                self.goToBreeds(with: breeds)
            }, errorHandler: { (error) -> Void in
                self.view.hideLoader()
                print(error?.localizedDescription ?? "")
            })
        case .favourites:
            print("Go to favourites")
        default:
            print("Somethings go wrong")
        }
        
    }
}
