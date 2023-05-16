//
//  HistoryVC.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 24/04/2023.
//

import UIKit

class HistoryVC: UIViewController {
    @IBOutlet weak var citiesTV: UITableView!

    let config = HistoryConfiguratorImplementation()
    var presenter : HistoryPresenter?
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "History"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTV()
        getData()
    }
    
    private func getData(){
        presenter?.getSearchedCities()
    }

    private func setupTV(){
        citiesTV.delegate = self
        citiesTV.dataSource = self
        citiesTV.registerNibFor(cellClass: CityCell.self)
    }
}

extension HistoryVC : HistoryDelegate {
    func didGetCitiesSuccessfully() {
        citiesTV.reloadData()
    }
}

extension HistoryVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.cities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: CityCell.self)
        let city = presenter?.cities?[indexPath.row]
        cell.configCell(cityName: "\(city?.cityName ?? ""), \(city?.country ?? "")")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        delegate?.selectCity(selectedCity: cities[indexPath.row])
//        presenter?.dismiss()
        let city = presenter?.cities?[indexPath.row]
        presenter?.sendLocationToWeatherVC(lat: city?.lat ?? 0, lon: city?.lon ?? 0)
    }
}
