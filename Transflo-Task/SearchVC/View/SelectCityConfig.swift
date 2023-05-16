//
//  SelectCityConfig.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 16/05/2023.
//

import Foundation
protocol SelectCityConfigurator {
    func configure(selectCityVC: SelectCityVC , selectCityDelegate : SelectCityProtocol , cities: [GetQueryResultsModelElement])
}

class SelectCityConfiguratorImplementation: SelectCityConfigurator {
    func configure(selectCityVC: SelectCityVC, selectCityDelegate : SelectCityProtocol , cities: [GetQueryResultsModelElement] ) {
        let router = SelectCityRouterImplementation(selectCityVC: selectCityVC)
        let presenter = SelectCityPresenterImplementation(selectCityDelegate: selectCityDelegate, router: router, cities: cities)
        selectCityVC.presenter = presenter
    }
}
