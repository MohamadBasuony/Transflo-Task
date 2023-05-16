//
//  Configuration.swift
//  BeutiCustomer
//
//  Created by Michele on 10/3/19.
//  Copyright © 2019 Michelle. All rights reserved.
//

import Foundation

public enum Configuration {
    
    private static let infoDictionary: [String: Any] = {
      guard let infoDict = Bundle.main.infoDictionary else {
        fatalError("info.Plist file not found")
      }
      return infoDict
    }()

//    static var appInReview: Bool = false
//    static var remoteBaseUrl: String?
    static var baseURL: String {
        
//        if appInReview {
//            return ""
//        }
        
//        if let urlString = remoteBaseUrl,
//            !urlString.isEmpty,
//            URL (string: urlString) != nil {
//            return urlString
//        }
        
        guard let baseURLstring = Configuration.infoDictionary["BASE_URL"] as? String,
            !baseURLstring.isEmpty else {
        fatalError("Base URL not set in plist for this environment")
      }
        
      return baseURLstring
    }
    
    static var signInPolicy: String {
        
        guard let signInPolicy = Configuration.infoDictionary["MSALSignInPolicy"] as? String,
            !signInPolicy.isEmpty else {
        fatalError("SignIn Policy not set in plist for this environment")
      }
        
      return signInPolicy
    }
    
    
    static var signUpPolicy: String {
        
        guard let signUpPolicy = Configuration.infoDictionary["MSALSignUpPolicy"] as? String,
            !signUpPolicy.isEmpty else {
        fatalError("SignUp Policy not set in plist for this environment")
      }
        
      return signUpPolicy
    }
    
    static var scopes: String {
        
        guard let scope = Configuration.infoDictionary["MSALScopes"] as? String,
            !scope.isEmpty else {
        fatalError("scope not set in plist for this environment")
      }
        
      return scope
    }
    
    static var authority: String {
        guard let authority = Configuration.infoDictionary["MSALAuthority"] as? String,
            !authority.isEmpty else {
        fatalError("authority not set in plist for this environment")
      }
        
      return authority
    }
    
    static var clientID: String {
        
        guard let clientID = Configuration.infoDictionary["ClientID"] as? String,
            !clientID.isEmpty else {
        fatalError("clientID not set in plist for this environment")
      }
        
      return clientID
    }
    
    static var tenantName: String {
        
        guard let tenantName = Configuration.infoDictionary["MSALTenantName"] as? String,
            !tenantName.isEmpty else {
        fatalError("clientID not set in plist for this environment")
      }
        
      return tenantName
    }
    
    static var chatURL: String {
        guard let chatURLString = Configuration.infoDictionary["ChatURL"] as? String,
            !chatURLString.isEmpty else {
        fatalError("Base URL not set in plist for this environment")
      }
        
      return chatURLString
    }
    
    static var notificationURL: String {
        guard let notificationURLString = Configuration.infoDictionary["NotificationURL"] as? String,
            !notificationURLString.isEmpty else {
        fatalError("Base URL not set in plist for this environment")
      }
        
      return notificationURLString
    }
    
}
