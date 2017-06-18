//
//  AFWrapper.swift
//  EverydayApp
//
//  Created by Danijel on 11/06/2017.
//  Copyright © 2017 NELI_IT. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import SwiftyJSON
import PromiseKit

let internetConnectionError = "internetConnectionError"

class AFWrapper {
    
    //
    // Wrapped request method which handles network connectivity issues, 
    // maps the json response to a declared classType and saves cookies
    //
    static func request<T: Mappable>(url: String,
                                     httpMethod: HTTPMethod = .get,
                                     classType: T.Type,
                                     success:@escaping (T) -> Void,
                                     failure:@escaping (NSError) -> Void) {
        
        Alamofire.request(url, method: httpMethod)
            .validate(statusCode: 200..<300)
            .responseJSON { (response) -> Void in
                
                let statusCode = response.response?.statusCode != nil ? response.response?.statusCode : -666
                
                //print(response)

                //Trigger notification if network connectivity issues occure
                //statusCode 401 should not be treated as an error!!
                if response.result.error != nil && statusCode != 401 {
                    let error = NSError(domain: url, code: statusCode!, userInfo: nil)
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: internetConnectionError), object: nil)
                    failure(error)
                    return
                }
                
                //Try to map the json response to the classType
                if response.result.isSuccess {
                    let responseObject = Mapper<T>().map(JSONObject: response.result.value)
                    guard responseObject != nil else {
                        let error: NSError = response.result.error! as NSError
                        failure(error)
                        return
                    }
                    
                    success(responseObject!)
                }
                
                if response.result.isFailure {
                    let error = NSError(domain: url, code: statusCode!, userInfo: nil)
                    failure(error)
                }
        }
    }
    
    static func request<T: Mappable>(url: String,
                        httpMethod: HTTPMethod = .get,
                        classType: T.Type,
                        parameters: Parameters,
                        success:@escaping (T) -> Void,
                        failure:@escaping (NSError) -> Void) {
        
        Alamofire.request(url, method: httpMethod, parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseJSON { (response) -> Void in
                
                let statusCode = response.response?.statusCode != nil ? response.response?.statusCode : -666
                
                //print(response)
                
                //Trigger notification if network connectivity issues occure
                //statusCode 401 should not be treated as an error!!
                if response.result.error != nil && statusCode != 401 {
                    let error = NSError(domain: url, code: statusCode!, userInfo: nil)
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: internetConnectionError), object: nil)
                    failure(error)
                    return
                }
                
                //Try to map the json response to the classType
                if response.result.isSuccess {
                    let responseObject = Mapper<T>().map(JSONObject: response.result.value)
                    guard responseObject != nil else {
                        let error: NSError = response.result.error! as NSError
                        failure(error)
                        return
                    }
                    
                    success(responseObject!)
                }
                
                if response.result.isFailure {
                    let error = NSError(domain: url, code: statusCode!, userInfo: nil)
                    failure(error)
                }
        }
    }
   
}
