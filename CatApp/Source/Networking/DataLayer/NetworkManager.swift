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
        
        
        
        if let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
            defaultHeaders["X-App-Version"] = appVersion
        }
        
        defaultHeaders["X-Device"] = UIDevice.current.model + " - "
            + UIDevice.current.systemName + " " + UIDevice.current.systemVersion
        
        defaultHeaders["X-API-Version"] = "1.0"
        defaultHeaders["X-Timestamp"] = "\(Date().timeIntervalSince1970)"
        defaultHeaders["User-Agent"] = "iOS"
        
        let configuration = URLSessionConfiguration.default
        configuration.headers = defaultHeaders
//        configuration.httpAdditionalHeaders = defaultHeaders
        manager = Alamofire.Session(configuration: configuration)
    }
    
    func stopAllPendingTasks() {
        manager?.session.invalidateAndCancel()
    }
    
    func performMultipart(_ url: String, appendParamsCallback: @escaping (_ multipart: MultipartFormData) -> Void,
                          completion: @escaping (NetworkResponse)) {
        
        var defaultHeaders = HTTPHeaders.default
        
        if let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
            defaultHeaders["X-App-Version"] = appVersion
        }
        
        defaultHeaders["X-Device"] = UIDevice.current.model + " - "
            + UIDevice.current.systemName + " " + UIDevice.current.systemVersion
        
        defaultHeaders["X-API-Version"] = "1.0"
        defaultHeaders["X-Timestamp"] = "\(Date().timeIntervalSince1970)"
        defaultHeaders["User-Agent"] = "iOS"
        
        manager?.upload(multipartFormData: appendParamsCallback,
                        to: url,
                        usingThreshold: UInt64.max,
                        method: .post,
                        headers: defaultHeaders)
            .responseJSON(completionHandler: { (result) in
                            switch result.result {
                            case .success(let value):
                                completion(value as AnyObject, nil, result.response)
                            case .failure(let error):
                                completion(nil, NSError.initWithMessage(error.localizedDescription), result.response)
                            }
                        })
    }
}
