//
//  UserDefaultManager.swift
//  Seller App
//
//  Created by Mohamad Basuony on 06/09/2022.
//

import Foundation

enum UserDefaultsKeys: String, CaseIterable {
//    case language
    case userName
    case userSurName
    case apiToken
    case buyerId
    case buyerEmail
    case bay
    case address
    case city
    case state
    case postalCode
    case sessionId
    case userId
    case fcmToken
    case policy
    case filterModel
    case userImage
    case notificationCount
    case cartCount
}

struct UserDefaultsManager {
    static var shared: UserDefaultsManager = UserDefaultsManager()
    
//    static var language: String? {
//        get {
//            return UserDefaults.standard.string(forKey: UserDefaultsKeys.language.rawValue)
//        } set {
//            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.language.rawValue)
//        }
//    }
    
    static var userName: String? {
        get {
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.userName.rawValue)
        } set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.userName.rawValue)
        }
    }
    
    static var userSurName: String? {
        get {
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.userSurName.rawValue)
        } set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.userSurName.rawValue)
        }
    }
    static var fcmToken: String? {
        get {
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.fcmToken.rawValue)
        } set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.fcmToken.rawValue)
        }
    }
    
    
    static var apiToken: String? {
        get {
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.apiToken.rawValue)
        } set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.apiToken.rawValue)
        }
    }
    
    static var buyerId: Int? {
        get {
            return UserDefaults.standard.integer(forKey: UserDefaultsKeys.buyerId.rawValue)
        } set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.buyerId.rawValue)
        }
    }
    
    static var buyerEmail: String? {
        get {
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.buyerEmail.rawValue)
        } set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.buyerEmail.rawValue)
        }
    }
    
    static var bay: String? {
        get {
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.bay.rawValue)
        } set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.bay.rawValue)
        }
    }
    
    static var address: String? {
        get {
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.address.rawValue)
        } set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.address.rawValue)
        }
    }
    
    static var city: String? {
        get {
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.city.rawValue)
        } set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.city.rawValue)
        }
    }
    
    static var state: String? {
        get {
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.state.rawValue)
        } set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.state.rawValue)
        }
    }
    
    static var postalCode: String? {
        get {
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.postalCode.rawValue)
        } set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.postalCode.rawValue)
        }
    }
    
    static var sessionId: Int? {
        get {
            return UserDefaults.standard.integer(forKey: UserDefaultsKeys.sessionId.rawValue)
        } set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.sessionId.rawValue)
        }
    }
    
    static var userId: Int? {
        get {
            return UserDefaults.standard.integer(forKey: UserDefaultsKeys.userId.rawValue)
        } set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.userId.rawValue)
        }
    }
    
    static var policy: String? {
        get {
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.policy.rawValue)
        } set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.policy.rawValue)
        }
    }
    
    static var userImage: String? {
        get {
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.userImage.rawValue)
        } set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.userImage.rawValue)
        }
    }
    
    static var notificationCount: Int? {
        get {
            return UserDefaults.standard.integer(forKey: UserDefaultsKeys.notificationCount.rawValue)
        } set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.notificationCount.rawValue)
        }
    }
    
    static var cartCount: Int? {
        get {
            return UserDefaults.standard.integer(forKey: UserDefaultsKeys.cartCount.rawValue)
        } set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.cartCount.rawValue)
        }
    }
    
}

extension UserDefaultsManager {
    func getValue(_ key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    func setValue(_ value: Any?, forKey key: String) {
        UserDefaults.init().set(value, forKey: key)
    }
    func removeValue(_ key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    func removeAllUserDefaults() {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
    }
    func removeArrayOfKeys(keys: [UserDefaultsKeys]) {
        for key in keys {
            self.removeValue(key.rawValue)
        }
    }
    func setArrayOfValues<T>(value: [T], key: [String]) {
        for (value, key) in zip(value, key) {
            self.setValue(value, forKey: key)
        }
    }
    // save all object in user defaults
    func setObject<T>(forKey key: String, _ value: T?) where T: Encodable {
        if value == nil {
            UserDefaults.standard.set(nil, forKey: key)
        } else {
            do {
                let jsonEncoder = JSONEncoder()
                let jsonData = try jsonEncoder.encode(value!)
                let json = String(data: jsonData, encoding: String.Encoding.utf8)
                UserDefaults.standard.set(json, forKey: key)
            } catch let error {
                print("couldn't encode object:\(error)")
            }
        }
    }
    // save get object in user defaults
    func getObject<T: Codable>(_ key: String, result: T.Type) -> T? {
        do {
            let jsonString = getValue(key) as? String
            let jsonData = jsonString?.data(using: .utf8)
            let decoder = JSONDecoder()
            return try decoder.decode(result, from: jsonData ?? Data())
        } catch let error {
            print("couldn't decode object:\(error)")
        }
        return nil
    }
}
