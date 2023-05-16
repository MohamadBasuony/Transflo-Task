//
//  DashBoardVC.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 15/04/2023.
//

import UIKit

class DashBoardVC: UIViewController {
    @IBOutlet weak var cityNameLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    
    let config = DashBoardConfiguratorImplementation()
    var presenter : DashBoardPresenter?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        getData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenterInit()
    }
    
    private func presenterInit(){
        config.configure(dashBoardVC: self)
    }
    
    private func getData(){
        presenter?.getLastSearchedCity()
    }
    
    @IBAction func currentWeatherBtn(_ sender: Any) {
        presenter?.pushToCurrentWeatherVC()
    }
    
    @IBAction func forecastBtn(_ sender: Any) {
        presenter?.pushToForecastVC()
    }

}

extension DashBoardVC {
    private func setupUI(){
        let tempString = (presenter?.lastSearchedCity?.weather?.temp ?? 0).showTwoDecimalPoints()
        tempLbl.text = tempString == "0.00" ? "--" : tempString
        cityNameLbl.text = presenter?.lastSearchedCity?.cityName ?? ""
    }
}

extension DashBoardVC : DashBoardDelegate {
    func getLastSearchedCitySuccessfully() {
        setupUI()
    }
}
