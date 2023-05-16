//
//  UIScene + Extensions.swift
//  Seller App
//
//  Created by Mohamad Basuony on 06/09/2022.
//

import Foundation
import UIKit

extension UISceneDelegate {
    func isIPad() -> Bool {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return true
        } else {
            return false
        }
    }
}
