//
//  Localization.swift
//  Pods
//
//  Created by Shiyuan Jiang on 4/7/16.
//
//

import Foundation

public enum Localization: String {
    case StringsFileName = "Localizable"
    
    case AccessoryButtonAccessibilityLabel = "ACCESSORY_BUTTON_ACCESSIBILITY_LABEL"
    case NumberInputTextFieldAccessibilityLabel = "NUMBER_INPUT_TEXTFIELD_ACCESSIBILITY_LABEL"
    case CVCInputTextFieldAccessibilityLabel = "CVC_TEXTFIELD_ACCESSIBILITY_LABEL"
    case MonthInputTextFieldAccessibilityLabel = "MONTH_INPUT_TEXTFIELD_ACCESSIBILITY_LABEL"
    case YearInputTextFieldAccessibilityLabel = "YEAR_INPUT_TEXTFIELD_ACCESSIBILITY_LABEL"
    
    case invalidCardNumber = "INVALID_CARD_NUMBER"
    case invalidExpirationDate = "INVALID_EXPIRATION_DATE"
    
    static func accessibilityLabelForTextField(textField: UITextField) -> String? {
        switch textField {
        case is NumberInputTextField:
            return Localization.NumberInputTextFieldAccessibilityLabel.rawValue
        case is CVCInputTextField:
            return Localization.CVCInputTextFieldAccessibilityLabel.rawValue
        case is MonthInputTextField:
            return Localization.MonthInputTextFieldAccessibilityLabel.rawValue
        case is YearInputTextField:
            return Localization.YearInputTextFieldAccessibilityLabel.rawValue
        default:
            return nil
        }
    }
}

