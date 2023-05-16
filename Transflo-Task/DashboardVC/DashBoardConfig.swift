//
//  DashBoardConfig.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 15/04/2023.
//

import Foundation
protocol DashBoardConfigurator {
    func configure(dashBoardVC: DashBoardVC)
}

class DashBoardConfiguratorImplementation: DashBoardConfigurator {
    func configure(dashBoardVC: DashBoardVC) {
        let gateway = ApiWeatherGateway()
        let router = DashBoardRouterImplementation(dashBoardVC: dashBoardVC)
        let presenter = DashBoardPresenterImplementation(delegate: dashBoardVC, gateway: gateway, router: router)
        dashBoardVC.presenter = presenter
    }
}
