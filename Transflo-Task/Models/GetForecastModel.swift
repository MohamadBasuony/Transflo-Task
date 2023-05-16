//
//  GetForecastModel.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 17/04/2023.
//

import Foundation

// MARK: - GetForecastModel
struct GetForecastModel: Codable {
    var cod: String?
    var message, cnt: Int?
    var list: [List]?
    var city: City?
}

// MARK: - List
struct List: Codable {
    var dt: Int?
    var main: Main?
    var weather: [Weather]?
    var clouds: Clouds?
    var wind: Wind?
    var visibility: Int?
    var pop: Double?
    var sys: Sys?
    var dtTxt: String?
    var rain: Rain?
    var timeFormatted : String? {
        let dateString = dtTxt?.split(separator: " ").last ?? ""
        let DateFormatted = "\(dateString)".dateFormatted(withFormat: "hh:mm a", fromFormat: "HH:mm:ss")

        return DateFormatted
    }
    var visibilityInKM : Double? {
        return Double((visibility ?? 0) / 1000)
    }
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt
        case rain
    }
}

// MARK: - City
struct City: Codable {
    var id: Int?
    var name: String?
    var coord: Coord?
    var country: String?
    var population, timezone, sunrise, sunset: Int?
}

// MARK: - Rain
struct Rain: Codable {
    var the3H: Double?

    enum CodingKeys: String, CodingKey {
        case the3H
    }
}
