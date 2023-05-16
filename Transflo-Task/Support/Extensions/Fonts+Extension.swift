//
//  Fonts+Extension.swift
//  MarketPlace
//
//  Created by Mohamad Basuony on 12/12/2022.
//

import Foundation
import UIKit

extension UIFont {
    
    @objc
    class func appRegularFont(ofSize size: CGFloat) -> UIFont? {
        return UIFont(name: FontFamily.Quicksand.regular.name, size: size)
    }
    
    @objc
    class func appFont(ofSize fontSize: CGFloat, weight: UIFont.Weight) -> UIFont? {
        if weight == UIFont.Weight.medium {
            return UIFont(name: FontFamily.Quicksand.regular.name, size: fontSize)
        }
        
        if weight == UIFont.Weight.light {
            return UIFont(name: FontFamily.Quicksand.light.name, size: fontSize)
        }
        return UIFont.appFont(ofSize: fontSize, weight: weight)
    }
    
    @objc
    class func appBoldSystemFont(ofSize size: CGFloat) -> UIFont? {
        return UIFont(name: FontFamily.Quicksand.bold.name, size: size)
    }
    
    @objc
    convenience init?(appCoder aDecoder: NSCoder) {
        
        guard
            let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
                self.init(appCoder: aDecoder)
                return
        }
        
        var fontName = ""
        switch fontAttribute {
        case "CTFontLightUsage":
            fontName = FontFamily.Quicksand.light.name
        case "CTFontRegularUsage":
            fontName = FontFamily.Quicksand.regular.name
        case "CTFontMediumUsage":
            fontName = FontFamily.Quicksand.regular.name
        case "CTFontBoldUsage":
            fontName = FontFamily.Quicksand.bold.name
        default:
            self.init(appCoder: aDecoder)
            print("[Font warning], no font supported for fontAttribute ", fontAttribute)
            return
        }
        
        self.init(name: fontName, size: fontDescriptor.pointSize)
    }
    
    class func overrideInitialize() {
        
        guard self == UIFont.self else { return }
        
        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
            let appSystemFontMethod = class_getClassMethod(self, #selector(appRegularFont(ofSize:))) {
            method_exchangeImplementations(systemFontMethod, appSystemFontMethod)
        }
        
        if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
            let appBoldSystemFontMethod = class_getClassMethod(self, #selector(appBoldSystemFont(ofSize:))) {
            method_exchangeImplementations(boldSystemFontMethod, appBoldSystemFontMethod)
        }
        
        if let weightSystemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:weight:))),
            let weightAppFontMethod = class_getClassMethod(self, #selector(appFont(ofSize:weight:))) {
            method_exchangeImplementations(weightSystemFontMethod, weightAppFontMethod)
        }
        
        if let initCoderMethod = class_getInstanceMethod(self,
                                                         #selector(UIFontDescriptor.init(coder:))),
            let appInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(appCoder:))) {
            method_exchangeImplementations(initCoderMethod, appInitCoderMethod)
        }
    }
}

extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}
