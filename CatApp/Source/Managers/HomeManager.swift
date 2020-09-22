//
//  HomeManager.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/21/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import UIKit

class HomeManager {
    public class var shared: HomeManager {
        struct Static {
            static let instance = HomeManager()
        }
        return Static.instance
    }
    
    func getImageUrlString(callback: ((_ url: String?, _ error: NSError?) -> Void)?) {
        HomeService.getRandomCat({ (cat) in
            callback?(cat.url, nil )
        }, errorHandler: { (error) -> Void in
            callback?(nil, error)
        })
    }
//        ReservationsService.confirmReservation(reservationRequestID,
//                                               selectedSitterID: selectedSitterID,
//                                               promoCode: promoCode,
//                                               callback: { (success) -> Void in
//
//            if success {
//                callback!(true, nil)
//            }
//
//            ParentHomeManager.sharedInstance.clearCache()
//
//        }, errorHandler: { (error) -> Void in
//            callback?(false, error)
//        })
//    }
}
