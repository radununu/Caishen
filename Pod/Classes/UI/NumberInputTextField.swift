//
//  NumberInputTextField.Swift
//  Caishen
//
//  Created by Daniel Vancura on 2/9/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import UIKit

/**
 This kind of text field only allows entering card numbers and provides means to customize the appearance of entered card numbers by changing the card number group separator.
 */
@IBDesignable
public class NumberInputTextField: StylizedTextField {

    // MARK: - Variables
    
    /**
     The card number that has been entered into this text field. 
     
     - note: This card number may be incomplete and invalid while the user is entering a card number. Be sure to validate it against a proper card type before assuming it is valid.
     */
    public var cardNumber: Number {
        let textFieldTextUnformatted = cardNumberFormatter.unformattedCardNumber(text ?? "")
        return Number(rawValue: textFieldTextUnformatted)
    }
    
    /**
     */
    @IBOutlet public weak var numberInputTextFieldDelegate: NumberInputTextFieldDelegate?
    
    /**
     The string that is used to separate different groups in a card number.
     */
    @IBInspectable public var cardNumberSeparator: String = "-" {
        didSet {
            placeholder = cardNumberFormatter.formattedCardNumber(self.placeholder ?? "1234123412341234")
        }
    }

    override public var placeholder: String? {
        didSet {
            guard let placeholder = placeholder else {
                return
            }

            let isUnformatted = (placeholder == self.cardNumberFormatter.unformattedCardNumber(placeholder))
        
            // Format the placeholder, if not already done
            if isUnformatted && cardNumberSeparator != "" {
                self.placeholder = cardNumberFormatter.formattedCardNumber(placeholder)
            }
        }
    }
    
    public override var accessibilityValue: String? {
        get {
            // In order to read digits of the card number one by one, return them as "4 1 1 ..." separated by single spaces and commas inbetween groups for pauses
            var singleDigits: [Character] = []
            var lastCharWasReplacedWithComma = false
            text?.characters.forEach({
                if !"0123456789".characters.contains($0) {
                    if !lastCharWasReplacedWithComma {
                        singleDigits.append(",")
                        lastCharWasReplacedWithComma = true
                    } else {
                        lastCharWasReplacedWithComma = false
                    }
                }
                singleDigits.append($0)
                singleDigits.append(" ")
            })
            return String(singleDigits)
                + ". "
                + NSLocalizedString(Localization.cardType.rawValue,
                                    tableName: Localization.StringsFileName.rawValue,
                                    bundle: NSBundle(forClass: CardTextField.self),
                                    comment: "Description for detected card type.")
                + ": "
                + cardTypeRegister.cardTypeForNumber(cardNumber).name
        }
        
        set {  }
    }
    
    private var _textColor: UIColor?
    override public var textColor: UIColor? {
        get {
            return _textColor
        }
        set {
            /// Just store the text color in `_textColor`. It will be set as soon as input has been entered by setting super.textColor = _textColor.
            /// This is to avoid overriding `textColor` with `invalidInputColor` when invalid input has been entered.
            _textColor = newValue
        }
    }

    
    /**
     The card type register that holds information about which card types are accepted and which ones are not.
     */
    private let cardTypeRegister: CardTypeRegister = CardTypeRegister.sharedCardTypeRegister
    
    /**
     A card number formatter used to format the input
     */
    private var cardNumberFormatter: CardNumberFormatter {
        return CardNumberFormatter(cardTypeRegister: cardTypeRegister, separator: cardNumberSeparator)
    }
    
    // MARK: - UITextFieldDelegate
    
    public override func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // Current text in text field, formatted and unformatted:
        let textFieldTextFormatted = NSString(string: textField.text ?? "")
        // Text in text field after applying changes, formatted and unformatted:
        let newTextFormatted = textFieldTextFormatted.stringByReplacingCharactersInRange(range, withString: string)
        let newTextUnformatted = cardNumberFormatter.unformattedCardNumber(newTextFormatted)
        
        // Set the text color to invalid - this will be changed to `validTextColor` later in this method if the input was valid
        super.textColor = invalidInputColor
        
        if !newTextUnformatted.isEmpty && !newTextUnformatted.isNumeric() {
            return false
        }

        let parsedCardNumber = Number(rawValue: newTextUnformatted)
        let oldValidation = cardTypeRegister.cardTypeForNumber(cardNumber).validateNumber(cardNumber)
        let newValidation =
            cardTypeRegister.cardTypeForNumber(parsedCardNumber).validateNumber(parsedCardNumber)

        if !newValidation.contains(.NumberTooLong) {
            cardNumberFormatter.replaceRangeFormatted(range, inTextField: textField, withString: string)
            numberInputTextFieldDelegate?.numberInputTextFieldDidChangeText(self)
        } else if oldValidation == .Valid {
            // If the card number is already valid, should call numberInputTextFieldDidComplete on delegate
            // then set the text color back to normal and return
            numberInputTextFieldDelegate?.numberInputTextFieldDidComplete(self)
            super.textColor = _textColor
            return false
        } else {
            notifyUserCardNumberInvalidityInVoiceOverAccessibility()
        }

        let newLengthComplete =
            parsedCardNumber.length == cardTypeRegister.cardTypeForNumber(parsedCardNumber).maxLength

        if newLengthComplete && newValidation != .Valid {
            addAccessibilityNotificationObserverToNotifyUserCardNumberInvalidity()
        } else if newValidation == .Valid {
            numberInputTextFieldDelegate?.numberInputTextFieldDidComplete(self)
        }
        
        /// If the number is incomplete or valid, assume it's valid and show it in `textColor`
        /// Also, if the number is of unknown type and the full IIN has not been entered yet, assume it's valid.
        if (newValidation.contains(.UnknownType) && newTextUnformatted.characters.count <= 6) || newValidation.contains(.NumberIncomplete) || newValidation == .Valid {
            super.textColor = _textColor
        }

        return false
    }
    
    public func prefillInformation(cardNumber: String) {
        let validCharacters: Set<Character> = Set("0123456789".characters)
        let unformattedCardNumber = String(cardNumber.characters.filter({validCharacters.contains($0)}))
        let cardNumber = Number(rawValue: unformattedCardNumber)
        let type = cardTypeRegister.cardTypeForNumber(cardNumber)
        let numberPartiallyValid = type.checkCardNumberPartiallyValid(cardNumber) == .Valid
        
        if numberPartiallyValid {
            let formatter = cardNumberFormatter
            text = formatter.formattedCardNumber(unformattedCardNumber)
            numberInputTextFieldDelegate?.numberInputTextFieldDidChangeText(self)
        }
    }
    
    // MARK: - Helper functions
    
    /**
     Computes the rect that contains the specified text range within the text field.
     - precondition: This function will only work, when `textField` is the first responder. If `textField` is not first responder, `textField.beginningOfDocument` will not be initialized and this function will return nil.
     - parameter range: The range of the text in the text field whose bounds should be detected.
     - parameter textField: The text field containing the text.
     - returns: A rect indicating the location and bounds of the text within the text field, or nil, if an invalid range has been entered.
     */
    private func rectForTextRange(range: NSRange, inTextField textField: UITextField) -> CGRect? {
        guard let rangeStart = textField.positionFromPosition(textField.beginningOfDocument, offset: range.location) else {
            return nil
        }
        guard let rangeEnd = textField.positionFromPosition(rangeStart, offset: range.length) else {
            return nil
        }
        guard let textRange = textField.textRangeFromPosition(rangeStart, toPosition: rangeEnd) else {
            return nil
        }
        
        return textField.firstRectForRange(textRange)
    }
    
    /**
     - precondition: This function will only work, when `self` is the first responder. If `self` is not first responder, `self.beginningOfDocument` will not be initialized and this function will return nil.
     - returns: The CGRect in `self` that contains the last group of the card number.
     */
    public func rectForLastGroup() -> CGRect? {
        guard let lastGroupLength = text?.componentsSeparatedByString(cardNumberFormatter.separator).last?.characters.count else {
            return nil
        }
        guard let textLength = text?.characters.count else {
            return nil
        }
        
        return rectForTextRange(NSMakeRange(textLength - lastGroupLength, lastGroupLength), inTextField: self)
    }
    
    // MARK: Accessibility
    
    /**
     Add an observer to listen to the event of UIAccessibilityAnnouncementDidFinishNotification, and then post an accessibility
     notification to user that the entered card number is not valid.
     
     The reason why can't we just post an accessbility notification is that only the last accessibility notification would be read to users.
     As each time users input something there will be an accessibility notification from the system which will always replace what we have
     posted here. Thus we need to listen to the notification from the system first, wait until it is finished, and post ours afterwards.
     */
    private func addAccessibilityNotificationObserverToNotifyUserCardNumberInvalidity() {
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(notifyUserCardNumberInvalidityInVoiceOverAccessibility),
                                                         name: UIAccessibilityAnnouncementDidFinishNotification,
                                                         object: nil)
    }
    
    /**
     Notify user the entered card number is invalid when accessibility is turned on
     */
    @objc private func notifyUserCardNumberInvalidityInVoiceOverAccessibility() {
        let localizedString = NSLocalizedString(Localization.invalidCardNumber.rawValue,
                                                tableName: Localization.StringsFileName.rawValue,
                                                bundle: NSBundle(forClass: CardTextField.self),
                                                comment: "The expiration date entered is not valid")
        UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, localizedString)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
