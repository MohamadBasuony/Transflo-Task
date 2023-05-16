//
//  SelectCityVC.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 17/04/2023.
//

import UIKit
// Need To Add Presenter and router here

protocol SelectCityProtocol : AnyObject {
    func selectCity(selectedCity : GetQueryResultsModelElement)
}

class SelectCityVC: UIViewController {
    
    @IBOutlet weak var citiesTV: UITableView!
    
    var presenter : SelectCityPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTV()
    }
    
    private func setupTV(){
        citiesTV.delegate = self
        citiesTV.dataSource = self
        citiesTV.registerNibFor(cellClass: CityCell.self)
    }

    @IBAction func dismissBtn(_ sender: Any) {
        presenter?.dismiss()
    }
    
}

extension SelectCityVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.cities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: CityCell.self)
        let city = presenter?.cities?[indexPath.row] ?? GetQueryResultsModelElement()
        cell.configCell(cityName: "\(city.name ?? ""), \(city.country ?? "")")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectCity(index: indexPath.row)
    }
}

