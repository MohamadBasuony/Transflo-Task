//
//  MapView.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 16/05/2023.
//

import UIKit
import MapKit

class MapView: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    var presenter : MapViewPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setDelegate()
    }
    
    private func setDelegate(){
        mapView.delegate = self
    }

    @IBAction func selectLocationBtn(_ sender: Any) {
        presenter?.sendLocationToWeatherVC()
    }
    

    @IBAction func selectCurrentLocationBtn(_ sender: Any) {
        presenter?.getCurrentCoordinate()
    }
    @IBAction func dismissBtn(_ sender: Any) {
        presenter?.dismiss()
    }
    
}

extension MapView : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        presenter?.setCoordinate(lat: mapView.centerCoordinate.latitude, lon: mapView.centerCoordinate.longitude)
       }
}

extension MapView : MapViewDelegate {
    func selectLocationDidFail(_ message: String) {
        alertError(message)
    }
}
