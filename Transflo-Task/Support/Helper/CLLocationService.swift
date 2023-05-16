//
//  CLLocationService.swift
//  Transflo-Task
//
//  Created by Mohamad Basuony on 19/04/2023.
//

import Foundation
import UIKit
import CoreLocation

struct UserLocation: Codable {
    var latitude: Double
    var longitude: Double
    var address: String?
    
    init(latitude: Double, longitude: Double, address: String?) {
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
    }
    
    init(coordinate: CLLocationCoordinate2D, address: String?) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
        self.address = address
    }
    
    init(location: CLLocation, address: String?) {
        self.init(coordinate: location.coordinate, address: address)
    }
    
    static let zero = UserLocation(latitude: 0.0, longitude: 0.0, address: nil)
}

class CLLocationService: NSObject {
    
    var locationManager: CLLocationManager = {
        return CLLocationManager()
    }()
    
    var successCompletion: ((UserLocation) -> Void)?
    var failedCompletion: (() -> Void)?
    var permissionDenied: (() -> Void)?
    
    func start() {
        
        locationManager.delegate = self
        
        if CLLocationManager.locationServicesEnabled() {
            
            switch(CLLocationManager.authorizationStatus()) {
                
            case .notDetermined:
                self.locationManager.requestWhenInUseAuthorization()
                
            case .restricted, .denied:
                failedCompletion?()
                
            case .authorizedAlways, .authorizedWhenInUse:
                
                locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
                locationManager.startUpdatingLocation()
            @unknown default:
                return
            }
        } else {
            failedCompletion?()
        }
    }
    
    func goToLocationSettings() {
        UIApplication.shared.goToAppSettings()
    }
}

extension CLLocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locationManager.location {
            
            successCompletion?(UserLocation(location: location, address: nil))
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        switch(CLLocationManager.authorizationStatus()) {

        case .notDetermined:
            break

        case .restricted, .denied:
            permissionDenied?()

        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
}
