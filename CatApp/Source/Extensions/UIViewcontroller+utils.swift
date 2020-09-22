//
//  UIViewcontroller+utils.swift
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
    
    func goToBreeds() {
        if let breeds = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "BreedsViewController")
            as? BreedsViewController {
            navigationController?.pushViewController(breeds, animated: true)
        }
    }
}
