//
//  UIViewExtension.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/22/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import Foundation
import SVProgressHUD

extension UIView {
  func showLoader() {
    SVProgressHUD.show(withStatus: "Loading")
    self.isUserInteractionEnabled = false
  }
  
  func hideLoader() {
    SVProgressHUD.dismiss()
    self.isUserInteractionEnabled = true
  }
}
