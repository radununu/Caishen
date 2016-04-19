//
//  CardTypeRegister.swift
//  Caishen
//
//  Created by Daniel Vancura on 2/17/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import UIKit

/// A `CardTypeRegister` is used to maintain the range of accepted card types. You can provide different card type registers for different CardTextField's and customize the range of accepted card types individually.
public class CardTypeRegister {
    
    /**
     The default card type register, shared among all CardTextFields.
     */
    public static let sharedCardTypeRegister = CardTypeRegister()
    
    /// An array of all registered card types. You can edit this array with `registerCardType`, `unregisterCardType` or `setRegisteredCardTypes`.
    public private(set) var registeredCardTypes: [CardType]
    
    /**
     Creates a new `CardTypeRegister` with the following card types:
     - AmericanExpress
     - DinersClub
     - Discover
     - JCB
     - MasterCard
     - Visa
     */
    init() {
        registeredCardTypes = [
            AmericanExpress(),
            DinersClub(),
            Discover(),
            JCB(),
            MasterCard(),
            Visa()
        ]
    }
    
    /**
     Adds the provided card type to the array of registered card types.
     
     - parameter cardType: The card type that should be contained in this card type register.
     */
    public func registerCardType(cardType: CardType) {
        if registeredCardTypes.contains({ $0.isEqualTo(cardType) }) {
            return
        }

        registeredCardTypes.append(cardType)
    }
    
    /**
     Removes the provided card type from the array of registered card types.
     
     - parameter cardType: The card type that should be removed from this card type register.
     */
    public func unregisterCardType(cardType: CardType) {
        registeredCardTypes = registeredCardTypes.filter { !$0.isEqualTo(cardType) }
    }
    
    /**
     Replaces the range of registered card types.
     
     - parameter cardTypes: The new range of card types contained in this card type register.
     */
    public func setRegisteredCardTypes<T: SequenceType where T.Generator.Element == CardType>(cardTypes: T) {
        registeredCardTypes = [CardType]()
        registeredCardTypes.appendContentsOf(cardTypes)
    }
    
    /**
     Retreives a card type for a specific card number by parsing the Issuer Identification Numbers in the registered card types and matching them with the provided card number.
     
     - important: When creating custom card types, you should make sure, that there are no conflicts in the Issuer Identification Numbers you provide. For example, using [309] to detect a Diners Club card and using [3096] to detect a JCB card will not cause issues as IINs are parsed with the highest numbers first, i.e. the numbers that provide the most context possible, which will return a JCB card in this case. However, no two card types should provide the exact same number (like [309] to detect both a Diners Club card and a JCB card)!
     
     - parameter cardNumber: The card number whose CardType should be determined
     
     - returns: An instance of UnknownCardType, if no card type matches the Issuer Identification Number of the provided card number or any other card type that matches the card number.
     */
    public func cardTypeForNumber(cardNumber: Number) -> CardType {
        for i in (0...min(cardNumber.length, 6)).reverse() {
            if let substring = cardNumber.rawValue[0,i], let substringAsNumber = Int(substring) {
                if let firstMatchingCardType = registeredCardTypes.filter({
                    $0.identifyingDigits.contains(substringAsNumber)
                }).first {
                    return firstMatchingCardType
                }
            }
        }
        
        return UnknownCardType()
    }

}