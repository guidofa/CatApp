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
    
    // MARK: Life Cycle
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
        FavouriteService.addFavourite(id, subId: AppConfig.shared.getUserId(), callback: { (message) in
            self.showAlertWithOneAction(title: message, message: "The image has been successfully added to your favourites", alertActionTitle: "Accept")
        }, errorHandler: { (error) -> Void in
            self.showAlertWithOneAction(title: "Something went wrong", message: "Are you sure that this is image", alertActionTitle: "Accept")
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
        case .home:
            showAlertWithOneAction(title: "Error", message: "Something went wrong", alertActionTitle: "OK")
        }
    }
}
