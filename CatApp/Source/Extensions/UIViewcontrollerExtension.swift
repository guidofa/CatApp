//
//  UIViewcontrollerExtension.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/21/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import UIKit
import SideMenu

extension UIViewController {
    func showSideMenu() {
        if let sideMenu = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "SideMenuViewController")
            as? SideMenuViewController {
            if let navigationDelegate = self as? NavigationDelegate {
                sideMenu.delegate = navigationDelegate
            }
            let menu = SideMenuNavigationController(rootViewController: sideMenu)
            menu.leftSide = true
            
            present(menu, animated: true, completion: nil)
        }
    }
    
    func goToBreeds(with breedsArray: [BreedModel]?) {
        if let breedsViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "BreedsViewController")
            as? BreedsViewController, let unwrappedBreeds = breedsArray {
            breedsViewController.breedsArray = unwrappedBreeds
            navigationController?.pushViewController(breedsViewController, animated: true)
        }
    }
    
    func goToBreedDetail(breed: BreedModel) {
        if let breedDetailViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "BreedDetailViewController")
            as? BreedDetailViewController {
            breedDetailViewController.breed = breed
            navigationController?.pushViewController(breedDetailViewController, animated: true)
        }
    }
    
    func showAlert(title: String, message: String, alertActionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: alertActionTitle, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
