//
//  CardTextField+UITextFieldDelegate.swift
//  Caishen
//
//  Created by Daniel Vancura on 3/4/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import UIKit

extension CardTextField: CardInfoTextFieldDelegate {

    public func textField(textField: UITextField, didEnterValidInfo: String) {
        updateNumberColor()
        notifyDelegate()
        selectNextTextField(textField, prefillText: nil)
    }
    
    public func textField(textField: UITextField, didEnterPartiallyValidInfo: String) {
        updateNumberColor()
        notifyDelegate()
    }
    
    public func textField(textField: UITextField, didEnterOverflowInfo overFlowDigits: String) {
        updateNumberColor()
        selectNextTextField(textField, prefillText: overFlowDigits)
    }

    private func selectNextTextField(textField: UITextField, prefillText: String?) {
        var nextTextField: UITextField?
        if textField == monthTextField {
            nextTextField = yearTextField
        } else if textField == yearTextField {
            nextTextField = cvcTextField
        }

        nextTextField?.becomeFirstResponder()

        guard let prefillText = prefillText else {
            return
        }
        
        nextTextField?.delegate?.textField?(nextTextField!, shouldChangeCharactersInRange: NSMakeRange(0, (nextTextField?.text ?? "").characters.count), replacementString: prefillText)
    }
    
    private func updateNumberColor() {
        // if the expiration date is not valid, set the text color for the date to `invalidNumberColor`
        if !expirationDateIsValid() {
            let invalidInputColor = self.invalidInputColor ?? UIColor.redColor()
            // if the expiration date text fields haven't been assigned invalid input color
            if monthTextField?.textColor != invalidInputColor && yearTextField?.textColor != invalidInputColor {
                monthTextField?.textColor = invalidInputColor
                yearTextField?.textColor = invalidInputColor
            }
        } else {
            monthTextField?.textColor = numberInputTextField?.textColor ?? UIColor.blackColor()
            yearTextField?.textColor = numberInputTextField?.textColor ?? UIColor.blackColor()
        }
    }

    /**
     return the validity of the entered expiration date

     if the expiration date is Expiry.invalid, it means that no real date is calculated yet,
     then return true because we do not know if the expiration date is valid or not.

     if the expiration date is fully entered (and then calculated automatically) and is a time in the future,
     then return true because we know that it is a valid expiration date

     otherwise, return false

     - returns: the validity of the entered expiration date
     */
    private func expirationDateIsValid() -> Bool {
        return card.expiryDate == Expiry.invalid || card.expiryDate.rawValue.timeIntervalSinceNow > 0
    }
}
