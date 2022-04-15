 //
 //  LocationInputView.swift
 //  UBER-CLONE-UIKIT-TRAINING
 //
 //  Created by mehmet karanlık on 15.04.2022.
 //

import UIKit

protocol LocationInputViewDelegate : AnyObject {
 func dismissLocationInputView()
}

class LocationInputView: UIView {
 
  // MARK:  Properties
 weak var delegate: LocationInputViewDelegate?
 
 let backButton : UIButton = {
  let button = UIButton()
  button.setImage(UIImage(named: "baseline_arrow_back_black_36dp")?.withRenderingMode(.alwaysOriginal), for: .normal)
  button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
  return button
 }()
 let titleLabel : UILabel = {
  let label = CustomLabel.makeSimpleLabel(labelText: "Amber", labelColor: UIColor.darkGray, topography: UIFont.TextStyle.body )
  label.font = .systemFont(ofSize: 16, weight: .bold)
  return label
 }()
 
 
 
  // MARK:  Lifecycle
 
 
 
  // MARK:  Selectors
 
 @objc func handleBackButtonTapped() {
  delegate?.dismissLocationInputView()
 }
 
 
 
 
 override init(frame: CGRect) {
  super.init(frame: frame)
  backgroundColor = .white
  addShadow()
  makeBackButton()
  makeTitleLabel()
 }
 
 required init?(coder aDecoder: NSCoder) {
  fatalError("init(coder:) has not been implemented")
 }
 
 
  // MARK:  Makers
 
 
 
 fileprivate func makeTitleLabel() {
  addSubview(titleLabel)
  titleLabel.centerX(inView: self)
  titleLabel.centerY(inView: backButton)
 }
 
 fileprivate func makeBackButton() {
  addSubview(backButton)
  backButton.anchor(top: self.topAnchor,
                    left: self.leftAnchor,
                    paddingTop: 40, paddingBottom: 0,
                    paddingRight: 0, paddingLeft: 20,
                    width: 24, height: 24)
  
 }
 
 
 
}
