//
//  HistoryRouter.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 24/04/2023.
//

import Foundation
import UIKit

protocol HistoryRouter{
    func pop()
}

class HistoryRouterImplementation: HistoryRouter {
    
    
    fileprivate weak var historyVC: HistoryVC?
    
    init(historyVC: HistoryVC) {
        self.historyVC = historyVC
    }
    
    func pop(){
        historyVC?.navigationController?.popViewController(animated: true)
//        view.window?.rootViewController?.dismiss(animated: true)
    }
}
