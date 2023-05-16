//
//  HistoryPresenter.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 24/04/2023.
//

import Foundation
import CoreData

protocol HistoryDelegate: BaseProtocol {
    func didGetCitiesSuccessfully()
}

protocol HistoryPresenter {
    var cities : [LocalCity]? {get}
    
    func getSearchedCities()
    func sendLocationToWeatherVC(lat : Double , lon : Double)
    
    func pop()
}

class HistoryPresenterImplementation: HistoryPresenter {
        
    fileprivate weak var delegate: HistoryDelegate?
    fileprivate var gateway: ApiWeatherGateway?
    fileprivate var router: HistoryRouter?
    weak var locationDelegate : GetLocationCoordinatedProtocol?
    var fetchLimit : Int?
    
    var cities: [LocalCity]?
    init(delegate: HistoryDelegate,
         gateway: ApiWeatherGateway,
         router : HistoryRouter,
         locationDelegate : GetLocationCoordinatedProtocol,
         fetchLimit : Int
    ) {
        self.delegate = delegate
        self.gateway = gateway
        self.router = router
        self.locationDelegate = locationDelegate
        self.fetchLimit = fetchLimit
    }
    
    func getSearchedCities() {
        let fetchRequest : NSFetchRequest<LocalCity> = LocalCity.fetchRequest()
        fetchRequest.fetchLimit = fetchLimit ?? 0
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timeStamp", ascending: false)]
        do {
            let cities = try DataController.shared.viewContext.fetch(fetchRequest) as [LocalCity]
            self.cities = cities
            
            delegate?.didGetCitiesSuccessfully()
        }catch{
            print("NO Items Found")
        }
    }
    
    func sendLocationToWeatherVC(lat : Double , lon : Double) {
        locationDelegate?.getLocationCoordinate(lat: lat, lon: lon)
        pop()
    }
    
    
    func pop() {
        router?.pop()
    }
}
 
