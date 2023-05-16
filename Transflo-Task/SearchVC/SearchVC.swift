//
//  SearchVC.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 17/04/2023.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var cityNameTF: UITextField!
    @IBOutlet weak var zipCodeTF: UITextField!
    @IBOutlet weak var searchBySwitch: UISwitch!
    
    let config = SearchConfiguratorImplementation()
    var presenter : SearchPresenter?
    weak var delegate : GetLocationCoordinatedProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectLocationBtn(_ sender: Any) {
        presenter?.presentMapView()
    }
    
    @IBAction func searchBtn(_ sender: Any) {
        if validateInputs ()  {
            if searchBySwitch.isOn {
                presenter?.getCoordinateByQuery(query: cityNameTF.text!)
            }else{
                presenter?.getCoordinateByZipCode(zipCode: zipCodeTF.text!)
            }
        }
    }
    
    @IBAction func dismissBtn(_ sender: UIButton) {
        presenter?.dismiss()
    }
    
}

extension SearchVC : SearchDelegate {
}

extension SearchVC {
    private func validateInputs () -> Bool {
        var valid = true
        
        if searchBySwitch.isOn {
            if (cityNameTF.text?.isEmpty ?? true) {
                valid = false
                alertError("Please Make Sure to enter city name")
            }
        }else{
            if (zipCodeTF.text?.isEmpty ?? true) {
                valid = false
                alertError("Please Make Sure to enter Zip code")
            }
        }
        return valid
    }
}

extension SearchVC : SelectCityProtocol {
    func selectCity(selectedCity: GetQueryResultsModelElement) {
        presenter?.sendLocationToWeatherVC(lat: selectedCity.lat ?? 0, lon: selectedCity.lon ?? 0)
    }
}

extension SearchVC : GetLocationCoordinatedProtocol {
    func getLocationCoordinate(lat: Double, lon: Double) {
        presenter?.sendLocationToWeatherVC(lat: lat , lon: lon)
    }
}
