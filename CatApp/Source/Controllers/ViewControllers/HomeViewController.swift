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
        if let sideMenu = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "SideMenuViewController")
            as? SideMenuViewController {
            let menu = SideMenuNavigationController(rootViewController: sideMenu)
            menu.leftSide = true
            SideMenuManager.default.leftMenuNavigationController = menu
            SideMenuManager.default.addPanGestureToPresent(toView: view)
            present(menu, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//        BreedService.getBreeds({ (breeds) in
//            for breed in breeds {
//                print(breed.name ?? "Unnamed")
//            }
//        }, errorHandler: { (error) -> Void in
//            print(error?.localizedDescription ?? "")
//        })
