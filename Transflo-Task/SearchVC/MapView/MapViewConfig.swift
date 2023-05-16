//
//  MapViewConfig.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 16/05/2023.
//

import Foundation
protocol MapViewConfigurator {
    func configure(mapView: MapView , locationDelegate : GetLocationCoordinatedProtocol)
}

class MapViewConfiguratorImplementation: MapViewConfigurator {
    func configure(mapView: MapView, locationDelegate : GetLocationCoordinatedProtocol ) {
        let gateway = ApiWeatherGateway()
        let router = MapViewRouterImplementation(mapView: mapView)
        let presenter = MapViewPresenterImplementation(delegate : mapView,locationDelegate: locationDelegate, router: router)
        mapView.presenter = presenter
    }
}
