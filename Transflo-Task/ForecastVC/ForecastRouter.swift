//
//  ForecastRouter.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 16/04/2023.
//

import Foundation
import UIKit

protocol ForecastRouter{
    func presentSearchVC()
    func presentHistoryVC()
    func popToRoot()
}

class ForecastRouterImplementation: ForecastRouter {
    
    fileprivate weak var forecastVC: ForecastVC?
    
    init(forecastVC: ForecastVC) {
        self.forecastVC = forecastVC
    }
    
    func presentSearchVC(){
         let vc = StoryBoards.SearchVC.instance.instantiateInitialViewController() as? SearchVC
         vc?.modalPresentationStyle = .overCurrentContext
         let config = SearchConfiguratorImplementation()
         config.configure(searchVC: vc ?? SearchVC(), locationDelegate: forecastVC ?? ForecastVC())
        forecastVC?.present(vc!, animated: true)
     }

    func presentHistoryVC(){
        let vc = StoryBoards.HistoryVC.instance.instantiateInitialViewController() as? HistoryVC
        let config = HistoryConfiguratorImplementation()
        config.configure(historyVC: vc ?? HistoryVC(), locationDelegate: forecastVC ?? ForecastVC(), fetchLimit: 5)
        vc?.modalPresentationStyle = .overCurrentContext
        forecastVC?.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func popToRoot(){
        forecastVC?.navigationController?.popToRootViewController(animated: true)
    }
}
