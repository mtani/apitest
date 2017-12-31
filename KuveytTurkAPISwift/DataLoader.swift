//
//  DataLoader.swift
//  KuveytTurkAPISwift
//
//  Created by Mustafa Tanışır / Kuveyt Türk - BT-Dijital Bankacılık Yazılım Geliştirme on 26.12.2017.
//  Copyright © 2017 Kuveyt Türk. All rights reserved.
//

import UIKit
import p2_OAuth2

public class DataLoader: OAuth2DataLoader {
    
    public func createMethodRequest(enpoint: EndPoint.EndPointType, oauth2: OAuth2Base, parameters: [String: String]?) -> URLRequest
    {
        var bodyData : Data?
        oauth2.clientConfig.parameters = parameters
        //oauth2.clientConfig.customParameters = parameters
        var components = URLComponents()
        components.scheme = ConnectionOptions.urlSchema
        components.host = ConnectionOptions.host
        
        let endPointModel: EndPointModel = getEndPointModel(endPoint: enpoint)
        
        
        components.path = endPointModel.endPointPath!
        
        if(oauth2.clientConfig.parameters != nil)
        {
            if(endPointModel.endPointHttpMethod == .GET)
            {
                var queryItems = [URLQueryItem]()
                for (key, value) in oauth2.clientConfig.parameters! {
                    queryItems.append(URLQueryItem(name: key, value: value))
                }
                
                components.queryItems = queryItems
                oauth2.clientConfig.query = components.query!
                oauth2.clientConfig.isPostMethod = false
            }
            else
            {
                var finalParams = OAuth2RequestParams()
                if let customParameters = oauth2.clientConfig.parameters {
                    for (k, v) in customParameters {
                        finalParams[k] = v
                    }
                }
                // add a body to POST requests
                if finalParams.count > 0 {
                    do{
                        bodyData = try finalParams.utf8EncodedData()
                    }catch{
                        
                    }
                    
                    
                }
                oauth2.clientConfig.query =  oauth2.clientConfig.parameters?.description
                oauth2.clientConfig.isPostMethod = true
            }
        }
        
        oauth2.clientConfig.isPublicEndPoint = endPointModel.isPublicEndPoint
        
        var request = URLRequest (url: components.url!)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = String(describing: endPointModel.endPointHttpMethod.rawValue)
        if((bodyData != nil) && endPointModel.endPointHttpMethod == .POST)
        {
         request.httpBody = bodyData
        }
       
        //request.httpMethod = "POST"
        return request
        
    }
    
    
    
    func getEndPointModel(endPoint: EndPoint.EndPointType) -> EndPointModel {
        if(endPoint == .Accounts)
        {
            return EndPointModel.init(endPointPath: "/prep/v1/accounts", endPointHttpMethod: .GET , isPublicEndPoint: false)
        }
        else if(endPoint == .Loans)
        {
            return EndPointModel.init(endPointPath: "/prep/v1/loans", endPointHttpMethod:.GET , isPublicEndPoint: false)
        }
        else if(endPoint == .Banks)
        {
            return EndPointModel.init(endPointPath: "/prep/v1/data/banks", endPointHttpMethod:.GET , isPublicEndPoint: true)
        }
        else if(endPoint == .XTMS)
        {
            return EndPointModel.init(endPointPath: "/prep/v1/data/xtms", endPointHttpMethod:.GET , isPublicEndPoint: true)
        }
        else if(endPoint == .MoneyTransferExecute)
        {
            return EndPointModel.init(endPointPath: "/prep/v1/transfers/execute", endPointHttpMethod:.POST , isPublicEndPoint: false)
        }
        else {
            return EndPointModel.init(endPointPath: "/prep/v1/data/xtms", endPointHttpMethod: .GET, isPublicEndPoint: true)
        }
        
    }
    
    
    override open func perform(request: URLRequest, callback: @escaping ((OAuth2Response) -> Void)) {
        
        super.perform(request: request, callback: callback)
        print("Test")
    }

}
