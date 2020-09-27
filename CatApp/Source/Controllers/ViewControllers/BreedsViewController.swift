//
//  BreedsViewController.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/21/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import UIKit

class BreedsViewController: BaseViewController {
    @IBOutlet fileprivate weak var tableView: UITableView!
    var breedsArray: [BreedModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BreedsViewController: UITableViewDelegate, UITableViewDataSource {
    // UITableViewDelegates and UITableViewDataSource functions.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breedsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BreedCell") as? BreedCell {
            cell.configure(breedName: breedsArray?[indexPath.row].name ?? "")
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedBreed = breedsArray?[indexPath.row] else { return }
        goToBreedDetail(breed: selectedBreed)
    }
}
