//
//  ForecastVC.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 16/04/2023.
//

import UIKit

class ForecastVC: UIViewController {

    @IBOutlet weak var forecastTV: UITableView!
    @IBOutlet weak var cityNameLbl: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var next24Btn: UIButton!
    @IBOutlet weak var next48Btn: UIButton!
    
    var presenter : ForecastPresenter?

    override func viewWillAppear(_ animated: Bool) {
        self.title = "Forecast"
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        presenterInit()
        setupTV()
        getData()
        switchSelection(is24Selected : true)
    }
    
    
    private func setupTV(){
        forecastTV.delegate = self
        forecastTV.dataSource = self
        forecastTV.registerNibFor(cellClass: ForecastCell.self)
    }
    
    private func getData(){
        presenter?.setDuration(duration: 24)
    }
    
    @IBAction func next24Btn(_ sender: Any) {
        switchSelection(is24Selected : true)
        presenter?.setDuration(duration: 24)
    }
    
    @IBAction func next48Btn(_ sender: Any) {
        switchSelection(is24Selected : false)
        presenter?.setDuration(duration: 48)
    }

    @IBAction func dashboardBtn(_ sender: Any) {
        presenter?.popToRoot()
    }
    
    @IBAction func searchBtn(_ sender: Any) {
        presenter?.presentSearchVC()
    }
    
    @IBAction func historyBtn(_ sender: Any) {
        presenter?.presentHistoryVC()
    }
}

extension ForecastVC {
    private func setupUI(){
        cityNameLbl.text = "\(presenter?.forecast?.city?.name ?? ""),\(presenter?.forecast?.city?.country ?? "")"
        temperatureLbl.text = "\((presenter?.forecast?.list?.first?.main?.temp ?? 0).showTwoDecimalPoints())"
    }
}

extension ForecastVC : ForecastDelegate {
    func getForecastDataDidSuccess() {
        forecastTV.reloadData()
        setupUI()
    }
}

extension ForecastVC {

    private func switchSelection(is24Selected : Bool){
        next24Btn.isSelected = is24Selected
        next48Btn.isSelected = !is24Selected
    }
}

extension ForecastVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.forecast?.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: ForecastCell.self)
        cell.cellConfig(forecastModel: presenter?.forecast?.list?[indexPath.row] ?? List())
        return cell
    }
}

extension ForecastVC : GetLocationCoordinatedProtocol {
    func getLocationCoordinate(lat: Double, lon: Double) {
        presenter?.updateCoordinate(lat: lat, lon: lon)
    }
}
