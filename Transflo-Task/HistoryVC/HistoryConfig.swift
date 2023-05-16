//
//  HistoryConfig.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 24/04/2023.
//

import Foundation
protocol HistoryConfigurator {
    func configure(historyVC: HistoryVC , locationDelegate: GetLocationCoordinatedProtocol,fetchLimit: Int)
}

class HistoryConfiguratorImplementation: HistoryConfigurator {
    func configure(historyVC: HistoryVC, locationDelegate: GetLocationCoordinatedProtocol,fetchLimit: Int) {
        let gateway = ApiWeatherGateway()
        let router = HistoryRouterImplementation(historyVC: historyVC)
        let presenter = HistoryPresenterImplementation(delegate: historyVC, gateway: gateway, router: router, locationDelegate: locationDelegate,fetchLimit: fetchLimit)
        historyVC .presenter = presenter
    }
}
