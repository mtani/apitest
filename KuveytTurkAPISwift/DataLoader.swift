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
                do{
                    bodyData = try JSONSerialization.data(withJSONObject: oauth2.clientConfig.parameters as Any, options: [])
                }catch{
                    
                }
                oauth2.clientConfig.query =  String(data: bodyData!, encoding: String.Encoding.utf8)
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
        return request
        
    }
    
    
    
    func getEndPointModel(endPoint: EndPoint.EndPointType) -> EndPointModel {
        
        if(endPoint == .Accounts)
        {
            return EndPointModel.init(endPointPath: "/prep/v1/accounts", endPointHttpMethod: .GET , isPublicEndPoint: false)
        }
        else if(endPoint == .AccountTransactions)
        {
            return EndPointModel.init(endPointPath: "/prep/v1/accounts/1/transactions", endPointHttpMethod: .GET , isPublicEndPoint: false)
        }
        else if(endPoint == .Receipt)
        {
            return EndPointModel.init(endPointPath: "/prep/v1/accounts/1/transactions/20000882382389", endPointHttpMethod: .GET , isPublicEndPoint: false)
        }
        else if(endPoint == .UserOTPSend)
        {
            return EndPointModel.init(endPointPath: "/prep/v1/user/otp", endPointHttpMethod: .POST , isPublicEndPoint: false)
        }
        else if(endPoint == .UserOTPVerify)
        {
            return EndPointModel.init(endPointPath: "/prep/v1/user/otp/verify", endPointHttpMethod: .POST , isPublicEndPoint: false)
        }
        else if(endPoint == .MoneyTransferExecute)
        {
            return EndPointModel.init(endPointPath: "/prep/v1/transfers/execute", endPointHttpMethod:.POST , isPublicEndPoint: false)
        }
        else if (endPoint == .MoneyTransferToIBAN)
        {
            return EndPointModel.init(endPointPath: "/prep/v1/transfers/ToIBAN", endPointHttpMethod: .POST, isPublicEndPoint: false)
        }
        else if (endPoint == .MoneyTransferToAccount)
        {
            return EndPointModel.init(endPointPath: "/prep/v1/transfers/ToAccount", endPointHttpMethod: .POST, isPublicEndPoint: false)
        }
        else if (endPoint == .MoneyTransferToName)
        {
            return EndPointModel.init(endPointPath: "/prep/v1/transfers/ToName", endPointHttpMethod: .POST, isPublicEndPoint: false)
        }
        else if (endPoint == .FromATMByQRCode)
        {
            return EndPointModel.init(endPointPath: "/prep/v1/transfers/FromATMByQRCode", endPointHttpMethod: .POST, isPublicEndPoint: false)
        }
        else if (endPoint == .MoneyTransferToGSM)
        {
            return EndPointModel.init(endPointPath: "/prep/v1/transfers/toGSM", endPointHttpMethod: .POST, isPublicEndPoint: false)
        }
        else if(endPoint == .ToGSMTransactions){
            return EndPointModel.init(endPointPath: "/prep/v1/transfers/toGSM/transactions", endPointHttpMethod: .POST, isPublicEndPoint: false)
        }
        else if(endPoint == .MoneyTransferToGSMCancel){
            return EndPointModel.init(endPointPath: "/prep/v1/transfers/toGSM/cancel", endPointHttpMethod: .POST, isPublicEndPoint: false)
        }
        else if(endPoint == .BankBranches){
            return EndPointModel.init(endPointPath: "/prep/v1/data/banks/10/branches", endPointHttpMethod: .GET, isPublicEndPoint: true)
        }
        else if(endPoint == .FxRates){
            return EndPointModel.init(endPointPath: "/prep/v1/fx/rates", endPointHttpMethod: .GET, isPublicEndPoint: true)
        }
        else if(endPoint == .FxCurrencyList){
            return EndPointModel.init(endPointPath: "/prep/v1/data/fecs", endPointHttpMethod: .GET, isPublicEndPoint: true)
        }
        else if(endPoint == .KuveytTurkBranches)
        {
            return EndPointModel.init(endPointPath: "/prep/v1/data/branches", endPointHttpMethod:.GET , isPublicEndPoint: true)
        }
        else if(endPoint == .Banks)
        {
            return EndPointModel.init(endPointPath: "/prep/v1/data/banks", endPointHttpMethod:.GET , isPublicEndPoint: true)
        }
        else if(endPoint == .XTMS)
        {
            return EndPointModel.init(endPointPath: "/prep/v1/data/xtms", endPointHttpMethod:.GET , isPublicEndPoint: true)
        }
        else if(endPoint == .ATMS)
        {
            return EndPointModel.init(endPointPath: "/prep/v1/data/atms", endPointHttpMethod:.GET , isPublicEndPoint: true)
        }
        else if(endPoint == .LoanCalculation)
        {
            return EndPointModel.init(endPointPath: "/prep/v1/calculations/loans", endPointHttpMethod:.GET , isPublicEndPoint: true)
        }
        else if(endPoint == .LoanCalculationParameter)
        {
            return EndPointModel.init(endPointPath: "/prep/v1/data/loans", endPointHttpMethod:.GET , isPublicEndPoint: true)
        }
        else if(endPoint == .Loans)
        {
            return EndPointModel.init(endPointPath: "/prep/v1/loans", endPointHttpMethod:.GET , isPublicEndPoint: false)
        }
        else if(endPoint == .LoanInstallments)
        {
             return EndPointModel.init(endPointPath: "/prep/v1/loans/300/installments", endPointHttpMethod:.GET , isPublicEndPoint: false)
        }
        else if(endPoint == .LoanInfo)
        {
            return EndPointModel.init(endPointPath: "/prep/v1/loan/300", endPointHttpMethod:.GET , isPublicEndPoint: false)
        }
        else if(endPoint == .TestCustomerList)
        {
            return EndPointModel.init(endPointPath: "/prep/v1/data/testcustomers", endPointHttpMethod:.GET , isPublicEndPoint: true)
        }
        else {
            return EndPointModel.init(endPointPath: "/prep/v1/data/xtms", endPointHttpMethod:.GET , isPublicEndPoint: true)
        }
    }
    
    
    override open func perform(request: URLRequest, callback: @escaping ((OAuth2Response) -> Void)) {
        
        super.perform(request: request, callback: callback)
        print("Test")
    }

}
