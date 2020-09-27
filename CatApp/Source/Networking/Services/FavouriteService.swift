//
//  FavouriteService.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/26/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import SwiftyJSON

class FavouriteService: BaseWebService {
    class func addFavourite(_ imageId: String, subId: String, callback: @escaping (_ message: String) -> Void, errorHandler: @escaping ErrorHandler) {
        
        let url = BaseWebService.getBaseURL() + "favourites"
        
        let params = ["image_id": imageId, "sub_id": subId]
        
        NetworkManager.sharedInstance.POST(url, params: params, completionHandler: processResponse({ (data) -> Void in
            
            if data != nil {
                
                let response = JSON(data!)
                
                if let response = response["message"].string {
                    return callback(response)
                } else {
                    return callback("Error")
                }
            }
            
            errorHandler(NSError.initWithMessage("Error adding to favourites"))
            
            }, errorHandler: errorHandler))
    }
}


