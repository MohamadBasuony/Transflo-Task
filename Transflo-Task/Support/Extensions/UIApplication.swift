//
//  UIApplication.swift
//  AJEL
//
//  Created by Michelle Gerges on 7/31/18.
//  Copyright © 2018 Michelle Gerges. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift
import MapKit

extension UIWindow {
    class var current: UIWindow? {
        
        if #available(iOS 13.0, *) {
            return (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window
        }
//        else {
//            return (UIApplication.shared.delegate as? AppDelegate)?.window
//        }
    }
}

extension UIApplication {
    
    var topViewController: UIViewController? {
        
        let window = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window
        let rootNaviationController = window?.rootViewController as? UINavigationController
        return rootNaviationController?.topViewController ?? window?.rootViewController
    }
    
    func restartTo(_ viewController: UIViewController) {
        
        if let window = UIWindow.current {
            
            UIView.transition(with: window,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: {
                                window.rootViewController = viewController
                                
            },
                              completion: nil)
        }
    }
    
//    func restartToLocationPicker() {
//
//        let didSetLocation = {
//            if UserDefaultsService.shared.isUserLoggedin {
//                UIApplication.shared.restartToHome()
//            } else {
//                UIApplication.shared.restartToMobileLogin()
//            }
//        }
//
//        let locationPickerVC = LocationPermissionViewController(completion: didSetLocation)
//        self.restartTo(BeutiNavigationController(rootViewController: locationPickerVC))
//    }
//
//    func restartToHome() {
//        self.restartTo(BeutiTabBarController())
//    }
//
//    func restartToMobileLogin() {
//        let vc = LoginLandingViewController()
//        //vc.restartApp = true
//        self.restartTo(BeutiNavigationController(rootViewController: vc))
//    }
    
    func openURLWithSafariBrowser(_ urlString: String?) {
        
        if let urlString = urlString,
            let url = URL(string: urlString) {
            self.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func callA(number: String?) {
        
        if let numberItSelf = number,
            let url = URL(string: "tel://\(numberItSelf)") {
            self.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func sendMail(email: String?) {
        
        if let emailItSelf = email,
            let url = URL(string: "mailto://\(emailItSelf)") {
            self.open(url, options: [:], completionHandler: nil)
        }
    }
    
    /*
     ### It Opens Map Application ###
     
     it check if the device has google Maps app
     if not then it opens apple default maps app
     
     - Parameter latitude: coodrinate
     - Parameter longitude: coordinate
     - Returns: Void.
     */
    
    func openMapsApp(latitude: Double?, longitude: Double?, name: String? = nil) {
        
        guard let lat = latitude, let long = longitude else { return }
        
        guard let googleMapsAppSchemaURL = URL(string: "comgooglemaps://"),
            let googleMapsAppURL = URL(string: "comgooglemaps://?center=\(lat),\(long)&q=\(lat),\(long)"),
            let appleMapsAppSchemaURL = URL(string: "http://maps.apple.com"),
            let googleMapsWepsitURL = URL(string: "https://www.google.com/maps/@\(lat),\(long)") else {
                return
        }
        
        if self.canOpenURL(googleMapsAppSchemaURL) {
            self.open(googleMapsAppURL, options: [:], completionHandler: nil)
            return
        }
        
        if self.canOpenURL(appleMapsAppSchemaURL) {
            
            let coordinates = CLLocationCoordinate2DMake(lat, long)
            let placemark = MKPlacemark(coordinate: coordinates)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = name
            mapItem.openInMaps(launchOptions: nil)
            
            return
        }
        
        self.open(googleMapsWepsitURL, options: [:], completionHandler: nil)
    }
    
    func goToAppSettings() {
        
        if let locationSettingsUrl = URL(string: UIApplication.openSettingsURLString) {
            self.open(locationSettingsUrl, options: [:], completionHandler: nil)
        }
    }
}
