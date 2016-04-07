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
    
    /**
     Updates the color of month and year text field based on whether or not the input into those text fields is valid or not.
     */
    private func updateNumberColor() {
        // if the date is Expiry.invalid, it means that no real date is calculated yet
        // if the calculated real date is in the past, set the text color for the date to `invalidNumberColor`
        if card.expiryDate.rawValue.timeIntervalSinceNow < 0 && card.expiryDate != Expiry.invalid {
            monthTextField?.textColor = invalidInputColor ?? UIColor.redColor()
            yearTextField?.textColor = invalidInputColor ?? UIColor.redColor()
        } else {
            monthTextField?.textColor = numberInputTextField?.textColor ?? UIColor.blackColor()
            yearTextField?.textColor = numberInputTextField?.textColor ?? UIColor.blackColor()
        }
    }
}
