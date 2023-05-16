//
//  SelectCityRouter.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 16/05/2023.
//

import Foundation
protocol SelectCityRouter{
    func dismiss()
    func dismissToRoot()
}

class SelectCityRouterImplementation: SelectCityRouter {
    
    fileprivate weak var selectCityVC: SelectCityVC?
    
    init(selectCityVC: SelectCityVC) {
        self.selectCityVC = selectCityVC
    }

    
    func dismiss(){
        selectCityVC?.dismiss(animated: true)
    }
    
    func dismissToRoot(){
        selectCityVC?.view.window?.rootViewController?.dismiss(animated: true)
    }
}
