//
//  APIController.swift
//  CrewDemo
//
//  Created by Wasim on 13/11/19.
//  Copyright © 2019 Wasim. All rights reserved.
//

import Foundation

class APIController: WebApiController {
    
    //MARK: Http get Methods
    static func getWithUrl(_ strUrl: String, paramDict:NSDictionary, onSuccess: @escaping SuccessResponse, onFailure:@escaping FailureResponse) -> Void {
        let payload:HttpPayload = HttpPayload.getPayloadWithUrlParam(strUrl, paramDict: paramDict)
        WebApiController.sharedInstance.sendURLEncodeBody(payload, onSuccess: onSuccess, onFailure: onFailure)
    }
    //MARK: Http Post Methods
    static func postWithJson(_ strUrl: String, paramDict:NSDictionary, onSuccess: @escaping SuccessResponse, onFailure:@escaping FailureResponse) -> Void {
        let payload:HttpPayload = HttpPayload.postPayloadWithUrlParam(strUrl, paramDict: paramDict)
        WebApiController.sharedInstance.sendJsonEncodeBody(payload, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    //MARK: Http Put Methods
    static func putWithJson(_ strUrl: String, paramDict:NSDictionary, onSuccess: @escaping SuccessResponse, onFailure:@escaping FailureResponse) -> Void {
        let payload:HttpPayload = HttpPayload.putPayloadWithUrlParam(strUrl, paramDict: paramDict)
        WebApiController.sharedInstance.sendJsonEncodeBody(payload, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    static func putWithUrl(_ strUrl: String, paramDict:NSDictionary, onSuccess: @escaping SuccessResponse, onFailure:@escaping FailureResponse) -> Void {
        let payload:HttpPayload = HttpPayload.putPayloadWithUrlParam(strUrl, paramDict: paramDict)
        WebApiController.sharedInstance.sendURLEncodeBody(payload, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    //MARK: Http delete Method
    static func deleteWithUrl(_ strUrl: String, paramDict:NSDictionary, onSuccess: @escaping SuccessResponse, onFailure:@escaping FailureResponse) -> Void {
        
        let payload:HttpPayload = HttpPayload.deletePayloadWithUrlParam(strUrl, paramDict: paramDict)
        WebApiController.sharedInstance.sendURLEncodeBody(payload, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    
}
