//
//  CurrentWeatherConfig.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 16/04/2023.
//

import Foundation
protocol CurrentWeatherConfigurator {
    func configure(currentWeatherVC: CurrentWeatherVC,lat : Double? , lon : Double?)
}

class CurrentWeatherConfiguratorImplementation: CurrentWeatherConfigurator {
    func configure(currentWeatherVC: CurrentWeatherVC,lat : Double? , lon : Double?) {
        let gateway = ApiWeatherGateway()
        let router = CurrentWeatherRouterImplementation(currentWeatherVC: currentWeatherVC)
        let presenter = CurrentWeatherPresenterImplementation(delegate: currentWeatherVC, gateway: gateway, router: router,lat : lat , lon : lon)
        currentWeatherVC.presenter = presenter
    }
}
