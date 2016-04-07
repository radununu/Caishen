//
//  StylizedTextField.swift
//  Caishen
//
//  Created by Daniel Vancura on 2/10/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import UIKit

/// A text field that provides additional UI customization.
@IBDesignable
public class StylizedTextField: UITextField, UITextFieldDelegate {
    
    /**
     Changes to this parameter draw the border of `self` in the given width.
     */
    @IBInspectable
    public var borderWidth: CGFloat = 0 {
        didSet {
            if borderWidth >= 0 {
                self.borderStyle = .None
                self.layer.borderWidth = CGFloat(borderWidth)
            } else {
                self.borderStyle = .RoundedRect
                self.layer.borderWidth = 0
            }
        }
    }
    
    /**
     If `borderWidth` has been set, changes to this parameter round the corners of `self` in the given corner radius.
     */
    @IBInspectable
    public var cornerRadius: CGFloat = 0 {
        didSet {
            if cornerRadius >= 0 {
                self.layer.cornerRadius = cornerRadius
            }
        }
    }
    
    /**
     If `borderWidth` has been set, changes to this parameter change the color of the border of `self`.
     */
    @IBInspectable
    public var borderColor: UIColor = UIColor.blackColor() {
        didSet {
            self.layer.borderColor = self.borderColor.CGColor
        }
    }
    
    /**
     A method which will be called, when the delete key has been pressed for an empty text field.
     */
    public var deleteBackwardCallback: ((UITextField) -> Void)?
    
    public override var text: String? {
        didSet {
            if (text ?? "").isEmpty {
                deleteBackwardCallback?(self)
            } else if text == UITextField.emptyTextFieldCharacter {
                drawPlaceholderInRect(textInputView.bounds)
            }
            setNeedsDisplay()
        }
    }
    
    /**
     The color in which text flashes, when the user is about to enter an invalid card number.
     */
    @IBInspectable public var invalidInputColor: UIColor = UIColor.redColor()
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.delegate = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.delegate = self
    }
    
    public override func drawRect(rect: CGRect) {
        if text == "" || text == UITextField.emptyTextFieldCharacter {
            super.drawPlaceholderInRect(rect)
        } else {
            super.drawRect(rect)
        }
    }
    
    public override func drawPlaceholderInRect(rect: CGRect) {
        
    }
    
    public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
