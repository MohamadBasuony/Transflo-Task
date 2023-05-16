//
//  DashBoardPresenter.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 15/04/2023.
//

import Foundation
import CoreData

protocol DashBoardDelegate: BaseProtocol {
    func getLastSearchedCitySuccessfully()
}

protocol DashBoardPresenter {
    var lastSearchedCity : LocalCity? {get}
    
    func getLastSearchedCity()
    
    func pushToCurrentWeatherVC()
    func pushToForecastVC()
}

class DashBoardPresenterImplementation: DashBoardPresenter {
        
    fileprivate weak var delegate: DashBoardDelegate?
    fileprivate var gateway: ApiWeatherGateway?
    fileprivate var router: DashBoardRouter?
    
    var lastSearchedCity : LocalCity?
    
    init(delegate: DashBoardDelegate,
         gateway: ApiWeatherGateway,
         router : DashBoardRouter
    ) {
        self.delegate = delegate
        self.gateway = gateway
        self.router = router
    }
    
    func getLastSearchedCity(){
        let fetchRequest : NSFetchRequest<LocalCity> = LocalCity.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timeStamp", ascending: false )]
        do {
            let localCities = try DataController.shared.viewContext.fetch(fetchRequest) as [LocalCity]
            self.lastSearchedCity = localCities.first
            checkWeatherLifeSpan()
        }catch{
            print("NO Items Found")
        }
    }
    
    private func checkWeatherLifeSpan(){
        if ((self.lastSearchedCity?.weather?.timeToLive ?? 0) < Date().timeIntervalSince1970 && self.lastSearchedCity?.weather?.timeToLive != nil) {

            deleteWeatherData(objectId: (lastSearchedCity?.weather!.objectID)!)

        }
        delegate?.getLastSearchedCitySuccessfully()
    }
    
    func deleteWeatherData(objectId: NSManagedObjectID) {
        let object = DataController.shared.viewContext.object(with: objectId)
        DataController.shared.viewContext.delete(object)
        saveChangesToCoreData()
    }
    
    private func saveChangesToCoreData() {
        do {
            try DataController.shared.viewContext.save()
        }catch{
            print("Item Not Saved")
        }
    }
    
    func pushToCurrentWeatherVC() {
        router?.pushToCurrentWeatherVC(lat: lastSearchedCity?.lat, lon : lastSearchedCity?.lon)
    }
    
    func pushToForecastVC() {
        router?.pushToForecastVC(lat: lastSearchedCity?.lat, lon : lastSearchedCity?.lon)
    }
}
