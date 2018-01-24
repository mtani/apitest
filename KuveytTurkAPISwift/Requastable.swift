//
//  Requastable.swift
//  KuveytTurkAPISwift
//
//  Created by Mustafa Tanışır / Kuveyt Türk - BT-Dijital Bankacılık Yazılım Geliştirme on 26.12.2017.
//  Copyright © 2017 Kuveyt Türk. All rights reserved.
//

import UIKit
import OAuth2


/// Typealias to ease working with JSON dictionaries.
public typealias OAuth2JSON =  [String: Any]

/// Typealias to work with dictionaries full of strings.
public typealias OAuthStringDict = [String: String]

/// Typealias to work with headers.
public typealias OAuthHeaders = [String: String]

/**
 Abstract base class for OAuth2 authorization as well as client registration classes.
 */
open class Requestable: OAuth2Requestable {

}

