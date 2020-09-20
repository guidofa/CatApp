//
//  HomeViewController.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/19/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController {
    @IBOutlet fileprivate weak var catImage: UIImageView!
    @IBAction private func buttonOnClick() {
        // Do something
    }
    @IBAction private func hamburgerButtonOnClick() {
        present(sideMenu,animated: true)
    }
    
    fileprivate let sideMenu = SideMenuNavigationController(rootViewController: UIViewController())
    fileprivate var image = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
    }
}

//        BreedService.getBreeds({ (breeds) in
//            for breed in breeds {
//                print(breed.name ?? "Unnamed")
//            }
//        }, errorHandler: { (error) -> Void in
//            print(error?.localizedDescription ?? "")
//        })
