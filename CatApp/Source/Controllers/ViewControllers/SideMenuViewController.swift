//
//  SideMenuViewController.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/20/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import UIKit

enum MenuOptions {
    case home
    case breeds
    case favourites
}
class SideMenuViewController: UIViewController {
    @IBOutlet fileprivate var tableView: UITableView!
    fileprivate let menuItems: [String] = ["Home", "Breeds"]
    weak var delegate: NavigationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        navigationController?.navigationBar.barTintColor = ColorHelper.cobaltTurquoise()
    }
}

extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as? MenuCell {
            cell.configure(title: menuItems[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 2:
            dismiss(animated: true) {
                self.delegate?.goToNextView(.favourites)
            }
        case 1:
            dismiss(animated: true) {
                self.delegate?.goToNextView(.breeds)
            }
        case 0:
            dismiss(animated: true, completion: nil)
        default:
            print("error")
        }
    }
}
