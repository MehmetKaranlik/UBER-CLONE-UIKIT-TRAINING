 //
 //  RoundedRectangleButton.swift
 //  UBER-CLONE-UIKIT-TRAINING
 //
 //  Created by mehmet karanlık on 14.04.2022.
 //

import Foundation
import UIKit


open class RoundedRectangleButton : UIButton {
 public static func makeSimpleButton(
  title : String ,
  backgroundColor : UIColor?,
  foregroundColor: UIColor?,
  titleFont : UIFont.TextStyle,
  configuration : UIButton.Configuration


 ) -> UIButton {
  let button = UIButton(type: .roundedRect)
   button.setTitle(title, for: [])
   button.configuration = configuration
   button.setTitleColor(foregroundColor, for: [])


   button.titleLabel?.text = title
   button.titleLabel?.textColor = .white
   button.titleLabel?.font = .preferredFont(forTextStyle: titleFont)
   button.configuration = configuration

   return button
  }
}
