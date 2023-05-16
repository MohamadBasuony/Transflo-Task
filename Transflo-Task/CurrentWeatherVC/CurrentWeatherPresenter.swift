//
//  CurrentWeatherPresenter.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 16/04/2023.
//

import Foundation
import CoreData

protocol CurrentWeatherDelegate: BaseProtocol {
    func getCurrentWeatherDataDidSuccess()
}

protocol CurrentWeatherPresenter {
    var weatherData : GetCurrentWeatherModel? {get}
    
    func getCurrentWeather()
    func getTemperature(inCelsius : Bool) -> String
    func getMinTemperature(inCelsius : Bool) -> String
    func getMaxTemperature(inCelsius : Bool) -> String
    func updateCoordinate(lat : Double , lon : Double)
    
    func presentSearchVC()
    func pushToForecastVC()
    func presentHistoryVC()
}

class CurrentWeatherPresenterImplementation: CurrentWeatherPresenter {
        
    fileprivate weak var delegate: CurrentWeatherDelegate?
    fileprivate var gateway: ApiWeatherGateway?
    fileprivate var router: CurrentWeatherRouter?
    var lat : Double?
    var lon : Double?
    
    var weatherData: GetCurrentWeatherModel?
    init(delegate: CurrentWeatherDelegate,
         gateway: ApiWeatherGateway,
         router : CurrentWeatherRouter,
         lat : Double?,
         lon : Double?
    ) {
        self.delegate = delegate
        self.gateway = gateway
        self.router = router
        self.lat = lat
        self.lon = lon
    }
    
    func presentSearchVC() {
        router?.presentSearchVC()
    }
    
    func getCurrentWeather(){
        delegate?.showIndicatorInView()
        gateway?.getCurrentWeather(lat: lat ?? 0, lon: lon ?? 0, completion: { [weak self] result, error in
            guard let self = self else { return }
            self.delegate?.hideIndicatorInView()
            if error == nil {
                self.weatherData = result
                self.fetchCity()
                self.delegate?.getCurrentWeatherDataDidSuccess()
            } else {
                self.delegate?.requestDidFail(error ?? "No Error")
            }
        })
    }
    
    func updateCoordinate(lat : Double , lon : Double){
        self.lat = lat
        self.lon = lon
        getCurrentWeather()
    }
    
    func getTemperature(inCelsius: Bool) -> String {
        return "\(inCelsius ? (weatherData?.main?.tempInCelsius ?? 0).showTwoDecimalPoints() : (weatherData?.main?.temp ?? 0).showTwoDecimalPoints() )"
    }
    
    func getMinTemperature(inCelsius: Bool) -> String {
        return "\(inCelsius ? (weatherData?.main?.tempMinInCelsius ?? 0).showTwoDecimalPoints() : (weatherData?.main?.tempMin ?? 0).showTwoDecimalPoints())"
    }
    
    func getMaxTemperature(inCelsius: Bool) -> String {
        return "\(inCelsius ? (weatherData?.main?.tempMaxInCelsius ?? 0).showTwoDecimalPoints() : (weatherData?.main?.tempMax ?? 0).showTwoDecimalPoints())"
    }
    
    func pushToForecastVC() {
        if weatherData != nil {
            router?.pushToForecastVC(lat: weatherData?.coord?.lat ?? 0, lon : weatherData?.coord?.lon ?? 0 )
        }else{
            delegate?.requestDidFail("Please search for a city first")
        }
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
        localCity.cityName = "\(weatherData?.name ?? ""), \(weatherData?.sys?.country ?? "")"
        localCity.weather = WeatherData(context: DataController.shared.viewContext)
        localCity.weather?.city = localCity
        localCity.weather?.humidity = Double(weatherData?.main?.humidity ?? 0)
        localCity.weather?.main = weatherData?.weather?.first?.main ?? ""
        localCity.weather?.pressure = Double(weatherData?.main?.pressure ?? 0)
        localCity.weather?.temp = weatherData?.main?.temp ?? 0
        localCity.weather?.visibility = weatherData?.visibilityInKM ?? 0
        localCity.weather?.visibility = weatherData?.wind?.speed ?? 0
        if (localCity.weather?.timeToLive == nil || localCity.weather?.timeToLive == 0) {
            localCity.weather?.timeToLive = Date().addTimeToTimeStamp(value: 5, type: .minute)
        }

        saveChangesToCoreData()
    }
    
    private func saveChangesToCoreData() {
        do {
            try DataController.shared.viewContext.save()
        }catch{
            print("Item Not Saved")
        }
    }
    
    func presentHistoryVC() {
        router?.presentHistoryVC()
    }
}
