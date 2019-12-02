//
//  WebApiController.swift
//  CrewDemo
//
//  Created by Wasim on 13/11/19.
//  Copyright © 2019 Wasim. All rights reserved.
//

import Foundation
import Alamofire


typealias SuccessResponse = (AnyObject?) -> Void
typealias FailureResponse = (NSError?) -> Void
typealias ResponseBlock = (URLRequest?, HTTPURLResponse?, Data?, NSError?) -> Void

class WebApiController {
    
    static let sharedInstance:WebApiController = WebApiController()
    var configuration = URLSessionConfiguration.default
    var manager:Alamofire.SessionManager = Alamofire.SessionManager()
    var user_id:String?
    
    fileprivate init() {
        configuration = URLSessionConfiguration.default
        let cookies = HTTPCookieStorage.shared
        configuration.httpCookieStorage = cookies
        configuration.timeoutIntervalForRequest = 60
        configuration.allowsCellularAccess = true
        configuration.httpMaximumConnectionsPerHost = 4
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "apps.crewdemo.com": .disableEvaluation
        ]
        manager = Alamofire.SessionManager.init(configuration: configuration,
                                                delegate:SessionDelegate(),
                                                serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
        
    }
    
    @discardableResult
    func send(_ payload:HttpPayload, request:DataRequest, onSuccess: @escaping SuccessResponse, onFailure: @escaping FailureResponse) -> DataRequest {
        
        if request.request?.httpBody == nil {
            print("\nRequest \(request.request?.urlRequest as URLRequest?)** \nParams \n\(payload.paramDict) ")
        } else {
            // print("\nRequest \(request.request?.urlRequest as URLRequest?) \nParams \n\(NSString.init(data: (request.request?.httpBody)!, encoding: String.Encoding.utf8.rawValue))")
            //            print("\nRequest \(request.request?.urlRequest as URLRequest?) \n Params: \n\(payload.paramDict)")
            print("\nRequest \(String(describing: request.request?.urlRequest)) \nParams \n\(String(describing: NSString.init(data: (request.request?.httpBody)!, encoding: String.Encoding.utf8.rawValue)))")
        }
        DispatchQueue.main.async {
            UIApplication.shared.isIdleTimerDisabled = true
        }
        
        
        request.responseString { (response:DataResponse<String>) in
            
            DispatchQueue.main.async {
                UIApplication.shared.isIdleTimerDisabled = false
            }
            
            switch(response.result) {
                
            case .success(_):
                let data:NSData = NSData.init(data: response.data!)
                do {
                    let JSON = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.allowFragments)
                    print("Response \(JSON)")
                    onSuccess(JSON as AnyObject?)
                    
                    
                } catch {
                    
                    if (response.result.value != nil) {
                        print("StatusCode \(String(describing: response.response?.statusCode))")
                    }
                    
                    let error = NSError.init(domain: "Json", code: 1001, userInfo:  [String : Any]())
                    onFailure(error)
                    
                    print("Json Error : \(String(describing: NSString.init(data:data as Data, encoding: String.Encoding.utf8.rawValue)))")
                }
                
                break
            case .failure(_) :
                
                if (response.result.value != nil){
                    print("StatusCode \(response.response?.statusCode as Int?)")
                }
                
                if(payload.retry >= 10) {
                    onFailure(response.result.error as NSError?)
                    return
                }
                let error = response.result.error! as NSError
                
                if (error.code == -1005 || error.code == -1001 && payload.retry < 1) {
                    print("Retrying \(error)")
                    
                    payload.retry += 1
                    self.send(payload, request:request,  onSuccess: onSuccess, onFailure: onFailure)
                    return
                }
                print("Error \(error)")
                
                onFailure(error)
                break
                
            }
        }
        
        return request
    }
    
    @discardableResult
    func sendURLEncodeBody(_ payload:HttpPayload, onSuccess: @escaping SuccessResponse, onFailure: @escaping FailureResponse) -> Request {
        let request = manager.request(payload.url,
                                      method: payload.method,
                                      parameters: payload.paramDict as? Parameters,
                                      encoding: URLEncoding.default,
                                      headers: payload.headers)
        
        self.send(payload, request: request, onSuccess: onSuccess, onFailure: onFailure)
        return request
    }
    
    @discardableResult
    func sendJsonEncodeBody(_ payload:HttpPayload, onSuccess: @escaping SuccessResponse, onFailure: @escaping FailureResponse) -> Request {
        let request = manager.request(payload.url,
                                      method: payload.method,
                                      parameters: payload.paramDict as? Parameters,
                                      encoding: JSONEncoding.default,
                                      headers: payload.headers)
        
        self.send(payload, request: request, onSuccess: onSuccess, onFailure: onFailure)
        return request
    }
    
    func downloadVideoFromUrl(url: URL, fileName: String, onSuccess: @escaping SuccessResponse, onFailure:@escaping FailureResponse) {
        
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(fileName)
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        self.manager.download(url, to: destination).response { (response) in
            
            print(response)
            
            if response.response?.statusCode == 200 {
                onSuccess(response.response)
                
            } else {
                onFailure(NSError())
            }
        }
    }
    
    func cancelVideoDownloadRequest() {
        
        print("Cancelled Download request.")
        // Cancel the current download request
    }
    
    func putMultiPartFormData(_ payload:HttpPayload, onSuccess: @escaping SuccessResponse, onFailure:@escaping FailureResponse) {
        
        
        self.manager.upload(multipartFormData: { (formData: MultipartFormData) in
            for key in payload.paramDict.allKeys as! [String] {
                let value = payload.paramDict.object(forKey: key)
                if value is Data {
                    
                    formData.append(value as! Data, withName: key)
                    //                    formData.appendBodyPart(data: value as! NSData, name: key, fileName: "\(key).jpg", mimeType: "image/jpg")
                } else if value is Dictionary<String, Any> {
                    
                    let subDict:Dictionary = value as! Dictionary<String, Any>
                    formData.append(NSKeyedArchiver.archivedData(withRootObject: subDict), withName: key)
                    
                } else {
                    let strVal:String = value as! String
                    let data: NSData = strVal.data(using: String.Encoding.utf8)! as NSData
                    formData.append(data as Data, withName: key)
                }
            }
        }, to: payload.url, encodingCompletion: { (encodingResult: SessionManager.MultipartFormDataEncodingResult) in
            
            print(encodingResult)
            switch encodingResult {
            case .success(let request, _, _):
                
                request.responseJSON(completionHandler: { (response:DataResponse<Any>) in
                    
                    var jsonResults:Any
                    do {
                        jsonResults = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments)
                        // success ...
                        onSuccess(jsonResults as AnyObject?)
                        
                    } catch {
                        // failure
                        onFailure(error as NSError?)
                    }
                })
                break
            case .failure(_):
                onFailure(nil)
                break
            }
            
        })
        
    }
    
}

