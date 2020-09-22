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
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BreedsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

//        BreedService.getBreeds({ (breeds) in
//            for breed in breeds {
//                print(breed.name ?? "Unnamed")
//            }
//        }, errorHandler: { (error) -> Void in
//            print(error?.localizedDescription ?? "")
//        })
