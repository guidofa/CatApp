//
//  BaseWebService.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/20/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import SwiftyJSON

typealias SuccessHandler = (_ data: AnyObject?) -> Void
typealias ErrorHandler = (_ error: NSError?) -> Void
typealias ResponseHandler = (_ data: AnyObject?, _ error: NSError?, _ response: HTTPURLResponse?) -> Void


class BaseWebService {
    
    //Must be lowercase and trimmed off "." and white spaced & new lines.
    class func processResponse(_ callback: @escaping SuccessHandler, errorHandler: @escaping ErrorHandler) -> ResponseHandler {
        return { (data, error, response) -> Void in
            
            var customError = error
            
            if error == nil {
                if let resp = response {
                    if data != nil {
                        let jsonData = JSON(data!)
                        
                        if let errors = jsonData["errors"].arrayObject {
                            
                            var errorMsg = "Unknown error"
                            
                            if let err = errors.first as? String {
                                errorMsg = err
                            }

                            customError = NSError.initWithMessage(errorMsg)
                            
                        } else if resp.statusCode >= 200 && resp.statusCode < 400 {
                            callback(data)
                            return
                        }  else if let errorDescription = jsonData["error_description"].string {
                            customError = NSError.initWithMessage(errorDescription)
                        } else if resp.statusCode == 400 {
                            print("esta saliendo por aca")
                        } else {
                            
                        }
                    }
                }
            } 
            errorHandler(customError)
        }
    }
    
    class func getBaseURL() -> String {
        return AppConfig.shared.getBaseURL()
    }
}
