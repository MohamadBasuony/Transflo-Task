//
//  Constants.swift
//  Seller App
//
//  Created by Mohamad Basuony on 06/09/2022.
//

import Foundation
import UIKit
import NVActivityIndicatorView

enum StoryBoards : String{
    case DashboardVC
    case CurrentWeatherVC
    case ForecastVC
    case SearchVC
    case HistoryVC
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
}

class NetworkingConstants {
    
    static let shared = NetworkingConstants()
    private init(){
    }
  
    static let baseUrl = "https://api.openweathermap.org/"
    static let imgBaseUrl = "https://openweathermap.org/img/wn/"
    
    func headers() -> [String: String] {
        return
            [
                "" : ""
//                "Authorization": "Bearer \(UserDefaultsManager.apiToken ?? "")",
//                "X-version" : "2.0",
        ]
    }
    
    static func noAuthHeaders() -> [String: String] {
        return
            [
                "Content-Type": "application/json",
                "Accept": "application/json",
        ]
    }
    
    static func createParamsDict(dict: [String: Any?]) -> [String: Any] {
        var paramsDict = [String: Any]()
        for (key, value) in dict where value != nil {
            paramsDict[key] = value
        }
        return paramsDict
    }
}

var sceneDelegate: SceneDelegate? {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
        let delegate = windowScene.delegate as? SceneDelegate else { return nil }
     return delegate
}

var appDelegate : AppDelegate? {
    return UIApplication.shared.delegate as? AppDelegate
}

var hasTopNotch: Bool {
    if #available(iOS 11.0, tvOS 11.0, *) {
        return sceneDelegate?.window?.safeAreaInsets.top ?? 0 >= 44
    }
    return false
}

enum SearchFrom : String {
    case FromCurrentWeather = "FromCurrentWeather"
    case FromForecast = "FromForecast"
}
var appKey = "ce5edb27133f4b3a9eab5abfe8072942"
