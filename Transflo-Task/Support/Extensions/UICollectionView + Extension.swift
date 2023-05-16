//
//  UICollectionView + Extension.swift
//  Seller App
//
//  Created by Mohamad Basuony on 07/09/2022.
//

import Foundation
import UIKit.UICollectionView
extension UICollectionView {
    
    func registerNibFor(cellClass: UICollectionViewCell.Type) {
        self.register(UINib(nibName: cellClass.cellNibName, bundle: nil),
                      forCellWithReuseIdentifier: cellClass.cellIdentifier)
    }
    
    func registerClassFor(cellClass: UICollectionViewCell.Type) {
        self.register(cellClass, forCellWithReuseIdentifier: cellClass.cellIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(cellClass: T.Type, for indexPath: IndexPath) -> T {
        
        guard let cell: T = self.dequeueReusableCell(withReuseIdentifier: cellClass.cellIdentifier,
                                                     for: indexPath) as? T else {
                                                        fatalError("no \(cellClass.cellIdentifier) registered")
        }
        return cell
    }
}

extension UICollectionViewCell {
    
    static var cellIdentifier: String {
        return NSStringFromClass(Self.self)
    }
    
    static var cellNibName: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last ?? ""
    }
}
