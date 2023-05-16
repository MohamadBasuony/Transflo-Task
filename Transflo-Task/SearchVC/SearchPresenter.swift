//
//  SearchPresenter.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 17/04/2023.
//

import Foundation
import CoreData

protocol SearchDelegate: BaseProtocol {
}

protocol SearchPresenter {
    var queryResults : [GetQueryResultsModelElement]? {get}
    var zipResult : GetQueryResultsModelElement? {get}
    
    func getCoordinateByQuery(query: String)
    func getCoordinateByZipCode(zipCode: String)
    func getCurrentCoordinate()
    func sendLocationToWeatherVC(lat : Double , lon : Double)
    
    func presentMapView()
    func dismiss()
}

class SearchPresenterImplementation: SearchPresenter {
        
    fileprivate weak var delegate: SearchDelegate?
    fileprivate var gateway: ApiWeatherGateway?
    fileprivate var router: SearchRouter?
    weak var locationDelegate : GetLocationCoordinatedProtocol?
    private lazy var locationService = {
        return CLLocationService()
    }()
    
    var queryResults : [GetQueryResultsModelElement]?
    var zipResult : GetQueryResultsModelElement?
    
    init(delegate: SearchDelegate,
         locationDelegate: GetLocationCoordinatedProtocol,
         gateway: ApiWeatherGateway,
         router : SearchRouter
    ) {
        self.delegate = delegate
        self.locationDelegate = locationDelegate
        self.gateway = gateway
        self.router = router
    }
    
    func getCoordinateByQuery(query: String){
        delegate?.showIndicatorInView()
        gateway?.getCoordinateByQuery(query: query, completion: { [weak self] results, error in
            guard let self = self else { return }
            self.delegate?.hideIndicatorInView()
            if error == nil {
                self.queryResults = results ?? []
                if !(results?.isEmpty ?? true) {
                    self.presentSelectCityVC()
                }
            } else {
                self.delegate?.requestDidFail(error ?? "No Error")
            }
        })
    }
    
    func getCoordinateByZipCode(zipCode: String){
        delegate?.showIndicatorInView()
        gateway?.getCoordinateByZipCode(zipCode: zipCode, completion: { [weak self] result, error in
            guard let self = self else { return }
            self.delegate?.hideIndicatorInView()
            if error == nil {
                self.sendLocationToWeatherVC(lat: result?.lat ?? 0, lon: result?.lon ?? 0)
            } else {
                self.delegate?.requestDidFail(error ?? "No Error")
            }
        })
    }
    
    func getCurrentCoordinate() {
        self.locationService.successCompletion = { (coordinate) in
            self.sendLocationToWeatherVC(lat: coordinate.latitude, lon: coordinate.longitude)
        }
        locationService.start()
    }
    
    func sendLocationToWeatherVC(lat : Double , lon : Double) {
        saveCityToCoreData(lat: lat, lon: lon)
        locationDelegate?.getLocationCoordinate(lat: lat, lon: lon)
        dismiss()
    }
    
    func saveCityToCoreData(lat : Double , lon : Double) {
        let localCity = LocalCity(context: DataController.shared.viewContext)
        localCity.lat = lat
        localCity.lon = lon
        localCity.timeStamp = NSDate().timeIntervalSince1970
        saveChangesToCoreData()
    }
    
    func saveChangesToCoreData() {
        do {
            try DataController.shared.viewContext.save()
        }catch{
            print("Item Not Saved")
        }
    }
    
    func presentSelectCityVC(){
        router?.presentSelectCityVC()
    }
    
    func presentMapView() {
        router?.presentMapView()
    }
    
    func dismiss() {
        router?.dismiss()
    }
}
