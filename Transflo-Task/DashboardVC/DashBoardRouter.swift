//
//  DashBoardRouter.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 15/04/2023.
//

import Foundation
import UIKit

protocol DashBoardRouter {
    func pushToCurrentWeatherVC(lat : Double? , lon : Double?)
    func pushToForecastVC(lat : Double? , lon : Double?)
}

class DashBoardRouterImplementation: DashBoardRouter {
    
    fileprivate weak var dashBoardVC: DashBoardVC?
    
    init(dashBoardVC: DashBoardVC) {
        self.dashBoardVC = dashBoardVC
    }
    
    func pushToCurrentWeatherVC(lat : Double? , lon : Double?) {
        let vc = StoryBoards.CurrentWeatherVC.instance.instantiateInitialViewController() as? CurrentWeatherVC
        let config = CurrentWeatherConfiguratorImplementation()
        config.configure(currentWeatherVC: vc!, lat: lat, lon: lon)
        dashBoardVC?.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func pushToForecastVC(lat : Double? , lon : Double?) {
        let vc = StoryBoards.ForecastVC.instance.instantiateInitialViewController() as? ForecastVC
        let config = ForecastConfiguratorImplementation()
        config.configure(forecastVC: vc!, lat: lat, lon: lon)
        dashBoardVC?.navigationController?.pushViewController(vc!, animated: true)
    }

}
