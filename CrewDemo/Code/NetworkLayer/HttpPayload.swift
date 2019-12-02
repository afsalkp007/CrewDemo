//
//  HttpPayload.swift
//  CrewDemo
//
//  Created by Wasim on 13/11/19.
//  Copyright © 2019 Wasim. All rights reserved.
//

import Foundation
import Alamofire


 let baseURL     = "https://www.rosterbuster.aero/wp-content"

open class HttpPayload {
    
    var url:String = ""
    var paramDict:NSDictionary = NSDictionary()
    var method:Alamofire.HTTPMethod = Alamofire.HTTPMethod.get
    var retry:Int = 0
    var headers:[String : String] = [String : String]()
    
    open class func getPayloadWithUrlParam(_ urlString:String, paramDict:NSDictionary) -> HttpPayload {
        
        var httpPayload:HttpPayload = HttpPayload()
        httpPayload.method = Alamofire.HTTPMethod.get
        httpPayload.url = baseURL.appendingFormat("/%@", urlString)
        httpPayload.paramDict = paramDict
        httpPayload = setHeadersForPayload(httpPayload)
        return httpPayload
    }
    
    open class func postPayloadWithUrlParam(_ urlString:String, paramDict:NSDictionary) -> HttpPayload {
        var httpPayload:HttpPayload = HttpPayload()
        httpPayload.method = Alamofire.HTTPMethod.post
        httpPayload.url = baseURL.appendingFormat("/%@", urlString)
        httpPayload.paramDict = paramDict
        httpPayload = setHeadersForPayload(httpPayload)
        return httpPayload
    }
    
    open class func putPayloadWithUrlParam(_ urlString:String, paramDict:NSDictionary) -> HttpPayload {
        var httpPayload:HttpPayload = HttpPayload()
        httpPayload.method = Alamofire.HTTPMethod.put
        httpPayload.url = baseURL.appendingFormat("/%@", urlString)
        httpPayload.paramDict = paramDict
        httpPayload = setHeadersForPayload(httpPayload)
        
        return httpPayload
    }
    
    open class func deletePayloadWithUrlParam(_ urlString:String, paramDict:NSDictionary) -> HttpPayload {
        var httpPayload:HttpPayload = HttpPayload()
        httpPayload.method = Alamofire.HTTPMethod.delete
        httpPayload.url = baseURL.appendingFormat("/%@", urlString)
        //        httpPayload.paramDict = paramDict
        
        for key in paramDict.allKeys as! [String] {
            httpPayload.url.append("/\(paramDict.object(forKey: key)!)")
        }
        
        httpPayload = setHeadersForPayload(httpPayload)
        
        return httpPayload
    }
    
    open class func setHeadersForPayload(_ httpPayLoad: HttpPayload) -> HttpPayload {
        let httpPayload:HttpPayload = httpPayLoad
        /*
         SET UP PAYLOAD HEADERS
        */
        return httpPayLoad
    }
}
