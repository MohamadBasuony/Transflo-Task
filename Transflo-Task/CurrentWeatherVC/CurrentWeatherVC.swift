//
//  CurrentWeatherVC.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 16/04/2023.
//

import UIKit
protocol GetLocationCoordinatedProtocol: AnyObject {
    func getLocationCoordinate(lat : Double , lon : Double)
}

class CurrentWeatherVC: UIViewController {
  
    @IBOutlet weak var cityNameLbl: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var mainLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var windLbl: UILabel!
    @IBOutlet weak var pressureLbl: UILabel!
    @IBOutlet weak var visibilityLbl: UILabel!
    @IBOutlet weak var maxTempLbl: UILabel!
    @IBOutlet weak var minTempLbl: UILabel!
    @IBOutlet weak var celsiusBtn: UIButton!
    
    let config = CurrentWeatherConfiguratorImplementation()
    var presenter : CurrentWeatherPresenter?
    var cityName = ""
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Current Weather"
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        getData()
    }
    
    private func getData(){
        presenter?.getCurrentWeather()
    }
    
    @IBAction func celsiusBtn(_ sender: UIButton) {
        celsiusBtn.isSelected = !celsiusBtn.isSelected
        switchTemperature()
    }
        
    @IBAction func searchBtn(_ sender: Any) {
        presenter?.presentSearchVC()
    }
    
    
    @IBAction func forecastBtn(_ sender: Any) {
        presenter?.pushToForecastVC()
    }
    
    @IBAction func historyBtn(_ sender: Any) {
        presenter?.presentHistoryVC()
    }
}

extension CurrentWeatherVC {
    private func setupUI(){
        cityNameLbl.text = "\(presenter?.weatherData?.name ?? "--"), \(presenter?.weatherData?.sys?.country ?? "--")"
        mainLbl.text = presenter?.weatherData?.weather?.first?.main ?? "--"
        humidityLbl.text = "\(presenter?.weatherData?.main?.humidity ?? 0)%"
        windLbl.text = "\(presenter?.weatherData?.wind?.speed ?? 0) m/s"
        visibilityLbl.text = "\(presenter?.weatherData?.visibilityInKM ?? 0) KM"
        pressureLbl.text = "\(presenter?.weatherData?.main?.pressure ?? 0) mmHg"
        switchTemperature()
    }
    
    private func switchTemperature(){
        temperatureLbl.text = "\(presenter?.getTemperature(inCelsius: celsiusBtn.isSelected) ?? "--")"
        maxTempLbl.text = "\(presenter?.getMaxTemperature(inCelsius: celsiusBtn.isSelected) ?? "--")"
        minTempLbl.text = "\(presenter?.getMinTemperature(inCelsius: celsiusBtn.isSelected) ?? "--")"
    }
}

extension CurrentWeatherVC : CurrentWeatherDelegate {
    func getCurrentWeatherDataDidSuccess() {
        setupUI()
    }
}

extension CurrentWeatherVC : GetLocationCoordinatedProtocol {
    func getLocationCoordinate(lat: Double, lon: Double) {
        presenter?.updateCoordinate(lat : lat , lon : lon)
    }
}
