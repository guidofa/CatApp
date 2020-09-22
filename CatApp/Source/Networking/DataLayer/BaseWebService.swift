//
//  BaseWebService.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/20/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import SwiftyJSON
import SVProgressHUD

typealias SuccessHandler = (_ data: AnyObject?) -> Void
typealias ErrorHandler = (_ error: NSError?) -> Void
typealias ResponseHandler = (_ data: AnyObject?, _ error: NSError?, _ response: HTTPURLResponse?) -> Void

let AUTHENTICATION_FAILED_MESSAGE = "Authorization has been denied for this request."

class BaseWebService {
    
    //Must be lowercase and trimmed off "." and white spaced & new lines.
    class func processResponse(_ callback:@escaping SuccessHandler, errorHandler:@escaping ErrorHandler) -> ResponseHandler {
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
                        } else if resp.statusCode == 401 {
                            SVProgressHUD.dismiss()
                            
                            let data = JSON(data!)
                            if let userIsBlocked = data["blocked"].bool, userIsBlocked == true {
                                let errorMessage = data["message"].string ??
                                "Ooops! Looks like something went wrong. Please try again."
                                    customError = NSError.initWithMessage(errorMessage)
                                    
                                    //Delay this to get the blocked loading screen time to animate and appear
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                                        if let shouldAllowRelogin = data["should_allow_relogin"].bool {
                                            if shouldAllowRelogin {
                                                
                                            } else {
                                                
                                            }
                                        }
                                    })
                            } else {
                            }
                            return //Stop processing if it was a 401
                        } else if let errorDescription = jsonData["error_description"].string {
                            customError = NSError.initWithMessage(errorDescription)
                        } else {
                            customError = NSError.initWithMessage("Unknown Error")
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
