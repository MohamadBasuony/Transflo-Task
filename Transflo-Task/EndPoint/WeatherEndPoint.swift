//
//  WeatherEndPoint.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 16/04/2023.
//

import Foundation
import Alamofire
import Moya

enum WeatherEndPoint {
    case getCurrentWeather(lat : Double , lon : Double)
    case getForecast(duration : Int ,lat : Double , lon :Double)
    case getCoordinateByQuery(query : String)
    case getCoordinateByZipCode(zipCode : String)
}

extension WeatherEndPoint: TargetType {
    var sampleData: Data {
        return Data()
    }
    
    var method: Moya.Method {
        switch self {
        default :
            return .get
        }
    }
    
    var baseURL: URL {
        return URL(string: NetworkingConstants.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .getCurrentWeather: return "data/2.5/weather"
        case .getForecast: return "data/2.5/forecast"
        case .getCoordinateByQuery : return "geo/1.0/direct"
        case .getCoordinateByZipCode : return "geo/1.0/zip"
        }
    }
    
    var headers: [String: String]? {
        NetworkingConstants.shared.headers()
    }
    
    var task: Task {
        switch self {
        case let .getCurrentWeather(lat , lon) :
            return .requestParameters(parameters: ["lat" :lat ,
                                                   "lon" : lon,
                                                   "appid" : appKey], encoding: URLEncoding.queryString)
            
        case  let .getForecast(duration,lat , lon):
            return .requestParameters(parameters: ["cnt": duration,
                                                   "lat" :lat ,
                                                   "lon" : lon,
                                                   "appid" : appKey], encoding: URLEncoding.queryString)
            
        case let .getCoordinateByQuery(query):
            return .requestParameters(parameters: ["q" : query,
                                                   "limit" : "5",
                                                   "appid" : appKey], encoding: URLEncoding.queryString)
            
        case let .getCoordinateByZipCode(zipCode):
            return .requestParameters(parameters: ["zip" : zipCode,
                                                   "appid" : appKey], encoding: URLEncoding.queryString)
            
        default :
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        }
    }
}

extension WeatherEndPoint : AccessTokenAuthorizable {
    var authorizationType: Moya.AuthorizationType? {
        return .bearer
    }
}
