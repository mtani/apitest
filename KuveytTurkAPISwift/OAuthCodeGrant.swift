//
//  OAuthCodeGrant.swift
//  KuveytTurkAPISwift
//
//  Created by Mustafa Tanışır / Kuveyt Türk - BT-Dijital Bankacılık Yazılım Geliştirme on 26.12.2017.
//  Copyright © 2017 Kuveyt Türk. All rights reserved.
//

import UIKit
import p2_OAuth2

/**
 A class to handle authorization for confidential clients via the authorization code grant method.
 
 This auth flow is designed for clients that are capable of protecting their client secret but can be used from installed apps. During code
 exchange and token refresh flows, **if** the client has a secret, a "Basic key:secret" Authorization header will be used. If not the client
 key will be embedded into the request body.
 */
public class OAuthCodeGrant: OAuth2CodeGrant {

}
