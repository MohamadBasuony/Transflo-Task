//
//  SelectCityPresenter.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 16/05/2023.
//

import Foundation

protocol SelectCityPresenter {
    var cities : [GetQueryResultsModelElement]? {get}
    
    func selectCity(index : Int)
    
    func dismiss()
}

class SelectCityPresenterImplementation: SelectCityPresenter {
        
    fileprivate var router: SelectCityRouter?
    var cities : [GetQueryResultsModelElement]?
    weak var selectCityDelegate : SelectCityProtocol?

    
    init(selectCityDelegate: SelectCityProtocol,
         router : SelectCityRouter,
         cities : [GetQueryResultsModelElement]
         
    ) {
        self.selectCityDelegate = selectCityDelegate
        self.router = router
        self.cities = cities
    }
    
    func selectCity(index : Int) {
        selectCityDelegate?.selectCity(selectedCity: cities?[index] ?? GetQueryResultsModelElement())
        dismissToRoot()
    }
    
    func dismissToRoot(){
        router?.dismissToRoot()
    }
    
    func dismiss() {
        router?.dismiss()
    }
}
