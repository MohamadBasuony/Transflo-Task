//
//  ApiWeatherGateway.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 17/04/2023.
//

import Foundation

import Moya

class ApiWeatherGateway {

    let accessToken = AccessTokenPlugin(tokenClosure: { _ -> String in
        return UserDefaultsManager.apiToken ?? ""
    })
    
    lazy var apiClient : MoyaProvider<WeatherEndPoint> = MoyaProvider(handleRefreshToken: true , plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose)),accessToken])

    func getCurrentWeather(lat: Double , lon: Double ,completion: @escaping (GetCurrentWeatherModel?,String?) -> Void) {
        apiClient.request(.getCurrentWeather(lat: lat, lon: lon)) { result in
            switch result {
            case let .success(moyaResponse) :
                do {
                    let result = try moyaResponse.map(GetCurrentWeatherModel.self)
                    completion(result , nil)
                }catch{
                    completion(nil, "Ooops , Something Went Wrong")
                }
            case let .failure(error) :
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    func getForecast(duration : Int ,lat : Double , lon :Double ,completion: @escaping (GetForecastModel?,String?) -> Void) {
        apiClient.request(.getForecast(duration: duration,lat: lat, lon: lon)) { result in
            switch result {
            case let .success(moyaResponse) :
                do {
                    let result = try moyaResponse.map(GetForecastModel.self)
                    completion(result , nil)
                }catch{
                    completion(nil, "Ooops , Something Went Wrong")
                }
            case let .failure(error) :
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    func getCoordinateByQuery(query: String ,completion: @escaping ([GetQueryResultsModelElement]?,String?) -> Void) {
        apiClient.request(.getCoordinateByQuery(query: query)) { result in
            switch result {
            case let .success(moyaResponse) :
                do {
                    let result = try moyaResponse.map([GetQueryResultsModelElement].self)
                    completion(result , nil)
                }catch{
                    completion(nil, "Ooops , Something Went Wrong")
                }
            case let .failure(error) :
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    func getCoordinateByZipCode(zipCode: String ,completion: @escaping (GetQueryResultsModelElement?,String?) -> Void) {
        apiClient.request(.getCoordinateByZipCode(zipCode: zipCode)) { result in
            switch result {
            case let .success(moyaResponse) :
                do {
                    let result = try moyaResponse.map(GetQueryResultsModelElement.self)
                    completion(result , nil)
                }catch{
                    completion(nil, "Ooops , Something Went Wrong")
                }
            case let .failure(error) :
                completion(nil, error.localizedDescription)
            }
        }
    }

}
