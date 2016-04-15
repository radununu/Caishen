//
//  Expiry.swift
//  Caishen
//
//  Created by Sagar Natekar on 11/24/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

import Foundation

private let gregorianCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!

/**
 A Credit Card Expiry date
 */
public struct Expiry: RawRepresentable {

    static let invalid = Expiry(rawValue: NSDate(timeIntervalSince1970: 0))

    public typealias RawValue = NSDate

    public let rawValue: NSDate

    public var month: UInt {
        return UInt(components().month)
    }

    public var year: UInt {
        return UInt(components().year)
    }

    /**
     Creates a `CardExpiry` with the given string.
     - parameter string: A string of the form MM/YYYY or MM/YY
     */
    public init?(string: String) {
        // Make sure that there is only one non-numeric separation character in the entire string
        guard string.stringByTrimmingCharactersInSet(NSCharacterSet.decimalDigitCharacterSet()).characters.count == 1 else {
            return nil
        }
        
        let regex = try! NSRegularExpression(pattern: "^(\\d{1,2})[/|-](\\d{1,4})", options: .CaseInsensitive)
        var monthStr: String = ""
        var yearStr: String = ""
        
        guard let match = regex.firstMatchInString(string, options: .ReportProgress, range: NSMakeRange(0, string.characters.count)) else {
            return nil
        }
        
        let monthRange = match.rangeAtIndex(1)
        if monthRange.length > 0, let range = string.rangeFromNSRange(monthRange) {
            monthStr = string.substringWithRange(range)
        } else {
            return nil
        }
        
        let yearRange = match.rangeAtIndex(2)
        if yearRange.length > 0, let range = string.rangeFromNSRange(yearRange) {
            yearStr = string.substringWithRange(range)
        } else {
            return nil
        }
        
        self.init(month: monthStr, year: yearStr)
    }

    /**
     Creates a CardExpiry with the given month and year as String.
     */
    public init?(month: String, year: String) {
        guard let monthVal = UInt(month), yearVal = UInt(year) where year.characters.count >= 2 else {
            return nil
        }
        
        self.init(month: monthVal, year: yearVal)
    }

    /**
     Creates a CardExpiry with the given numeric month and year.
     */
    public init?(month: UInt, year: UInt) {
        let numberPrefix: UInt = 2000
        let minYear: UInt = 2000

        let yearValue: UInt = {
            if year < 100 {
                return year + numberPrefix
            }

            return year
        }()

        guard (1...12).contains(month) else {
            return nil
        }

        guard yearValue >= minYear else {
            return nil
        }

        guard let date = toDate(month, year: yearValue) else {
            return nil
        }

        self.init(rawValue: date)
    }

    public init(rawValue: NSDate) {
        self.rawValue = rawValue
    }

    private func components() -> NSDateComponents {
        return gregorianCalendar.components([.Year, .Month], fromDate: rawValue)
    }
}

extension Expiry: CustomStringConvertible {

    public var description: String {
            return String(format: "%02i/%04i", arguments: [month, year])
    }

}


private func toDate(month: UInt, year: UInt) -> NSDate? {
    let dateComponents = NSDateComponents()
    dateComponents.day = 1
    dateComponents.month = Int(month)
    dateComponents.year = Int(year)

    if let gregorianCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian),
        let components = gregorianCalendar.dateFromComponents(dateComponents) {
            let monthRange = gregorianCalendar.rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month,
                forDate:components)

            dateComponents.day = monthRange.length
            dateComponents.hour = 23
            dateComponents.minute = 59

            return gregorianCalendar.dateFromComponents(dateComponents)
    }

    return nil
}
