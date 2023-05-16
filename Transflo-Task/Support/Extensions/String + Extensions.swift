//
//  String + Extensions.swift
//  SellerApp
//
//  Created by Mohamad Basuony on 12/10/2022.
//

import Foundation
import UIKit
import CoreData

extension String {
    func date(withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.date(from: self)
    }
    
    func getManagedObjectId()-> NSManagedObjectID{
        if let objectIDURL = URL(string: self) {
            let coordinator: NSPersistentStoreCoordinator = DataController.shared.viewContext.persistentStoreCoordinator ?? NSPersistentStoreCoordinator()
            let managedObjectID = coordinator.managedObjectID(forURIRepresentation: objectIDURL)
            return managedObjectID ?? NSManagedObjectID()
        }
        return NSManagedObjectID()
    }
    
    var isNumber: Bool {
            return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
        }
}

extension String {
    func dateFormatted(withFormat format : String , fromFormat : String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date ?? Date())
    }
    
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
