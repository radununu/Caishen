//
//  CardTextField+ViewAnimations.swift
//  Caishen
//
//  Created by Daniel Vancura on 3/9/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import UIKit

public extension CardTextField {
    // MARK: - View animations
    
    /**
     Moves the card number input field to the left outside of the screen with an animation of the duration `viewAnimationDuration`, so that only the last group of the card number is visible. At the same time, the card detail (expiration month and year and CVC) slide in from the right.
     */
    internal func moveNumberFieldLeftAnimated() {
        UIView.animateWithDuration(viewAnimationDuration ?? 0.3, animations: { [weak self] _ in
            self?.moveNumberFieldLeft()
            })
    }
    
    /**
     Moves the full card number input field to inside the screen with an animation of the duration `viewAnimationDuration`. At the same time, the card detail (expiration month and year and CVC) slide outside the view.
     */
    internal func moveNumberFieldRightAnimated() {
        UIView.animateWithDuration(viewAnimationDuration ?? 0.3, animations: { [weak self] _ in
            self?.moveNumberFieldRight()
            })
    }
    
    /**
     Moves the card number input field to the left outside of the screen, so that only the last group of the card number is visible. At the same time, the card detail (expiration month and year and CVC) are displayed to its right.
     */
    internal func moveNumberFieldLeft() {
        // If the card number is invalid, do not allow to move to the card detail
        if cardType?.validateNumber(card.bankCardNumber) != .Valid {
            return
        }
        numberInputTextField?.becomeFirstResponder()
        if let rect = numberInputTextField?.rectForLastGroup() {
            numberInputTextField?.transform =
                CGAffineTransformMakeTranslation(-rect.origin.x, 0)
        } else {
            numberInputTextField?.alpha = 0
        }
        numberInputTextField?.resignFirstResponder()
        cardInfoView?.transform = CGAffineTransformIdentity
    }
    
    /**
     Moves the full card number input field to inside the screen. At the same time, the card detail (expiration month and year and CVC) are moved outside the view.
     */
    internal func moveNumberFieldRight() {
        let infoTextFields: [UITextField?] = [monthTextField, yearTextField, cvcTextField]
        infoTextFields.forEach({$0?.resignFirstResponder()})
        numberInputTextField?.transform = CGAffineTransformIdentity
        numberInputTextField?.alpha = 1
        cardInfoView?.transform = CGAffineTransformMakeTranslation(superview!.bounds.width, 0)
    }
}