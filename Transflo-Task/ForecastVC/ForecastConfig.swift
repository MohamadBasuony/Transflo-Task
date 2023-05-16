//
//  ForecastConfig.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 16/04/2023.
//

import Foundation
protocol ForecastConfigurator {
    func configure(forecastVC: ForecastVC, lat : Double? , lon : Double?)
}

class ForecastConfiguratorImplementation: ForecastConfigurator {
    func configure(forecastVC: ForecastVC , lat : Double? , lon : Double?) {
        let gateway = ApiWeatherGateway()
        let router = ForecastRouterImplementation(forecastVC: forecastVC)
        let presenter = ForecastPresenterImplementation(delegate: forecastVC, gateway: gateway, router: router , lat : lat , lon : lon)
        forecastVC.presenter = presenter
    }
}
