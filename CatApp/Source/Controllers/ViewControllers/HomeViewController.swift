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
    @IBOutlet fileprivate weak var footerView: UIView!
    @IBOutlet fileprivate weak var favImageView: UIImageView!
    @IBAction private func nextCat() {
        setACatImage()
    }
    @IBAction private func addFavourite() {
        addTheImageToFavourite()
    }
    fileprivate var imageId: String?
    fileprivate enum HeartImages: String {
        case activeHeart = "heart_active"
        case inactiveHeart = "heart_inactive"
    }
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        styleFooterView()
        setACatImage()
    }
    
    func styleFooterView() {
        footerView.layer.borderWidth = 1
        footerView.layer.borderColor = ColorHelper.cobaltTurquoise().cgColor
    }
    
    func setACatImage() {
        view.showLoader()
        HomeService.getRandomCat({ (randomCat) in
            self.imageId = randomCat.id
            self.catImageView.load(url: URL(string: randomCat.url!)!, vc: self)
        }, errorHandler: { (error) -> Void in
            self.view.hideLoader()
            print(error?.localizedDescription ?? "")
        })
    }
    
    func addTheImageToFavourite() {
        favImageView.image = UIImage(named: HeartImages.activeHeart.rawValue)
        guard let id = imageId else { return }
        FavouriteService.addFavourite(id, subId: AppConfig.shared.getUserId(), callback: { (_) in
            
        }, errorHandler: { (error) -> Void in
            self.showAlertWithOneAction(title: "Something went wrong",
                                        message: "Are you sure that this is image is not already in your favourites?",
                                        alertActionTitle: "Accept")
        })
    }
    
    func imageLoaded() {
        favImageView.image = UIImage(named: HeartImages.inactiveHeart.rawValue)
        view.hideLoader()
    }
}

extension HomeViewController: NavigationDelegate {
    func goToNextView(_ toView: MenuOptions) {
        switch toView {
        case .breeds:
            view.showLoader()
            BreedService.getBreeds({ (breeds) in
                self.view.hideLoader()
                self.goToBreeds(with: breeds)
            }, errorHandler: { (error) -> Void in
                self.view.hideLoader()
                print(error?.localizedDescription ?? "")
            })
        case .favourites:
            view.showLoader()
            FavouriteService.getFavourites(subId: AppConfig.shared.getUserId(),
                                           callback: { (favourites) in
                                            self.view.hideLoader()
                                            self.goToFavourites(favs: favourites)
                                           }, errorHandler: { (error) in
                                            self.view.hideLoader()
                                            print(error?.localizedDescription ?? "")
                                           })
        case .home:
            showAlertWithOneAction(title: "Error", message: "Something went wrong", alertActionTitle: "OK")
        }
    }
}
