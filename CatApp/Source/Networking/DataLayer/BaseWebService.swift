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

class BaseWebService: NSObject {
    
    //Must be lowercase and trimmed off "." and white spaced & new lines.
    static var whitelist_errors = [
        "the operation couldn’t be completed. software caused connection abort",
        "a server with the specified hostname could not be found",
        "cancelled",
        "could not connect to the server",
        "the internet connection appears to be offline",
        "the network connection was lost",
        "urlrequest creation failed with error: cancelled",
        "urlsessiontask failed with error: cancelled",
        "urlsessiontask failed with error: the network connection was lost",
        "urlsessiontask failed with error: the request timed out",
        "the certificate for this server is invalid. you might be connecting to a server that is pretending to be “api.bambinoapp.com” which could put your confidential information at risk",
        "session was invalidated without error, so it was likely deinitialized unexpectedly. be sure to retain a reference to your session for the duration of your requests"]

    class func processResponse(_ callback:@escaping SuccessHandler, errorHandler:@escaping ErrorHandler) -> ResponseHandler {
        return { (data, error, response) -> Void in
            
            var customError = error
            
            if error == nil {
                if let resp = response {
                    if data != nil {
                        let jsonData = JSON(data!)
                        
                        if let errors = jsonData["errors"].string {
                            TrackingManager.sharedInstance.sendEvent(
                                TrackingManager.sharedInstance.EVENT_ERROR,
                                properties: ["errors": errors])
                        }
                        
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
                                        
                                    AppDelegate.goToBlockedLoadingScreen()
                                    
                                    //Delay this to get the blocked loading screen time to animate and appear
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                                        if let shouldAllowRelogin = data["should_allow_relogin"].bool {
                                            if shouldAllowRelogin {
                                                TrackingManager.sharedInstance.sendEvent(
                                                    TrackingManager.sharedInstance.EVENT_USER_VOIP_REGISTER)
                                                AppDelegate.showAlertWithOk("", message: errorMessage) { (_) in
                                                    AppDelegate.goToLogin()
                                                }
                                            } else {
                                                AppDelegate.showAlert("", message: errorMessage)
                                            }
                                        }
                                    })
                            } else {
                            
                                AppDelegate.showAlertWithOk(
                                    "",
                                    message: ConfigData.sharedInstance.sessionExpiredPopupMsg,
                                    handler: { (_) in
                                        AppDelegate.goToLogin()
                                })
                            }
                            return //Stop processing if it was a 401
                        } else if let errorDescription = jsonData["error_description"].string {
                            customError = NSError.initWithMessage(errorDescription)
                        } else {
                            customError = NSError.initWithMessage("Unknown Error")
                        }
                    }
                }
            } else if whitelist_errors.contains(
                error?.localizedDescription
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                    .trimmingCharacters(in: ["."])
                    .lowercased() ?? "") {
                
                TrackingManager.sharedInstance.sendEvent(
                    TrackingManager.sharedInstance.EVENT_HIDDEN_ERROR,
                    properties: ["error_description": error!.localizedDescription])
                customError = nil
            }
            
            TrackingManager.sharedInstance.sendEvent(
                TrackingManager.sharedInstance.EVENT_ERROR,
                properties: ["error_description": customError?.localizedDescription ?? ""])
            
            errorHandler(customError)
            
        }
    }
    
    class func getBaseURL() -> String {
        return AppConfig.sharedInstance().baseURL()
    }
}

