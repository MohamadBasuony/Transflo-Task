//
//  ForecastPresenter.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 16/04/2023.
//

import Foundation
import CoreData

protocol ForecastDelegate: BaseProtocol {
    func getForecastDataDidSuccess()
}

protocol ForecastPresenter {
    var forecast : GetForecastModel? {get}
    
    func getForecast()
    func setDuration(duration : Int)
    func updateCoordinate(lat : Double , lon : Double)

    func presentSearchVC()
    func presentHistoryVC()
    func popToRoot()
}

class ForecastPresenterImplementation: ForecastPresenter {
        
    fileprivate weak var delegate: ForecastDelegate?
    fileprivate var gateway: ApiWeatherGateway?
    fileprivate var router: ForecastRouter?
    
    var forecast : GetForecastModel?
    var lat : Double?
    var lon : Double?
    var duration : Int?
    init(delegate: ForecastDelegate,
         gateway: ApiWeatherGateway,
         router : ForecastRouter,
         lat : Double?,
         lon : Double?
    ) {
        self.delegate = delegate
        self.gateway = gateway
        self.router = router
        self.lat = lat
        self.lon = lon
    }
    
    func getForecast(){
        delegate?.showIndicatorInView()
        gateway?.getForecast(duration : (duration ?? 0) / 3 ,lat: lat ?? 0, lon: lon ?? 0, completion: { [weak self] result, error in
            guard let self = self else { return }
            self.delegate?.hideIndicatorInView()
            if error == nil {
                self.forecast = result
                dump(self.forecast)
                self.delegate?.getForecastDataDidSuccess()
            } else {
                self.delegate?.requestDidFail(error ?? "No Error")
            }
        })
    }
    
    func setDuration(duration : Int) {
        self.duration = duration
        getForecast()
    }
    
    func updateCoordinate(lat : Double , lon : Double){
        self.lat = lat
        self.lon = lon
        getForecast()
    }
    
    private func fetchCity(){
        let fetchRequest : NSFetchRequest<LocalCity> = LocalCity.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timeStamp", ascending: false )]
        do {
            let localCities = try DataController.shared.viewContext.fetch(fetchRequest) as [LocalCity]
//            self.lastSearchedCity = localCities.first
            updateCityData(localCity: localCities.first ?? LocalCity())
        }catch{
            print("NO Items Found")
        }
    }
    
    private func updateCityData(localCity : LocalCity){
        localCity.cityName = "\(forecast?.city?.name ?? ""), \(forecast?.city?.country ?? "")"
        localCity.weather = WeatherData(context: DataController.shared.viewContext)
        localCity.weather?.city = localCity
        localCity.weather?.humidity = Double(forecast?.list?.first?.main?.humidity ?? 0)
        localCity.weather?.main = forecast?.list?.first?.weather?.first?.main ?? ""
        localCity.weather?.pressure = Double(forecast?.list?.first?.main?.pressure ?? 0)
        localCity.weather?.temp = forecast?.list?.first?.main?.temp ?? 0
        localCity.weather?.visibility = forecast?.list?.first?.visibilityInKM ?? 0
        localCity.weather?.visibility = forecast?.list?.first?.wind?.speed ?? 0
        saveChangesToCoreData()
    }
    
    private func saveChangesToCoreData() {
        do {
            try DataController.shared.viewContext.save()
        }catch{
            print("Item Not Saved")
        }
    }
    func presentSearchVC(){
        router?.presentSearchVC()
    }
    
    func presentHistoryVC(){
        router?.presentHistoryVC()
    }
    
    func popToRoot() {
        router?.popToRoot()
    }
}
