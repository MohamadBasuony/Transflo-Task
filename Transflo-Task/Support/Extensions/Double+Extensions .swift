//
//  Double+Extensions .swift
//  MarketPlace
//
//  Created by Mohamad Basuony on 02/02/2023.
//

import Foundation

extension Double {
    
    func showTwoDecimalPoints() -> String{
        return String(format: "%.2f", self)
    }
}
