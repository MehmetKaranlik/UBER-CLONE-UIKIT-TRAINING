 //
 //  LocationInputView.swift
 //  UBER-CLONE-UIKIT-TRAINING
 //
 //  Created by mehmet karanlık on 15.04.2022.
 //

import UIKit

protocol LocationInputViewDelegate {
 func dismissLocationInputView()
 func executeSearch(query: String)
}

class InputView: UIView {
 
  // MARK:  Properties
 weak var delegate: LocationInputViewDelegate?
 
 let backButton : UIButton = {
  let button = UIButton()
  button.setImage(UIImage(named: "baseline_arrow_back_black_36dp")?
   .withRenderingMode(.alwaysOriginal), for: .normal)

  button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)

  return button
 }()
 var titleLabel : UILabel = {

  let label = CustomLabel.makeSimpleLabel(labelText: "Amber", labelColor: UIColor.darkGray, topography: UIFont.TextStyle.body )

  label.font = .systemFont(ofSize: 16, weight: .bold)
  return label
 }()

 let currentLocationIndicatorView : UIView = {
  let view = UIView()
  view.backgroundColor = .lightGray
  view.layer.cornerRadius = 3
  
  return view
 }()

 let destinationLocationIndicatorView : UIView = {
  let view = UIView()
  view.backgroundColor = .gray

  return view
 }()

 let linkingView : UIView = {
  let view = UIView()
  view.backgroundColor = .lightGray
  return view
 }()

 let currentLocationTextField : UITextField = {
  let tf = UITextField()
  tf.backgroundColor = .groupTableViewBackground
  
  tf.placeholder = "   Current Location"
  return tf
 }()

 let destLocationTF : UITextField = {
  let tf = UITextField()
  tf.placeholder = "Enter a destination.."
  tf.backgroundColor = .lightGray
  tf.returnKeyType = .search
  tf.font = UIFont.systemFont(ofSize: 14)

  tf.leftViewMode = .always
  tf.delegate = self
  tf.clearButtonMode = .whileEditing
  return tf
 }()
 
 
 
  // MARK:  Lifecycle
 
 
 
  // MARK:  Selectors
 
 @objc func handleBackButtonTapped() {
  delegate?.dismissLocationInputView()
 }

 
 
 // MARK:  init
 override init(frame: CGRect) {
  super.init(frame: frame)
  backgroundColor = .white
  addShadow()
  makeBackButton()
  makeTitleLabel()
  makeCurrentLocationIndicatorView()
  makeCurrentLocationTextField()
  makeDestionationIndicatorView()
  makeDestionationTextField()
  addSubview(linkingView)
  linkingView.centerX(inView: currentLocationIndicatorView)
  linkingView.anchor(top: currentLocationIndicatorView.bottomAnchor, bottom: destinationLocationIndicatorView.topAnchor, paddingTop: 6, paddingBottom: 6, paddingRight: 0, paddingLeft: 0, width: 0.75)
 }
 
 required init?(coder aDecoder: NSCoder) {
  fatalError("init(coder:) has not been implemented")
 }
 
 
  // MARK:  Makers


 fileprivate func makeDestionationTextField() {
  addSubview(destLocationTF)
  destLocationTF.centerY(inView: destinationLocationIndicatorView)
  destLocationTF.anchor(right: rightAnchor, left: destinationLocationIndicatorView.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingRight: 50, paddingLeft: 20,  height: 40)
 }

 fileprivate func makeDestionationIndicatorView() {
  addSubview(destinationLocationIndicatorView)
  destinationLocationIndicatorView.centerX(inView: backButton)
  destinationLocationIndicatorView.anchor(top: currentLocationIndicatorView.bottomAnchor, paddingTop: 50, paddingBottom: 0, paddingRight: 0, paddingLeft: 0, width: 6, height: 6)
 }

 fileprivate func makeCurrentLocationTextField() {
  addSubview(currentLocationTextField)
  currentLocationTextField.centerY(inView: currentLocationIndicatorView)
  currentLocationTextField.anchor(right: rightAnchor, left: currentLocationIndicatorView.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingRight: 50, paddingLeft: 20, height: 40)
 }


 fileprivate func makeCurrentLocationIndicatorView() {
  addSubview(currentLocationIndicatorView)
  currentLocationIndicatorView.centerX(inView: backButton)
  currentLocationIndicatorView.anchor(top: backButton.bottomAnchor, paddingTop: 24, paddingBottom: 0, paddingRight: 0, paddingLeft: 0, width: 6, height: 6)
 }

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


extension InputView: UITextFieldDelegate {
 func textFieldShouldReturn(_ textField: UITextField) -> Bool {
  guard let query = textField.text else { return false }
  delegate?.executeSearch(query: query)
  return true
 }
}

