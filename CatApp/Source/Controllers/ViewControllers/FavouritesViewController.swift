//
//  FavouritesViewController.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 10/14/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import UIKit

class FavouritesViewController: BaseViewController {
    @IBOutlet fileprivate weak var tableView: UITableView!
    var favs: [FavouriteModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favourites"
    }
}

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "favCell")
            as? FavCell {
            cell.configure(url: (favs?[indexPath.row].image?.url) ?? "")
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
