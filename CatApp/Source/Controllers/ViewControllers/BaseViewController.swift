//
//  BaseViewController.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/21/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import SideMenu
import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .black
    }
    
    @IBAction private func hamburgerButtonOnClick() {
        showSideMenu()
    }
}
