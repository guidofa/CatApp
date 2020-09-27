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
        
        NetworkManager.sharedInstance.POST(url, params: params, completionHandler: processResponse( { (data) -> Void in
            
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
    
    class func getFavourites(subId: String, callback: @escaping (_ fav: [FavouriteModel]) -> Void, errorHandler: @escaping ErrorHandler) {
        let url = BaseWebService.getBaseURL() + "favourites" + "?sub_id=jhondoe123"
        let params = ["sub_id": subId, "limit": "10", "page": "1"]
        
        NetworkManager.sharedInstance.GET(url, params: nil, completionHandler: processResponse( { (data) -> Void in
            if data != nil {
                
                var favArray: [FavouriteModel] = []
                let response = JSON(data!)
                let responseArray = response.arrayValue
                for res in responseArray {
                    favArray.append(FavouriteModel(json: res))
                }
                
                return callback(favArray)
            }
            errorHandler(NSError.initWithMessage("Error getting the favourites"))
            
        }, errorHandler: errorHandler))
    }
}


