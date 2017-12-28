//
//  KuveytTurkAPISwiftTests.swift
//  KuveytTurkAPISwiftTests
//
//  Created by Mustafa Tanışır / Kuveyt Türk - BT-Dijital Bankacılık Yazılım Geliştirme on 26.12.2017.
//  Copyright © 2017 Kuveyt Türk. All rights reserved.
//

import XCTest
@testable import KuveytTurkAPISwift

class KuveytTurkAPISwiftTests: XCTestCase {
    
    var loader: DataLoader?
  
    let oauth2 = OAuthCodeGrant(settings: [
        "client_id": "f68b52e80a61404c9588a3f87006bd1e",
        "client_secret": "ht86Q7nZLhwdThKsDMnF5Bqqfg2z6cqzezSIh0BTnZAccrn+4WTHoQ==",
        "authorize_uri": ConnectionOptions.authorizeUri,
        "token_uri": ConnectionOptions.tokenUri,
        "scope": "accounts transfers loans offline_access public",
        "redirect_uris": ["ppoauthapp://oauth/callback"],            // app has registered this scheme
        "secret_in_body": true,
        ] as OAuth2JSON)
    
    
    
    override func setUp() {
        super.setUp()
        
        
        //OAuthCodeGrant(settings: )
        
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    @IBAction func signInEmbedded(_ sender: UIButton?) {
        if oauth2.isAuthorizing {
            oauth2.abortAuthorization()
            return
        }
       
        sender?.setTitle("Authorizing...", for: UIControlState.normal)
        
        oauth2.authConfig.authorizeEmbedded = true
        oauth2.authConfig.authorizeContext = self
        let loader = DataLoader(oauth2: oauth2)
        self.loader = loader
        
        
        var queryParameters: [String: String]? = ["onlyHasAvailableBalance":"0", "onlyOpen":"1","onlyWithNoBalance":"0","onlyCurrent":"0","sharedWithMultiSignature":"0"]
        
        
         let requestEndPoint: URLRequest = loader.createMethodRequest(enpoint: .Accounts , oauth2: oauth2, queryParameters: queryParameters);
        
        loader.perform(request: requestEndPoint) { response in
            do {
                let json = try response.responseJSON()
                self.didGetUserdata(dict: json, loader: loader)
            }
            catch let error {
                self.didCancelOrFail(error)
            }
        }
    }
    
    var userDataRequest: URLRequest {
        var components = URLComponents()
        components.scheme = ConnectionOptions.urlSchema
        components.host = ConnectionOptions.host
        components.path = "/prep/v1/accounts"
        
        oauth2.clientConfig.queryParameters = ["onlyHasAvailableBalance":"0", "onlyOpen":"1","onlyWithNoBalance":"0","onlyCurrent":"0","sharedWithMultiSignature":"0"]
        
        
        var queryItems = [URLQueryItem]()
        for (key, value) in oauth2.clientConfig.queryParameters! {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        
        components.queryItems = queryItems
        oauth2.clientConfig.query = components.query!
        var request = URLRequest (url: components.url!)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    func didGetUserdata(dict: [String: Any], loader: DataLoader?) {
        DispatchQueue.main.async {
            
        }
    }
    
    func didCancelOrFail(_ error: Error?) {
        DispatchQueue.main.async {
            if let error = error {
                print("Authorization went wrong: \(error)")
            }
          
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
