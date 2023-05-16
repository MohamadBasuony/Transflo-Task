//
//  SearchConfig.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 17/04/2023.
//

import Foundation
protocol SearchConfigurator {
    func configure(searchVC: SearchVC , locationDelegate : GetLocationCoordinatedProtocol)
}

class SearchConfiguratorImplementation: SearchConfigurator {
    func configure(searchVC: SearchVC, locationDelegate : GetLocationCoordinatedProtocol ) {
        let gateway = ApiWeatherGateway()
        let router = SearchRouterImplementation(searchVC: searchVC)
        let presenter = SearchPresenterImplementation(delegate: searchVC, locationDelegate: locationDelegate, gateway: gateway, router: router)
        searchVC.presenter = presenter
    }
}
