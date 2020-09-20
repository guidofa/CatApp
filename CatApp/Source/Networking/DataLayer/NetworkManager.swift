//
//  NetworkManager.swift
//  CatApp
//
//  Created by Macbook Pro Nimble on 9/20/20.
//  Copyright © 2020 Guido Fabio. All rights reserved.
//

import Alamofire

typealias NetworkResponse = (_ data: AnyObject?, _ error: NSError?, _ response: HTTPURLResponse?) -> Void

class NetworkManager: NSObject {
    
    // MARK: Singleton
    class var sharedInstance: NetworkManager {
        struct Static {
            static let instance = NetworkManager()
        }
        return Static.instance
    }
    
    var manager: Session?
    
    override init() {
        super.init()
        reconfigureHeaders()
    }
    
    func POST(_ url: String, params: [String: Any]?, completionHandler:@escaping (NetworkResponse)) {
        performHTTPMethod(JSONEncoding.default,
                          url: url,
                          params: params,
                          completionHandler: completionHandler,
                          method: .post)
    }
    
    func PUT(_ url: String, params: [String: Any]?, completionHandler:@escaping (NetworkResponse)) {
        performHTTPMethod(JSONEncoding.default,
                          url: url,
                          params: params,
                          completionHandler: completionHandler,
                          method: .put)
    }
    
    fileprivate func performHTTPMethod(_ encoding: ParameterEncoding, url: String, params: [String: Any]?, completionHandler:@escaping (NetworkResponse), method: HTTPMethod) {
        
        manager?.request(url, method: method, parameters: params, encoding: encoding, headers: nil)
            .responseJSON(completionHandler: { (result) -> Void in
            
            switch result.result {
            case .success(let value):
                completionHandler(value as AnyObject, nil, result.response)
            case .failure(let error):
                completionHandler(nil, NSError.initWithMessage("\(error.localizedDescription)"), result.response)
            }
        })
    }
    
    func GET(_ url: String, params: [String: Any]?, completionHandler:@escaping (NetworkResponse)) {
        
        manager?.request(url, method: .get, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .responseJSON(completionHandler: { (result) -> Void in
            
            switch result.result {
            case .success(let value):
                completionHandler(value as AnyObject, nil, result.response)
            case .failure(let error):
                completionHandler(nil, NSError.initWithMessage("\(error.localizedDescription)"), result.response)
            }
        })
    }
    
    func reconfigureHeaders() {
        var defaultHeaders = HTTPHeaders.default
        defaultHeaders["x-api-key"] = AppConfig.shared.getApiKey()
        let configuration = URLSessionConfiguration.default
        configuration.headers = defaultHeaders
        manager = Alamofire.Session(configuration: configuration)
    }
    
    func stopAllPendingTasks() {
        manager?.session.invalidateAndCancel()
    }
}
