//
//  UIViewController+Extension.swift
//  Seller App
//
//  Created by Mohamad Basuony on 06/09/2022.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import CoreData

extension UIViewController {

    func setupNav(){
        let shadowView = UIView(frame: self.navigationController!.navigationBar.frame)
        shadowView.backgroundColor = UIColor.white
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowColor = UIColor.lightGray.cgColor
        shadowView.layer.shadowOpacity = 0.8
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        shadowView.layer.shadowRadius = 2
        view.addSubview(shadowView)
    }
    
    func isIPad() -> Bool {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return true
        } else {
            return false
        }
    }
    
    func alertError(_ message: String){
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func alertErrorWithAction(_ message: String , action : UIAlertAction){
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(ok)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
//    override open var shouldAutorotate: Bool {
//        get {
//            if let visibleVC = visibleViewController {
//                return visibleVC.shouldAutorotate
//            }
//            return super.shouldAutorotate
//        }
//    }
//
//    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
//        get {
//            if let visibleVC = visibleViewController {
//                return visibleVC.preferredInterfaceOrientationForPresentation
//            }
//            return super.preferredInterfaceOrientationForPresentation
//        }
//    }

//    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask{
//        get {
//            if let visibleVC = visibleViewController {
//                return visibleVC.supportedInterfaceOrientations
//            }
//            return super.supportedInterfaceOrientations
//        }
//    }
    
    var top: UIViewController? {
        if let controller = self as? UINavigationController {
            return controller.topViewController?.top
        }
        if let controller = self as? UISplitViewController {
            return controller.viewControllers.last?.top
        }
        if let controller = self as? UITabBarController {
            return controller.selectedViewController?.top
        }
        if let controller = presentedViewController {
            return controller.top
        }
        return self
    }
}

extension UIViewController : BaseProtocol ,NVActivityIndicatorViewable{
    func requestDidFail(_ message: String) {
        alertError(message)
    }
    
    func showIndicatorInView() {
        startAnimating()
    }
    
    func hideIndicatorInView() {
        stopAnimating()
    }
}

extension UIViewController {
    func embedViewController(_ vc: UIViewController?, to containerView: UIView) {
        
        guard let vc = vc else {
            return
        }
        
        if vc.parent == self {
            return
        }
        
        vc.willMove(toParent: self)
        
        // Add to containerview
        containerView.addSubview(vc.view)
        self.addChild(vc)
        
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vc.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            vc.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            vc.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            vc.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        vc.didMove(toParent: self)
    }
    
    func erasViewController(_ vc: UIViewController?) {
        
        guard let vc = vc else {
            return
        }
        
        if vc.parent != self {
            return
        }
        
        vc.willMove(toParent: nil)
        vc.view.removeFromSuperview()
        vc.removeFromParent()
    }
}

