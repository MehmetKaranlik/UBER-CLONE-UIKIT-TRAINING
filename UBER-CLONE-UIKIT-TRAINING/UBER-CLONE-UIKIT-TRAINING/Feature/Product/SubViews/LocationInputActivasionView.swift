 //
 //  LocationInputActivasionView.swift
 //  UBER-CLONE-UIKIT-TRAINING
 //
 //  Created by mehmet karanlık on 15.04.2022.
 //

import Foundation
import UIKit

protocol LocationActivationViewDelegate : AnyObject {
 func presentLocationInputView()
}

class LocationActivationView : UIView {
  // MARK:  Properties
 
 
 weak var delegate : LocationActivationViewDelegate?
 
 private let indicatiorView : UIView = {
  let indicatorView = UIView()
  indicatorView.backgroundColor = .black
  indicatorView.layer.cornerRadius = 5
  
  return indicatorView
 }()
 
 private let placeholderLabel : UILabel = {
  let label = UILabel()
  label.text = "Where to ?"
  label.font = .systemFont(ofSize: 18)
  label.textColor = .darkGray
  return label
 }()
 
 
  // MARK:  LifeCycle
 
 
 
  // MARK:  Selectors
 
 @objc func handleShowLocationInputView() {
  delegate?.presentLocationInputView()
  
 }
 
 
 
 override init(frame: CGRect) {
  
  super.init(frame: frame)
  
  configureContainerView()
  makeIndicatorView()
  makeLabelView()
  
 }
 
 
 
 required init?(coder aDecoder: NSCoder) {
  fatalError("init has not been implemented")
 }
 
 
 
 
  // MARK:  makers
 
 fileprivate func makeIndicatorView() {
  addSubview(indicatiorView)
  indicatiorView.centerY(inView: self)
  indicatiorView.anchor(left: self.leftAnchor, paddingTop: 0, paddingBottom: 0, paddingRight: 0, paddingLeft: 20, width: 6, height: 6)
  
 }
 
 fileprivate func makeLabelView() {
  addSubview(placeholderLabel)
  placeholderLabel.centerY(inView: self)
  placeholderLabel.anchor(left: indicatiorView.rightAnchor, paddingLeft: 16)
 }
 
 
 
 fileprivate func configureContainerView() {
  let tap = UITapGestureRecognizer(target: self, action: #selector(handleShowLocationInputView))
  addGestureRecognizer(tap)
  buildContainerUIConfig()
  UIView.animate(withDuration: 2, delay: 0, options: .allowAnimatedContent) {self.alpha = 1}
 }
 
 fileprivate func buildContainerUIConfig() {
  backgroundColor = .white
  alpha = 0
  addShadow()
 }
}
