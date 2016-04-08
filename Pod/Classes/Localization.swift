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
    
    static func accessibilityLabelForTextField(textField: UITextField, comment: String?) -> String? {
        switch textField {
        case is NumberInputTextField:
            return Localization.NumberInputTextFieldAccessibilityLabel.localizedStringWithComment(comment)
        case is CVCInputTextField:
            return Localization.CVCInputTextFieldAccessibilityLabel.localizedStringWithComment(comment)
        case is MonthInputTextField:
            return Localization.MonthInputTextFieldAccessibilityLabel.localizedStringWithComment(comment)
        case is YearInputTextField:
            return Localization.YearInputTextFieldAccessibilityLabel.localizedStringWithComment(comment)
        default:
            return nil
        }
    }
    
    func localizedStringWithComment(comment: String?) -> String {
        return NSLocalizedString(self.rawValue,
                                 tableName: Localization.StringsFileName.rawValue,
                                 bundle: NSBundle(forClass: CardTextField.self),
                                 comment: comment ?? "")
    }
}

