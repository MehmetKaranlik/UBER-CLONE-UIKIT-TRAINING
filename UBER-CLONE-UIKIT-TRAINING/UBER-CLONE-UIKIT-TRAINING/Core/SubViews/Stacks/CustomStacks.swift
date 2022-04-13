//
//  CustomStacks.swift
//  UBER-CLONE-UIKIT-TRAINING
//
//  Created by mehmet karanlık on 13.04.2022.
//

import Foundation
import UIKit


open class CustomStack : UIStackView {
 public static func makeSimpleHStack(alignment: UIStackView.Alignment?=nil, spacing : CGFloat?=nil,children : [UIView]) -> UIStackView {
  let stack = UIStackView()
  stack.axis = .horizontal
  stack.alignment = alignment ?? .center
  stack.spacing = spacing ?? 0
  children.forEach { view in
   stack.addArrangedSubview(view)
  }
  return stack
 }
}
