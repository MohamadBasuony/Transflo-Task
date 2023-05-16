//
//  CurrentWeatherRouter.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 16/04/2023.
//

import Foundation
import UIKit

protocol CurrentWeatherRouter{
    func presentSearchVC()
    func pushToForecastVC(lat : Double , lon : Double)
    func presentHistoryVC()
}

class CurrentWeatherRouterImplementation: CurrentWeatherRouter {
    
    fileprivate weak var currentWeatherVC: CurrentWeatherVC?
    
    init(currentWeatherVC: CurrentWeatherVC) {
        self.currentWeatherVC = currentWeatherVC
    }
    
    func presentSearchVC(){
        let vc = StoryBoards.SearchVC.instance.instantiateInitialViewController() as? SearchVC
        vc?.modalPresentationStyle = .overCurrentContext
        let config = SearchConfiguratorImplementation()
        config.configure(searchVC: vc ?? SearchVC(), locationDelegate: currentWeatherVC ?? CurrentWeatherVC())
        currentWeatherVC?.present(vc!, animated: true)
    }

    
    func pushToForecastVC(lat : Double , lon : Double) {
        let vc = StoryBoards.ForecastVC.instance.instantiateInitialViewController() as? ForecastVC
        let config = ForecastConfiguratorImplementation()
        config.configure(forecastVC: vc!, lat: lat, lon: lon)
        currentWeatherVC?.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func presentHistoryVC(){
        let vc = StoryBoards.HistoryVC.instance.instantiateInitialViewController() as? HistoryVC
        vc?.modalPresentationStyle = .overCurrentContext
        let config = HistoryConfiguratorImplementation()
        config.configure(historyVC: vc ?? HistoryVC(), locationDelegate: currentWeatherVC ?? CurrentWeatherVC(), fetchLimit: 10)
        currentWeatherVC?.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
//            .present(vc ?? UIViewController(), animated: true)
    }
}
