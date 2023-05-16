//
//  UIDate+Extension.swift
//  SellerApp
//
//  Created by Mohamad Basuony on 24/09/2022.
//

import Foundation
import UIKit

extension Date {
    func dateFormatTimeToString(format:String = "dd/MM/yyyy") -> String {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = format
//         dateFormatter.locale = Locale.userSelectedLocale
         return dateFormatter.string(from: self)
     }
    
    func getDateFormatted() -> String{
        let date = self
//            .date(withFormat: "yyyy-MM-dd'T'HH:mm:ss")
        let relativeDateFormatter = DateFormatter()
        relativeDateFormatter.timeStyle = .short
        relativeDateFormatter.dateStyle = .short
        relativeDateFormatter.doesRelativeDateFormatting = true
        return relativeDateFormatter.string(from: date)
    }
    
    func getShortDateFormate() -> String{
        let loc = Locale(identifier: "US")
        let formatter = DateFormatter()
        formatter.locale = loc
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
    
    func getElapsedInterval() -> String {
        
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self, to: Date())
        
        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year ago" : "\(year)" + " " + "years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month ago" : "\(month)" + " " + "months ago"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "day ago" : "\(day)" + " " + "days ago"
        } else if let hour = interval.hour, hour > 0 {
            return hour == 1 ? "\(hour)" + " " + "hour ago" : "\(hour)" + " " + "hours ago"
        } else if let minute = interval.minute, minute > 0 {
            return minute == 1 ? "\(minute)" + " " + "minute ago" : "\(minute)" + " " + "minutes ago"
        } else {
            return "a moment ago"
        }
    }
    
    func addTimeToTimeStamp(value : Int , type : Calendar.Component) -> Double{
        let calendar = Calendar.current
        let date = calendar.date(byAdding: type, value: value, to: self)
        return (date ?? Date()).timeIntervalSince1970
    }
}
