//
//  HomeViewController.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/19/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet fileprivate weak var catImage: UIImageView!
    @IBAction private func buttonOnClick() {
        getNewImage()
    }
    fileprivate var image = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        getNewImage()
    }

    func getNewImage () {
        let url = "https://api.thecatapi.com/v1/images/search?api_key=b18d7524-957f-4abe-8a38-bceb8603e3b9"
        getData(from: url)
    }
    
    private func getData(from url: String) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }
            
            var result: Array<ResponseForRandomCat>?
            do {
                result = try JSONDecoder().decode(Array<ResponseForRandomCat>.self, from: data)
            } catch {
                print("Fail \(error.localizedDescription)")
            }
            guard let json = result else {
                return
            }
            for cat in json {
                self.image = cat.url ?? ""
            }
            self.showUrl()
        })
        task.resume()
    }
    
    func showUrl() {
        let url = URL(string: image)
        let data = try? Data(contentsOf: url!)
        DispatchQueue.main.async {
            self.catImage.image = UIImage(data: data!)
        }
    }
}
