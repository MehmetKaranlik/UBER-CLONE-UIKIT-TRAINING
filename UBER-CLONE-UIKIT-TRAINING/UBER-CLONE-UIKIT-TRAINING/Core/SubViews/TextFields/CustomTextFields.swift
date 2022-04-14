//
//  CustomTextFields.swift
//  UBER-CLONE-UIKIT-TRAINING
//
//  Created by mehmet karanlık on 13.04.2022.
//

import Foundation
import UIKit


open class CustomTextField : UITextField {
 public static func makeSimpleTextField(
  textColor : UIColor?=nil,
  textFont : UIFont.TextStyle,
  capitalizationStyle : UITextAutocapitalizationType?=nil,
  placeholderText : String?=nil,
  placeholderTextColor : UIColor?=nil,
  isSecure : Bool?=false


 ) -> UITextField {
  let textField = UITextField()
  textField.textColor = textColor
  textField.font = .preferredFont(forTextStyle: textFont)
  textField.autocapitalizationType = capitalizationStyle ?? .sentences
  textField.keyboardAppearance = .dark
  textField.borderStyle = .none
  textField.attributedPlaceholder = .init(string: placeholderText ?? "", attributes: [NSAttributedString.Key.foregroundColor  : placeholderTextColor ?? textColor])
  textField.isSecureTextEntry = isSecure ?? false
  return textField
 }
}
