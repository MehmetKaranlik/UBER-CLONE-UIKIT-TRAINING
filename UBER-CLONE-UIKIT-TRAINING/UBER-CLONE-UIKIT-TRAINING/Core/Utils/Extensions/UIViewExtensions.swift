//
//  UIViewExtensions.swift
//  UBER-CLONE-UIKIT-TRAINING
//
//  Created by mehmet karanlık on 13.04.2022.
//

import Foundation
import UIKit


extension UIView {
 
 func anchor(
  top:NSLayoutYAxisAnchor? = nil,
  bottom : NSLayoutYAxisAnchor? = nil,
  right : NSLayoutXAxisAnchor? = nil,
  left : NSLayoutXAxisAnchor? = nil,
  paddingTop:CGFloat = 0,
  paddingBottom:CGFloat = 0,
  paddingRight:CGFloat = 0,
  paddingLeft:CGFloat = 0,
  width: CGFloat? = nil,
  height: CGFloat? = nil) {

   self.translatesAutoresizingMaskIntoConstraints = false

   if let top = top {
    topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
   }

   if let left = left {
    leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
   }

   if let bottom = bottom {
    bottomAnchor.constraint(equalTo:  bottom, constant: -paddingBottom).isActive = true
   }

   if let right = right {
    rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
   }

   if let width = width {
    widthAnchor.constraint(equalToConstant: width).isActive = true
   }

   if let height = height {
    heightAnchor.constraint(equalToConstant: height).isActive = true
   }



 }

 func centerX(inView view : UIView) {
  self.translatesAutoresizingMaskIntoConstraints = false
  self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
 }
 func centerY(inView view : UIView) {
  self.translatesAutoresizingMaskIntoConstraints = false
  self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
 }

 func asCircle() {
  self.layer.cornerRadius = self.frame.height / 2
  self.layer.masksToBounds = true
 }

 func addShadow() {
  self.layer.shadowColor = UIColor.black.cgColor
  self.layer.shadowOpacity = 0.45
  self.layer.shadowOffset = CGSize(width: 1, height: 1)
  self.layer.masksToBounds = false
 }
}
