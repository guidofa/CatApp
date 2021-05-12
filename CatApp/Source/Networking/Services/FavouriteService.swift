//
//  FavouriteService.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/26/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import SwiftyJSON

class FavouriteService: BaseWebService {
    class func addFavourite(_ imageId: String, subId: String, callback: @escaping (_ favID: String?) -> Void,
                            errorHandler: @escaping ErrorHandler) {
        let url = BaseWebService.getBaseURL() + "favourites"
        let params = ["image_id": imageId, "sub_id": subId]
        NetworkManager.sharedInstance.POST(url, params: params, completionHandler: processResponse( { (data) -> Void in
            if data != nil {
                let response = JSON(data!)
                if let favId = response["id"].int {
                    return callback(String(favId))
                } else {
                    return callback(nil)
                }
            }
            errorHandler(NSError.initWithMessage("Error adding to favourites"))
            
            }, errorHandler: errorHandler))
    }
    
    class func getFavourites(subId: String, callback: @escaping (_ fav: [FavouriteModel]) -> Void, errorHandler: @escaping ErrorHandler) {
        let url = BaseWebService.getBaseURL() + "favourites?sub_id=" + subId
        NetworkManager.sharedInstance.GET(url, params: nil, completionHandler: processResponse( { (data) -> Void in
            if data != nil {
                var favArray: [FavouriteModel] = []
                let response = JSON(data!)
                let responseArray = response.arrayValue
                for respElement in responseArray {
                    favArray.append(FavouriteModel(json: respElement))
                }
                return callback(favArray)
            }
            errorHandler(NSError.initWithMessage("Error getting the favourites"))
            
        }, errorHandler: errorHandler))
    }
    
    // This method has not been tried
    class func deleteFavourite(favId: String, callback: @escaping (_ message: String) -> Void, errorHandler: @escaping ErrorHandler) {
        let url = BaseWebService.getBaseURL() + "favourites/" + String(favId)
        NetworkManager.sharedInstance.DELETE(url, params: nil, completionHandler: processResponse( { (data) -> Void in
            if data != nil {
                let response = JSON(data!)
                let message = response["message"].stringValue
                return callback(message)
            } else {
                return callback("No message")
            }
        }, errorHandler: errorHandler))
    }
}


