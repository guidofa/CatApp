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
    @IBAction private func hamburgerButtonOnClick() {
        showSideMenu()
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        styleNavBar()
        
    }
    
    func styleNavBar() {
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: UIFont(name: "GillSans", size: 21)!]
    }
}
