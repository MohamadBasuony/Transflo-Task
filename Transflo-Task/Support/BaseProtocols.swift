//
//  BaseProtocols.swift
//  Seller App
//
//  Created by Mohamad Basuony on 06/09/2022.
//

import Foundation

protocol BaseProtocol : AnyObject {
    func showIndicatorInView()
    func hideIndicatorInView()
    func requestDidFail(_ message : String)
}
