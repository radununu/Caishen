//
//  StringExtension.swift
//  Caishen
//
//  Created by Sagar Natekar on 11/23/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

import Foundation

extension String {

    //http://stackoverflow.com/a/30404532/1565974
    
    /**
     Converts an NSRange object for characters in `self` to a Range<String.Index> for use in methods expecting a Range.
     
     - parameter nsRange: The NSRange object that should be converted to Range.
     
     - returns: `nsRange` converted to Range<String.Index> or nil, if its start and/or end location are not within `self`.
     */
    func rangeFromNSRange(nsRange: NSRange) -> Range<String.Index>? {
        let from16 = utf16.startIndex.advancedBy(nsRange.location, limit: utf16.endIndex)
        let to16 = from16.advancedBy(nsRange.length, limit: utf16.endIndex)
        if let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self) {
                return from ..< to
        }
        return nil
    }

    /**
     Converts a Range<String.Index> object in `self` to an NSRange object for use in methods expecting an NSRange.
     
     - parameter range: The Range object that should be converted to NSRange.
     
     - returns: An NSRange object that is equivalent to `range`.
     */
    func NSRangeFromRange(range : Range<String.Index>) -> NSRange {
        let utf16view = self.utf16
        let from = String.UTF16View.Index(range.startIndex, within: utf16view)
        let to = String.UTF16View.Index(range.endIndex, within: utf16view)
        return NSMakeRange(utf16view.startIndex.distanceTo(from), from.distanceTo(to))
    }
    
    /**
     Convenience method to retreive a substring of `self`.
     
     - parameter fromInclusively: The index of the first character that should be included in the substring.
     - parameter toExclusively: The index of the last character that should no longer be included in the substring.
     - returns: Substring starting with the character at index `fromInclusiveley` and ending before the character at index `toExclusively`.
    */
    subscript(fromInclusively: Int, toExclusively: Int) -> String? {
        if characters.count < toExclusively || fromInclusively >= toExclusively {
            return nil
        }
        return self.substringWithRange((self.startIndex.advancedBy(fromInclusively)..<self.startIndex.advancedBy(toExclusively)))
    }
    
    /**
     - returns: True if this string contains only digits.
     */
    func isNumeric() -> Bool {
        return characters.reduce(true, combine: { return $0 && "0123456789".characters.contains($1)})
    }
}
