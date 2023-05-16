//
//  UIViewExtensions.swift
//  GDP
//
//  Created by Michelle Gerges on 9/14/17.
//  Copyright © 2017 Michelle Gerges. All rights reserved.
//

import UIKit

extension UIView {
    
    func animateHeartbeating() {
        
        let animation = CASpringAnimation(keyPath: "transform.scale")
        
        animation.duration = 0.25
        
        animation.fromValue = 1.0
        animation.toValue = 1.25
        
        animation.autoreverses = true
        
        animation.initialVelocity = 0.5
        animation.damping = 0.8
        
        self.layer.add(animation, forKey: "beating")
    }
    
    func animateShakeing() {
        
        let animation = CASpringAnimation(keyPath: "transform.translation.x")
        
        animation.fromValue = 0
        animation.toValue = 10
        
        animation.duration = 0.1
        animation.repeatCount = 2
        animation.autoreverses = true
        
        animation.initialVelocity = 0.0
        animation.damping = 0.5
        
        self.layer.add(animation, forKey: "shaking")
    }
    
    var isHiddenIfNeeded: Bool {
        get {
            return self.isHidden
        }
        set {
            if self.isHidden != newValue {
                self.isHidden = newValue
            }
        }
    }
    
    func hideAnimated( completion: (() -> Void)? = nil ) {
        
        if self.isHidden { return }
        if self.superview is UIStackView {
            UIView.animate(withDuration: 0.25, animations: {
                self.isHidden = true
            }, completion: { _ in
                completion?()
            })
            return
        }
        
        self.alpha = 1
        self.isHidden = false
        
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0
        }, completion: { _ in
            self.alpha = 1
            self.isHidden = true
            completion?()
        })
    }
    
    func showupAnimated(_ completion:(() -> Void)? = nil) {
        
        if !self.isHidden { return }
        if self.superview is UIStackView {
            UIView.animate(withDuration: 0.25, animations: {
                self.isHidden = false
            }, completion: { _ in
                completion?()
            })
            return
        }
        self.alpha = 0
        self.isHidden = false
        
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 1
        }, completion: { _ in
            completion?()
        })
    }
    
    var width: CGFloat {
        return self.bounds.width
    }
    
    var heightValue: CGFloat {
        return self.bounds.height
    }
    
    func loadFromNib(addConstrains: Bool) {
        
        guard let view = Bundle.main.loadNibNamed(String(describing: type(of: self)),
                                                  owner: self,
                                                  options: nil)?.first as? UIView else { return }
        view.frame = self.bounds
        self.addSubview(view)
        
        if addConstrains {
            self.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                self.topAnchor.constraint(equalTo: view.topAnchor),
                self.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }
    
    func addPrimaryShadow() {
        
        self.layer.shadowColor = UIColor(red: 0.862, green: 0.871, blue: 0.9, alpha: 0.8).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 1.0
    }
    func removePrimaryShadow() {
        
        self.layer.shadowColor = UIColor.clear.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 0
        self.layer.shadowOpacity = 0.0
    }
    
    func setTransformFullBottom() {
        self.transform = CGAffineTransform(translationX: 0, y: self.bounds.maxY)
    }
    
    func setTransformFullTop() {
        self.transform = CGAffineTransform(translationX: 0, y: -self.bounds.maxY)
    }
    
    func setTransformIdentity() {
        self.transform = CGAffineTransform.identity
    }
    
    func constrainToEdges(_ subview: UIView) {
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let topContraint = NSLayoutConstraint(
            item: subview,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1.0,
            constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(
            item: subview,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0)
        
        let leadingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1.0,
            constant: 0)
        
        let trailingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self,
            attribute: .trailing,
            multiplier: 1.0,
            constant: 0)
        
        addConstraints([
            topContraint,
            bottomConstraint,
            leadingContraint,
            trailingContraint])
    }
}

extension UITextView {
    
//    func trim() -> UITextView {
//        self.text = self.text?.trim()
//        return self
//    }
    
    var isEmpty: Bool {
        return (self.text ?? "").isEmpty
    }
}

extension UIView {
    @discardableResult
    func fromNib<T : UIView>() -> T? {
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
            // xib not loaded, or its top view is of the wrong type
            return nil
        }
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layoutAttachAll(to: self)   // 6
        return contentView
    }
    
    func layoutAttachAll(to childView:UIView)
    {
        var constraints = [NSLayoutConstraint]()
        
        childView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(NSLayoutConstraint(item: childView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0))
        constraints.append(NSLayoutConstraint(item: childView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0))
        constraints.append(NSLayoutConstraint(item: childView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0))
        constraints.append(NSLayoutConstraint(item: childView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0))
        
        childView.addConstraints(constraints)
    }
}

extension UIView{
    func animShow(){
        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseIn],
                       animations: {
                        self.center.y -= self.bounds.height
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    func animHide(){
        UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear],
                       animations: {
                        self.center.y += self.bounds.height
                        self.layoutIfNeeded()

        },  completion: {(_ completed: Bool) -> Void in
        self.isHidden = true
            })
    }
}

extension UIView {
 var hairlineImageView: UIImageView? {
    return hairlineImageView(in: self)
}

 func hairlineImageView(in view: UIView) -> UIImageView? {
    if let imageView = view as? UIImageView, imageView.bounds.height <= 1.0 {
        return imageView
    }

    for subview in view.subviews {
        if let imageView = self.hairlineImageView(in: subview) { return imageView }
    }
    return nil
  }
}  

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
