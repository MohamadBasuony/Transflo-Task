
//  RoundedView.swift
//  BirthDayChat
//
//  Created by Mohamad Basuony on 6/23/20.
//  Copyright © 2020 Mohamad Basuony. All rights reserved.
//

import UIKit
@IBDesignable

class RoundedView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()

        if self.tag == 1 {
                roundCorners(corners: [.topLeft, .topRight ,.bottomLeft], radius: 7.0)
        }else if self.tag == 2 {
                roundCorners(corners: [.topLeft, .topRight ,.bottomRight], radius: 7.0)
        }else if self.tag == 3 {
            roundCorners(corners: [.topLeft ,.bottomRight], radius: 15.0)
    }
    }
}
