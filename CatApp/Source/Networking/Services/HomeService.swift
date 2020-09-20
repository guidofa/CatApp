//
//  HomeService.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/20/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import SwiftyJSON

class HomeService: BaseWebService {
    class func getRandomCat(_ callback :@escaping (_ randomcatModel: RandomCatResponseModel) -> Void, errorHandler:@escaping ErrorHandler) {
    
    let searchURL = BaseWebService.getBaseURL() + "images/search"
    
    NetworkManager.sharedInstance.GET(searchURL,
                                      params: nil,
                                      completionHandler: processResponse({ (data) -> Void in
        
        if data != nil {
            
            let response = JSON(data!)
            let responseArray = response.array
            let randomCatModel = RandomCatResponseModel(json: (responseArray?[0])!)
            
            return callback(randomCatModel)
        }
    
        errorHandler(NSError.initWithMessage("Error parsing Get Random Cat Response"))
        
        }, errorHandler: errorHandler))
    }
}
