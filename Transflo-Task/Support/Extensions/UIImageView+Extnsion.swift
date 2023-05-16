//
//  UIImageView+Extnsion.swift
//  SellerApp
//
//  Created by Mohamad Basuony on 28/09/2022.
//

import Foundation
import SDWebImage

extension UIImageView {
    func downloadImage(path : String , placeHolder : UIImage = UIImage()){
        let url = URL(string: path)
        self.sd_setImage(with: url, placeholderImage: placeHolder, context: nil)
    }
}
