//
//  BreedService.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/20/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import SwiftyJSON

class BreedService: BaseWebService {
    class func getBreeds(_ callback :@escaping (_ breeds: [BreedModel]) -> Void, errorHandler:@escaping ErrorHandler) {
    
    let searchURL = BaseWebService.getBaseURL() + "breed"
    
    NetworkManager.sharedInstance.GET(searchURL,
                                      params: nil,
                                      completionHandler: processResponse({ (data) -> Void in
        
        if data != nil {
            
            let response = JSON(data!)
            guard let responseArray = response.array else { return }
            var breedArray: [BreedModel] = []
            for breed in responseArray {
                let breedObject = BreedModel(json: breed)
                breedArray.append(breedObject)
            }
            
            
            return callback(breedArray)
        }
    
        errorHandler(NSError.initWithMessage("Error parsing Get Random Cat Response"))
        
        }, errorHandler: errorHandler))
    }
}
