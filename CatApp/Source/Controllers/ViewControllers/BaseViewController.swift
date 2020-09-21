//
//  BaseViewController.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/21/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import SideMenu

class BaseViewController: UIViewController {
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
}
