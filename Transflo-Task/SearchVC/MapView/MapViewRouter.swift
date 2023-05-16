//
//  MapViewRouter.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 16/05/2023.
//

import Foundation

protocol MapViewRouter{
    func dismiss()
    func dismissToRoot()
}

class MapViewRouterImplementation: MapViewRouter {
    
    fileprivate weak var mapView: MapView?
    
    init(mapView: MapView) {
        self.mapView = mapView
    }

    func dismiss(){
        mapView?.view.window?.rootViewController?.dismiss(animated: true)
    }
    
    func dismissToRoot(){
        mapView?.view.window?.rootViewController?.dismiss(animated: true)
    }
}
