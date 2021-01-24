//
//  AFApiClient.swift
//  SimpleApps
//
//  Created by lucy on 13/06/19.
//  Copyright © 2019 lucy. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias resultHandler = (JSON?,Error?)

class AFApiClient: NSObject {
    
    func request(httpMethod: Alamofire.HTTPMethod , urlString: String, requestHendler: @escaping (resultHandler) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        var requestResult: (jsonData: JSON?, error: Error?)
        
        
        AF.request(urlString).responseJSON { response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            debugPrint(response)
            
            switch response.result {
            case .success:
                if let data = response.data {
                    requestResult.jsonData = JSON(data)
                    requestHendler(requestResult)
                }
            case .failure(let _error):
                requestResult.error = _error
                requestHendler(requestResult)
            }
        }
    }
    
    func requestCallBack(urlString: String, requestHendler: @escaping (resultHandler) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        var requestResult: (jsonData: JSON?, error: Error?)
        
        AF.request(urlString).responseString { response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            debugPrint(response)
            
            switch response.result {
            case .success:
                if let data = response.data {
                    requestResult.jsonData = JSON(data)
                    requestHendler(requestResult)
                }
            case .failure(let _error):
                requestResult.error = _error
                requestHendler(requestResult)
            }
        }
        
    }
    
    func request(param: [String: Any], httpMethod: Alamofire.HTTPMethod, paramEncoding: ParameterEncoding = URLEncoding.default , strUrl: String, requestHendler: @escaping (resultHandler) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        var requestResult: (jsonData: JSON?, error: Error?)
        
        AF.request(strUrl, method: httpMethod, parameters: param, encoding: paramEncoding, headers: [:])
            .responseJSON { response in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                print(response.request as Any)  // original URL request
                print(response.response as Any) // URL response
                print(response.result as Any)   // result of response serialization
                
                switch response.result {
                case .success:
                    if let data = response.data {
                        requestResult.jsonData = JSON(data)
                        requestHendler(requestResult)
                    }
                case .failure(let _error):
                    requestResult.error = _error
                    requestHendler(requestResult)
                }
        }
    }

    func cancelRequest() {
        if #available(iOS 9.0, *) {
            AF.session.getAllTasks { (tasks) in
                tasks.forEach({$0.cancel()})
            }
        } else {
            
        }
    }
}
