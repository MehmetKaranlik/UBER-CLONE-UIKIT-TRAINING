//
//  CustomLabel.swift
//  UBER-CLONE-UIKIT-TRAINING
//
//  Created by mehmet karanlık on 13.04.2022.
//

import Foundation
import UIKit



open class CustomLabel : UILabel {

 public static func  makeSimpleLabel(labelText : String, labelColor : UIColor?=nil, topography : UIFont.TextStyle? = nil ) -> UILabel {
  let label = UILabel()
  label.text = labelText
  label.textColor = labelColor ?? .white
  if let topography = topography {
   label.font = .preferredFont(forTextStyle: topography)
  }

  return label
 }
}
