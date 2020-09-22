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
        showSideMenu()
    }
}
