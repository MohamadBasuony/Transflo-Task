//
//  SearchRouter.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 17/04/2023.
//

import Foundation
//import UIKit

protocol SearchRouter{
    func presentSelectCityVC()
    func presentMapView()
    func dismiss()
}

class SearchRouterImplementation: SearchRouter {
    
    fileprivate weak var searchVC: SearchVC?
    
    init(searchVC: SearchVC) {
        self.searchVC = searchVC
    }
    
    func presentSelectCityVC(){
        let vc = StoryBoards.SearchVC.instance.instantiateViewController(withIdentifier: "SelectCityVC") as! SelectCityVC
        vc.modalPresentationStyle = .overCurrentContext
        let config = SelectCityConfiguratorImplementation()
        config.configure(selectCityVC: vc, selectCityDelegate: searchVC ?? SearchVC(), cities: searchVC?.presenter?.queryResults ?? [])
        searchVC?.present(vc, animated: true)
    }
    
    func presentMapView(){
        let vc = StoryBoards.SearchVC.instance.instantiateViewController(withIdentifier: "MapView") as! MapView
        vc.modalPresentationStyle = .overCurrentContext
        let config = MapViewConfiguratorImplementation()
        config.configure(mapView: vc, locationDelegate: searchVC ?? SearchVC())
        searchVC?.present(vc, animated: true)
    }
    
    func dismiss(){
        searchVC?.dismiss(animated: true)
    }
}
