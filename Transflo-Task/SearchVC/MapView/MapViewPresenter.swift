//
//  MapViewPresenter.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 16/05/2023.
//

import Foundation

protocol MapViewDelegate {
    func selectLocationDidFail(_ message : String)
}

protocol MapViewPresenter {
    func getCurrentCoordinate()
    func setCoordinate(lat : Double , lon : Double)
    func sendLocationToWeatherVC()
    func dismiss()
}

class MapViewPresenterImplementation: MapViewPresenter {
        
    fileprivate var delegate: MapViewDelegate?
    fileprivate var router: MapViewRouter?
    weak var locationDelegate : GetLocationCoordinatedProtocol?
    
    private lazy var locationService = {
        return CLLocationService()
    }()
        
    var lat : Double?
    var lon : Double?
    
    init(delegate : MapViewDelegate,
         locationDelegate: GetLocationCoordinatedProtocol,
         router : MapViewRouter
    ) {
        self.delegate = delegate
        self.locationDelegate = locationDelegate
        self.router = router
    }
    
    func getCurrentCoordinate() {
        self.locationService.successCompletion = { (coordinate) in
            self.lat = coordinate.latitude
            self.lon = coordinate.longitude
            self.sendLocationToWeatherVC()
        }
        locationService.start()
    }
    
    func setCoordinate(lat : Double , lon : Double) {
        self.lat = lat
        self.lon = lon
    }
    
    func sendLocationToWeatherVC() {
        locationDelegate?.getLocationCoordinate(lat: self.lat ?? 0, lon: self.lon ?? 0)
        dismissToRoot()
    }
    
    func dismissToRoot(){
        router?.dismissToRoot()
    }
    func dismiss() {
        router?.dismiss()
    }
}
