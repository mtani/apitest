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
    
    public func createMethodRequest(enpoint: EndPoint.EndPointType, oauth2: OAuth2Base, queryParameters: [String: String]?)-> URLRequest
    {
        
        oauth2.clientConfig.queryParameters = queryParameters
        var components = URLComponents()
        components.scheme = ConnectionOptions.urlSchema
        components.host = ConnectionOptions.host
        
        let endPointModel: EndPointModel = getEndPointModel(endPoint: enpoint)
        
        
        components.path = endPointModel.endPointPath!
        
        if(oauth2.clientConfig.queryParameters != nil)
        {
            var queryItems = [URLQueryItem]()
            for (key, value) in oauth2.clientConfig.queryParameters! {
                queryItems.append(URLQueryItem(name: key, value: value))
            }
            
            components.queryItems = queryItems
            oauth2.clientConfig.query = components.query!
        }
        
        
        var request = URLRequest (url: components.url!)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = String(describing: endPointModel.endPointHttpMethod)
        //request.httpMethod = "POST"
        return request
        
    }
    
    func getEndPointModel(endPoint: EndPoint.EndPointType) -> EndPointModel {
        if(endPoint == .Accounts)
        {
            return EndPointModel.init(endPointPath: "/prep/v1/accounts", endPointHttpMethod: .GET , authorizationType: .AuthorizationCode)
        }
        else if(endPoint == .Loans)
        {
            return EndPointModel.init(endPointPath: "/prep/v1/loans", endPointHttpMethod:.GET , authorizationType: .AuthorizationCode)
        }
        else {
            return EndPointModel.init(endPointPath: "/prep/v1/data/xtms", endPointHttpMethod: .GET, authorizationType: .ClientCredential)
        }
        
    }
    
    
    func getPath(endPoint: EndPoint.EndPointType)-> String?
    {
        if (endPoint == .Accounts)
        {
            return "/prep/v1/accounts"
        }
        else if (endPoint == .Loans)
        {
            return "/prep/v1/loans"
        }
        else if (endPoint == .XTMS)
        {
            return "/prep/v1/data/xtms"
        }
        else{
            return nil
        }
    }
    
    
    override open func perform(request: URLRequest, callback: @escaping ((OAuth2Response) -> Void)) {
        
        super.perform(request: request, callback: callback)
        print("Test")
    }

}
